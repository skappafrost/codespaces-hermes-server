# Codespace CLI Management with GitHub CLI

> ⏱️ **Time:** 10 minutes &nbsp;|&nbsp; 🎯 **Goal:** Install GitHub CLI and create shortcuts to start/stop your Codespace instantly

---

## 📌 Why GitHub CLI?

After setting up your Hermes server on Codespace, you'll regularly need to:
- 🔄 **Start Codespace** when you need Hermes
- ⏹️ **Stop Codespace** to save core-hours
- 📋 **Check status** — is your Codespace running or shut down?

Going through the GitHub web interface every time is slow. **GitHub CLI** (`gh`) lets you do everything from the terminal — faster, more convenient, and scriptable.

---

## 🚀 Step-by-Step Guide

### Step 1: Install GitHub CLI

#### 🪟 Windows (Git Bash / PowerShell)

```bash
# Option 1 — winget (Windows 10/11)
winget install GitHub.cli

# Option 2 — Download from website
# Visit https://cli.github.com/ → Download → Install
```

#### 🍎 macOS

```bash
brew install gh
```

#### 🐧 Linux (Ubuntu/Debian)

```bash
# Using apt
(type -p curl >/dev/null || sudo apt-get install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update
sudo apt-get install gh -y
```

#### 🐧 Linux (CentOS/Fedora/RHEL)

```bash
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh -y
```

#### 🐧 Codespace (pre-installed)

> 💡 **Great news:** GitHub CLI is **pre-installed** in every Codespace! No installation needed.

Verify:

```bash
gh --version
# Sample output: gh version X.Y.Z (2025-...)
```

---

### Step 2: Authenticate GitHub CLI

> ⚠️ **One-time setup** — you won't need to re-authenticate.

```bash
gh auth login
```

Follow the prompts:

1. Select **GitHub.com**
2. Select **HTTPS** protocol
3. Choose **Login with a web browser** (easiest)
4. Copy the 8-digit code displayed
5. Press **Enter** to open your browser
6. Paste the code → **Continue** → **Authorize GitHub CLI**
7. ✅ **Done!** Terminal shows `✓ Authentication complete.`

> 💡 **Tip:** If you're inside a Codespace (no GUI browser), choose **Paste an authentication token** and use a Personal Access Token (see [Appendix](appendix-local-git-setup.md)).

---

### Step 3: Essential Codespace CLI Commands

Here are the `gh` commands you'll use regularly:

#### 👁️ List Codespaces

```bash
gh codespace list
```

Sample output:

```
NAME                         DISPLAY NAME     REPOSITORY                          BRANCH  STATE     CREATED AT
codespaces-hermes-server-xxx codespaces-hermes codespaces-hermes-server/codespaces main    Available 2025-07-01
```

> `STATE = Available` ➜ running. `STATE = Shutdown` ➜ stopped.

#### ℹ️ View Codespace Details

```bash
gh codespace view
```

If you have multiple Codespaces, it will prompt you to select one.

#### ▶️ Start Codespace

```bash
gh codespace create --repo codespaces-hermes-server
```

> ⏳ Takes about 30 seconds to 2 minutes. Hermes will auto-start via `postStart.sh`.

#### ⏹️ Stop Codespace

```bash
gh codespace stop
```

> 💡 **Save core-hours:** Always run this when you're done using Hermes.

#### 🗑️ Delete Codespace (when no longer needed)

```bash
gh codespace delete
```

> ⚠️ Deleting a Codespace will lose all data on it. **Hermes config, skills, memory — all gone!** Only delete if you've backed up.

#### 🔐 SSH into Codespace

```bash
gh codespace ssh
```

> Opens a direct SSH session into your Codespace — great for debugging or manual commands.

#### 🔌 Manage Ports

```bash
gh codespace ports
# List all open ports

gh codespace ports forward 9119:9119
# Forward port 9119 from Codespace to local machine
```

#### 📜 View Logs

