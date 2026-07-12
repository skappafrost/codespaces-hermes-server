# Set up .devcontainer for Codespace

In this section, you'll create **3 configuration files** inside the `.devcontainer/` directory of your GitHub repository. These files tell Codespace how to automatically install Hermes Agent and launch the server every time you start it.

---

## 📖 What is .devcontainer?

`.devcontainer` is a special directory in your GitHub repository. When you create a Codespace, GitHub automatically detects this directory and uses its configuration to set up the development environment.

It consists of 3 main components:

| File | Role |
|------|------|
| `devcontainer.json` | Main config file: declares ports, VS Code extensions, and scripts to run |
| `postCreate.sh` | Runs **once** when the Codespace is first created — installs Hermes Agent |
| `postStart.sh` | Runs **every time** the Codespace starts (including after stop/restart) — launches Tailscale + Hermes server |

> 💡 **How it works:** When a Codespace starts, GitHub reads `devcontainer.json`, finds the `postCreateCommand` and `postStartCommand` entries, and automatically calls the corresponding `.sh` scripts.

---

## 🛠️ Creating the 3 Files on GitHub Web UI

You'll work directly in the GitHub web interface — no local setup required.

### Step 1: Open Your Repository

1. Open your browser and sign in to [github.com](https://github.com)
2. Navigate to the repository you created in the previous step (e.g. `codespaces-hermes-server`)

### Step 2: Create the `.devcontainer/` Directory

1. Click **Add file** → **Create new file**
2. In the "Name your file..." field, type: `.devcontainer/devcontainer.json`
   - GitHub automatically creates the `.devcontainer/` directory when you use a `/` in the filename
3. Paste the content below into the editor

### Step 3: Create `devcontainer.json`

```json
{
  "postCreateCommand": "bash .devcontainer/postCreate.sh",
  "postStartCommand": "bash .devcontainer/postStart.sh",
  "forwardPorts": [9119],
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-azuretools.vscode-docker",
        "eamodio.gitlens",
        "mhutchie.git-graph"
      ],
      "settings": {
        "terminal.integrated.defaultProfile.linux": "bash"
      }
    }
  }
}
```

**Field explanations:**

| Field | Purpose |
|-------|---------|
| `postCreateCommand` | Command run **once** on first Codespace creation — calls the Hermes install script |
| `postStartCommand` | Command run **every time** the Codespace starts — calls the Tailscale + Hermes launcher |
| `forwardPorts` | Port 9119 is opened so you can access the Hermes server remotely |
| `customizations.vscode.extensions` | VS Code extensions installed automatically: Docker, GitLens, Git Graph |
| `customizations.vscode.settings` | Default terminal profile settings for VS Code |

4. At the bottom, select **"Commit directly to the main branch"** and click **Commit new file**

### Step 4: Create `postCreate.sh`

Repeat: **Add file** → **Create new file** with the path `.devcontainer/postCreate.sh`

```bash
#!/usr/bin/env bash
# =============================================================================
# postCreate.sh — Hermes Agent Installation (one-time setup)
# Runs once when the Codespace is first created.
# =============================================================================
set -euo pipefail

WORKSPACE="$(pwd)"
LOG_DIR="$WORKSPACE"
TIMESTAMP=$(date)

echo "=== postCreate.sh started at $TIMESTAMP === " >> "$LOG_DIR/setup.log"

# ---------------------------------------------------------------------------
# Install Hermes Agent via pip (avoids interactive setup wizard)
# ---------------------------------------------------------------------------
echo "[INFO] Installing Hermes Agent via pip..." >> "$LOG_DIR/setup.log"
pip install hermes-agent
echo "[INFO] Hermes Agent installed." >> "$LOG_DIR/setup.log"

# ---------------------------------------------------------------------------
# Initialize Hermes config (Blank Slate) — prevents wizard on first serve
# ---------------------------------------------------------------------------
export PATH="$PATH:$HOME/.local/bin"
mkdir -p "$HOME/.hermes"

cat > "$HOME/.hermes/config.yaml" << 'HERMESCFG'
model:
  default: ""
display:
  interface: cli
agent:
  max_turns: 90
HERMESCFG
echo "[INFO] Hermes config initialized (Blank Slate)." >> "$LOG_DIR/setup.log"
hermes --version >> "$LOG_DIR/setup.log" 2>&1 || true

# ---------------------------------------------------------------------------
# Install Tailscale (needed for remote access)
# ---------------------------------------------------------------------------
echo "[INFO] Installing Tailscale..." >> "$LOG_DIR/setup.log"
curl -fsSL https://tailscale.com/install.sh | sh
echo "[INFO] Tailscale installed." >> "$LOG_DIR/setup.log"

echo "=== postCreate.sh completed === " >> "$LOG_DIR/setup.log"
```

**What this script does:**
- Logs the start time
- Installs Hermes Agent via pip (avoids interactive setup wizard)
- Creates minimal config (Blank Slate) to skip first-run wizard

> ⚠️ This script runs **only once** when the Codespace is first created — it does **not** run on restart.

Commit this file.

### Step 5: Create `postStart.sh`

**Add file** → **Create new file** with the path `.devcontainer/postStart.sh`

```bash
#!/usr/bin/env bash
# =============================================================================
# postStart.sh — Launch Hermes Server + Tailscale (every Codespace restart)
# Runs every time the Codespace starts (including after stop/start).
# =============================================================================
set -euo pipefail

WORKSPACE="$(pwd)"
LOG_DIR="$WORKSPACE"
TIMESTAMP=$(date)

echo "=== postStart.sh started at $TIMESTAMP ===" > "$WORKSPACE/check_startup.txt"

export PATH="$PATH:$HOME/.local/bin"

# ---------------------------------------------------------------------------
# START TAILSCALE DAEMON
# ---------------------------------------------------------------------------
echo "[INFO] Starting tailscaled..." >> "$LOG_DIR/startup.log"

nohup sudo tailscaled \
    --tun=userspace-networking \
    > "$LOG_DIR/tailscale.log" 2>&1 &

# ---------------------------------------------------------------------------
# WAIT FOR TAILSCALE PROCESS
# ---------------------------------------------------------------------------
echo "[INFO] Waiting for tailscaled process..." >> "$LOG_DIR/startup.log"

for _ in {1..30}; do
    if pgrep tailscaled >/dev/null; then
        echo "[INFO] tailscaled is running." >> "$LOG_DIR/startup.log"
        break
    fi
    sleep 1
done

# ---------------------------------------------------------------------------
# START HERMES SERVER (guard: don't spawn duplicate)
# ---------------------------------------------------------------------------
echo "[INFO] Starting Hermes server..." >> "$LOG_DIR/startup.log"

if ! pgrep -f "hermes serve" >/dev/null; then
    setsid \
    hermes serve \
        --host 127.0.0.1 \
        --port 9119 \
        >> "$LOG_DIR/hermes.log" 2>&1 \
        < /dev/null &
fi

sleep 5

# ---------------------------------------------------------------------------
# VERIFY HERMES IS RUNNING
# ---------------------------------------------------------------------------
if pgrep -f "hermes serve" >/dev/null; then
    echo "[SUCCESS] Hermes server started successfully." >> "$LOG_DIR/startup.log"
else
    echo "[ERROR] Hermes server failed to start." >> "$LOG_DIR/startup.log"
fi
```

**What this script does:**

| Step | Description |
|------|-------------|
| 🚀 Start tailscaled | Launches the Tailscale daemon in userspace networking mode |
| 👁️ Wait for Tailscale | Confirms the tailscaled process is actually running |
| 🤖 Start Hermes | Runs `hermes serve` in the background (guard: skips if already running) |
| ✅ Verify | Confirms Hermes server started successfully |

> 🔐 **Port 9119** is the default Hermes Server port. You'll use this port when connecting from Hermes Desktop later.

Commit this file.

---

> ⚠️ **First-time startup note:** When you create a new Codespace, `postCreate.sh` installs Hermes + Tailscale, and `postStart.sh` also runs on the very first boot. If you see `[ERROR] Hermes server failed to start` in the logs, don't worry — this can happen if:
> - The Hermes install in `postCreate.sh` hasn't finished yet
> - You haven't created `~/.hermes/.env` with auth credentials yet (you'll do that later)
> 
> **Just continue with the guide.** After you complete the remaining steps (auth setup + Tailscale login), restart the Codespace once and everything will work.

---

## 📂 Resulting Directory Structure

After creating all 3 files, your repository should look like this:

```text
codespaces-hermes-server/
└── .devcontainer/
    ├── devcontainer.json       # Config: calls postCreate.sh + postStart.sh
    ├── postCreate.sh           # Installs Hermes Agent (one-time)
    └── postStart.sh            # Starts Tailscale + Hermes serve (every restart)
```

---

## ✅ Quick Check

After committing all 3 files, verify on your GitHub repository:

1. ✅ The `.devcontainer/` directory is visible in the repo
2. ✅ `devcontainer.json` contains valid JSON
3. ✅ `postCreate.sh` and `postStart.sh` exist and are executable
4. ✅ All 3 files are in the `main` branch

> 💡 **Tip:** On GitHub's web interface, `.sh` files appear with a terminal icon and green color — that means they have executable permissions.

---

## 🔜 Next Step

With `.devcontainer` configured, the next step is to **configure the Idle Timeout** so your Codespace doesn't shut down too early.

---

<!-- Navigation -->
<p align="center">
  <a href="02-create-repository.md">← Create Repository</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="04-configure-idle-timeout.md">Configure Idle Timeout →</a>
</p>

<p align="center">
  <strong>Part 3 / 7</strong>
</p>