```bash
gh codespace logs
# Shows Codespace logs (useful for debugging)
```

---

### Step 4: Create Start/Stop Shortcuts

Instead of typing long commands every time, create a **script** or **alias** that does it in one word.

#### 🪟 Windows — Batch Script

Create `codespace-start.bat`:

```batch
@echo off
echo === Starting Codespace Hermes Server ===
gh codespace create --repo codespaces-hermes-server
echo === Done! Hermes will auto-start via postStart.sh ===
pause
```

Create `codespace-stop.bat`:

```batch
@echo off
echo === Stopping Codespace Hermes Server ===
gh codespace stop
echo === Done! Core-hours saved. ===
pause
```

> Place these on your desktop or in `C:\\Users\\<name>\\` for quick access.

#### 🪟 Windows — Advanced PowerShell Script

Create `codespace-manager.ps1`:

```powershell
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("start","stop","status","restart")]
    [string]$Action
)

$CODESPACE_NAME = "codespaces-hermes-server"

switch ($Action) {
    "start" {
        Write-Host "🔄 Starting Codespace..." -ForegroundColor Cyan
        gh codespace create --repo $CODESPACE_NAME
        Write-Host "✅ Codespace started!" -ForegroundColor Green
    }
    "stop" {
        Write-Host "⏹️ Stopping Codespace..." -ForegroundColor Yellow
        gh codespace stop
        Write-Host "✅ Codespace stopped. Core-hours saved!" -ForegroundColor Green
    }
    "status" {
        Write-Host "📋 Checking status..." -ForegroundColor Cyan
        gh codespace list
    }
    "restart" {
        Write-Host "🔄 Restarting Codespace..." -ForegroundColor Cyan
        gh codespace stop
        Start-Sleep -Seconds 5
        gh codespace create --repo $CODESPACE_NAME
        Write-Host "✅ Codespace restarted!" -ForegroundColor Green
    }
}
```

Usage:

```powershell
.\codespace-manager.ps1 start     # Start
.\codespace-manager.ps1 stop      # Stop
.\codespace-manager.ps1 status    # Check
.\codespace-manager.ps1 restart   # Restart
```

#### 🐧 Linux/macOS — Shell Script

Create `codespace.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

CODESPACE_REPO="codespaces-hermes-server"
ACTION="${1:-status}"

case "$ACTION" in
    start)
        echo "🔄 Starting Codespace..."
        gh codespace create --repo "$CODESPACE_REPO"
        echo "✅ Codespace started. Hermes will auto-start."
        ;;
    stop)
        echo "⏹️ Stopping Codespace..."
        gh codespace stop
        echo "✅ Codespace stopped. Core-hours saved!"
        ;;
    status)
        echo "📋 Codespace status:"
        gh codespace list
        ;;
    restart)
        echo "🔄 Restarting Codespace..."
        gh codespace stop
        sleep 5
        gh codespace create --repo "$CODESPACE_REPO"
        echo "✅ Codespace restarted!"
        ;;
    ssh)
        echo "🔐 Opening SSH session..."
        gh codespace ssh
        ;;
    logs)
        echo "📜 Fetching logs..."
        gh codespace logs
        ;;
    *)
        echo "Usage: $0 {start|stop|status|restart|ssh|logs}"
        exit 1
        ;;
esac
```

Make it executable and add to PATH:

```bash
chmod +x codespace.sh
sudo mv codespace.sh /usr/local/bin/codespace-hermes
# Now you can use:
codespace-hermes start
codespace-hermes stop
codespace-hermes status
```

#### 🐧 Linux/macOS — Aliases (lightning fast)

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# =====================
# Codespace Hermes Shortcuts
# =====================
alias cs-start='gh codespace create --repo codespaces-hermes-server'
alias cs-stop='gh codespace stop'
alias cs-status='gh codespace list'
alias cs-restart='gh codespace stop && sleep 3 && gh codespace create --repo codespaces-hermes-server'
alias cs-ssh='gh codespace ssh'
alias cs-logs='gh codespace logs'
```

Then:

```bash
source ~/.bashrc  # or open a new terminal

# Use:
cs-start      # Start Codespace
cs-stop       # Stop Codespace
cs-status     # Check status
cs-restart    # Restart Codespace
cs-ssh        # SSH into Codespace
```

---

### Step 5: Auto-Check Script (Advanced)

Create `codespace-auto-connect.sh` — a smart script that starts the Codespace if it's off, waits for Hermes, and prints the connection info:

```bash
#!/usr/bin/env bash
set -euo pipefail

CODESPACE_REPO="codespaces-hermes-server"
HERMES_PORT=9119

echo "🔍 Checking Codespace status..."

# Check if Codespace is running
CODESPACE_STATUS=$(gh codespace list --json state -q '.[0].state' 2>/dev/null || echo "none")

if [ "$CODESPACE_STATUS" = "Available" ]; then
    echo "✅ Codespace is already running."
elif [ "$CODESPACE_STATUS" = "Shutdown" ] || [ "$CODESPACE_STATUS" = "none" ]; then
    echo "🔄 Codespace is offline. Starting now..."
    gh codespace create --repo "$CODESPACE_REPO"
    echo "⏳ Waiting for Hermes to start..."
    sleep 30
else
    echo "⚠️ Unknown status: $CODESPACE_STATUS"
    gh codespace list
fi

# Get Tailscale IP or local info
TAILSCALE_IP=$(tailscale ip 2>/dev/null || echo "")

if [ -n "$TAILSCALE_IP" ]; then
    echo "🌐 Hermes server at: http://$TAILSCALE_IP:$HERMES_PORT"
else
    echo "🌐 Hermes server might be at localhost:$HERMES_PORT"
fi

echo "🎉 Done! Open Hermes Desktop or CLI to connect."
```

> This script is smart: if the Codespace is already running it uses it; if it's off, it starts it and waits for Hermes to come online.

---

## 🧠 Tips & Troubleshooting

| Situation | Solution |
|-----------|----------|
| **Keep forgetting to stop — burning core-hours** | Put `cs-stop` alias at the top of your `~/.bashrc` so it's always visible |
| **"no codespace" error** | Run `gh codespace create --repo codespaces-hermes-server` first |
| **`gh` command not found** | Upgrade: `gh upgrade` or reinstall |
| **Multiple Codespaces running** | Use `gh codespace list` to find names, `gh codespace stop -c <name>` to stop specific one |
| **SSH without remembering the name** | `gh codespace ssh` shows an interactive menu |
| **Accidentally deleted Codespace** | Cannot undo. Always backup Hermes before deleting (`hermes backup`) |

---

## 📊 Browser vs CLI Comparison

| Action | Browser | GitHub CLI |
|--------|---------|------------|
| Start Codespace | Repo → Code → Codespaces → click name | `cs-start` (1 second) |
| Stop Codespace | File → Close Remote → Stop | `cs-stop` (1 second) |
| Check status | Visit repo → Code → Codespaces | `cs-status` (1 second) |
| SSH into Codespace | Not possible from browser | `cs-ssh` (1 second) |
| View logs | Must open Codespace → terminal | `cs-logs` (1 second) |

> 🚀 CLI is **10-50x faster** than using the browser!

---

## 📚 Next Steps

- ⬅️ [Part 6: Install Hermes & Connect Remote](06-install-hermes-connect-remote.md)
- 📘 [Appendix: Local Git Setup](appendix-local-git-setup.md)

---

<!-- Navigation -->
<p align="center">
  <a href="06-install-hermes-connect-remote.md">← Part 6: Connect Remote</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="index.md">📖 Back to Guide Home</a>
</p>

<p align="center">
  <strong>Part 7 / 7 — 🎉 Bonus: manage your Codespace like a pro!</strong>
</p>
