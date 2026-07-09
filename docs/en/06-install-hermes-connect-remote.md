# Install Hermes Agent & Connect Remotely

<p align="center">
  <img src="https://hermes-agent.nousresearch.com/images/hermes-logo.svg" alt="Hermes Agent Logo" width="120"/>
</p>

<p align="center">
  <span style="display: inline-block; background: #28a745; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px; margin: 0 4px;">⏰ 15 minutes</span>
  <span style="display: inline-block; background: #6f42c1; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px; margin: 0 4px;">💰 Free</span>
  <span style="display: inline-block; background: #0366d6; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px; margin: 0 4px;">🔗 Tailscale VPN</span>
</p>

This is the final step — installing Hermes Agent inside your Codespace, setting up Tailscale for remote access, configuring dashboard authentication, and connecting from your local machine.

---

## 📋 Prerequisites

| Requirement | Detail |
|-------------|--------|
| ☁️ A running Codespace | Created in [Step 5](05-create-codespace.md) |
| 🔑 A Tailscale account | Free tier at [tailscale.com](https://tailscale.com) |
| 🖥️ Local machine | Windows, macOS, or Linux with Tailscale installed |
| 🌐 Basic terminal skills | Running commands, editing files |

---

## 🚀 Step-by-Step Guide

### Step 1: Open the Terminal in Your Codespace

Open your Codespace in GitHub. Inside the VS Code interface, open a new terminal:

- **Menu:** Terminal → New Terminal
- **Shortcut:** `` Ctrl+` `` (backtick)

You should see a bash prompt inside your Codespace container.

---

### Step 2: Install Hermes Agent

Run the install script:

```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
```

⏳ **Wait 2–5 minutes** while the script downloads and installs Hermes Agent along with its dependencies. You'll see logs scrolling by as each component is set up.

#### Optional: Restore a Backup from Your Local Machine

While the install runs, you can prepare a backup on your local machine:

1. **On your local machine**, open a terminal and run:
   ```bash
   hermes backup
   ```
2. This creates a `.zip` file (e.g., `hermes-backup-2025-01-01.zip`).
3. **Drag and drop** the `.zip` file into the Codespace **Explorer panel** (the file tree on the left side of VS Code).

> 💡 If you don't have a previous Hermes setup, skip this step — you'll start fresh.

---

### Step 3: Run the Setup Wizard (Blank Setup)

After installation finishes, Hermes automatically launches its **setup wizard**:

1. You'll see a terminal UI asking how you'd like to configure Hermes.
2. Select **Blank setup** → **Keep unchanged** → **Setup later**.
3. Exit the wizard temporarily by typing:
   ```
   /exit
   ```
   Or press **Ctrl+C**.

This gives you a clean, unconfigured Hermes installation that we'll connect to a remote gateway shortly.

---

### Step 4: Import a Backup (If You Have One)

If you dropped a backup `.zip` file into the Codespace earlier:

```bash
# Check that the file is there
ls -lh *.zip

# Import it
hermes import your-backup-file.zip
```

When prompted, type **`y`** to confirm the import.

> ⚠️ If you don't have a backup, skip this step — Hermes works fresh with no issues.

---

### Step 5: Install Tailscale — Remote Connectivity

#### What Is Tailscale and Why Do We Need It?

**Tailscale** is a VPN mesh network that creates a secure, private network between your devices. Think of it as a virtual LAN that works over the internet.

**The problem it solves:**

| Issue | Why It's a Problem |
|-------|-------------------|
| Codespaces don't have a fixed public IP | You can't connect to it reliably |
| Codespaces don't expose ports to the internet | Security restriction by design |
| GitHub Free doesn't include Nous subscription | No built-in remote access |
| Codespace IPs change on every restart | Can't bookmark an address |

**How Tailscale fixes this:**

| Feature | Benefit |
|---------|---------|
| Stable virtual IP (100.x.x.x) | One address that never changes |
| Mesh VPN network | All your devices see each other automatically |
| End-to-end encryption (WireGuard) | Your traffic stays private |
| Free tier | Up to 100 devices, no cost |

---

#### Install Tailscale on Your Codespace

In the Codespace terminal, run:

```bash
curl -fsSL https://tailscale.com/install.sh | sh
```

#### The Problem: Codespace Is a Docker Container

Codespaces run inside Docker containers, which do **not** have `systemd` (the Linux init system). This means `tailscaled` won't start automatically. The fix is straightforward — use **two terminals**.

**Terminal 1 — Start the daemon manually:**

```bash
sudo tailscaled --tun=userspace-networking &
```

> `--tun=userspace-networking` allows Tailscale to run inside a container without kernel-level TUN device access. This is essential for Codespaces.

**Terminal 2 — Authenticate:**

```bash
sudo tailscale up
```

You'll see an **authentication URL** printed in the terminal. Click the link (or Ctrl+click) to log in with your Tailscale account in your browser.

**Verify the connection:**

```bash
tailscale status
```

You should see your Codespace listed with an IP like `100.x.x.x` — note this address down, you'll need it later.

---

#### Install Tailscale on Your Local Machine

| Platform | Command |
|----------|---------|
| **Windows** | Download from [tailscale.com/download/windows](https://tailscale.com/download/windows) and install |
| **macOS** | `brew install --cask tailscale` |
| **Linux** | `curl -fsSL https://tailscale.com/install.sh | sh` |

After installing, **log in with the same Tailscale account** you used on the Codespace.

Verify:

```bash
tailscale status
```

Both your local machine and the Codespace should now appear in the list. They can see each other — the mesh network is alive.

---

### Step 6: Configure Dashboard Authentication

For security, Hermes requires a username, password, and secret to authenticate remote connections. Create an environment file:

```bash
mkdir -p ~/.hermes
```

Now set up the file. The easiest method uses **two terminals**:

**Terminal 1 — Start writing the file:**

```bash
cat >> ~/.hermes/.env <<'EOF'
HERMES_DASHBOARD_BASIC_AUTH_USERNAME=admin
HERMES_DASHBOARD_BASIC_AUTH_PASSWORD=your-strong-password-here
HERMES_DASHBOARD_BASIC_AUTH_SECRET=
EOF
```

Replace `your-strong-password-here` with a strong password you'll remember.

**Terminal 2 — Generate the secret:**

```bash
openssl rand -base64 32
```

Copy the output (a long base64 string), then go back to **Terminal 1** and paste it into the `HERMES_DASHBOARD_BASIC_AUTH_SECRET=` line (remove the newline after `=` so it reads `HERMES_DASHBOARD_BASIC_AUTH_SECRET=pasted-value`).

> 💡 If `openssl` isn't available, you can use any 32+ character random string instead. Even `uuidgen` output works.

**Secure the file:**

```bash
chmod 600 ~/.hermes/.env
```

**Verify the contents:**

```bash
cat ~/.hermes/.env
```

You should see all three variables set correctly.

> 🔒 **Security note:** `chmod 600` ensures only you can read this file. Never commit `.env` files to version control.

---

### Step 7: Restart Your Codespace

To apply everything cleanly:

1. **Get the Tailscale IP** if you haven't already:
   ```bash
   tailscale ip
   ```
   Save this `100.x.x.x` address.

2. **Close the remote connection:**
   - In VS Code: **File → Close Remote Connection**

3. **Reopen the Codespace:**
   - Go to [github.com/codespaces](https://github.com/codespaces)
   - Click on your Codespace name

When the Codespace restarts, the `.devcontainer/postStart.sh` script runs automatically, launching:
- `tailscaled` (Tailscale daemon)
- `hermes serve --port 9119` (Hermes server)

**Check that everything started correctly:**

```bash
cat /workspaces/codespaces-hermes-server/startup.log
```

You should see log entries confirming Hermes is running and listening on port 9119.

---

### Step 8: Connect from Your Local Machine

Now the moment of truth — connecting your local Hermes Desktop to the remote Codespace.

**Prerequisites on your local machine:**
- ✅ Tailscale installed and logged in (same account as the Codespace)
- ✅ Hermes Desktop installed
- ✅ You know your Codespace's Tailscale IP (`100.x.x.x`)

**Steps:**

1. Open **Hermes Desktop** on your local machine.
2. Go to **Settings → Gateway**.
3. Set **Remote URL** to:
   ```
   http://100.x.x.x:9119
   ```
   (Replace `100.x.x.x` with your actual Tailscale IP.)
4. Click **Authenticate** and enter the username and password you set in Step 6.
5. Click **Save and Reconnect**.

If everything is configured correctly, Hermes Desktop will connect to your Codespace server and you'll see it as the active backend.

---

#### Troubleshooting

| Symptom | Likely Cause | Fix |
|---------|-------------|-----|
| Connection refused | Hermes isn't running | `cat startup.log` — if empty, run manually: `bash .devcontainer/postStart.sh` |
| Timeout connecting | Tailscale not connected | Check `tailscale status` on both machines |
| Authentication failed | Wrong credentials | Re-check `~/.hermes/.env` on the Codespace |
| Can't ping 100.x.x.x | Different Tailscale accounts | Both machines must use the same account |
| Still connecting after 2 minutes | Service still starting | Wait 120 seconds — Hermes can be slow on first boot |

**Essential log files to check:**

```bash
cat /workspaces/codespaces-hermes-server/startup.log     # Startup sequence
cat ~/.hermes/logs/hermes.log                              # Hermes runtime logs
tailscale status                                           # Tailscale connectivity
```

**If your Codespace stopped:** Just reopen it from [github.com/codespaces](https://github.com/codespaces) — `postStart.sh` will pick up automatically.

**Manual fallback:** If the auto-start fails, SSH into your Codespace and run:

```bash
bash .devcontainer/postStart.sh
```

Then wait 120 seconds and try connecting again.

---

## 📊 Managing Core-Hours

GitHub Codespaces bills by **core-hours** — the number of CPU cores × hours the Codespace is running.

| Machine Type | Burn Rate | Monthly Budget (GitHub Free) |
|-------------|-----------|------------------------------|
| 2 cores — 8 GB | 2 core-hours/hour | ~60 hours |
| 4 cores — 16 GB | 4 core-hours/hour | ~30 hours |
| 8 cores — 32 GB | 8 core-hours/hour | ~15 hours |

### Tips to Stay Within the Free Tier

- ⏹️ **Always stop your Codespace** when you're not using it (File → Close Remote Connection)
- 🖥️ **2 cores is plenty** for running a personal Hermes server — don't upgrade
- ⏰ **Set idle timeout** as configured in [Step 4](04-configure-idle-timeout.md) to auto-stop
- 📊 **Monitor usage** at [github.com/settings/billing](https://github.com/settings/billing)

---

## ✅ Verification

Confirm everything is working:

```bash
# Check the Hermes version
hermes --version

# Send a test chat message
hermes chat -q "Hello, are you working?"
```

You should receive a response from your remote Hermes Agent.

---

## 🎉 Congratulations!

You've successfully:
- ✅ Installed Hermes Agent on GitHub Codespaces
- ✅ Set up Tailscale mesh VPN for secure remote access
- ✅ Configured dashboard authentication
- ✅ Connected from your local machine

Your personal AI backend is now running in the cloud — accessible from anywhere, at any time, with zero monthly cost.

---

## 📚 Navigation

| ← Previous | Up | 
|------------|----|
| [Step 5: Create a Codespace](05-create-codespace.md) | [Back to Guide Home](../../README.md) |

---

## 📊 GitHub Free vs Pro Comparison

| Feature | GitHub Free | GitHub Pro |
|---------|-------------|------------|
| Private repos | ✅ Unlimited | ✅ Unlimited |
| Collaborators on private repos | ✅ Up to 3 | ✅ Unlimited |
| Codespaces core-hours/month | **120 hours** | **180 hours** |
| GitHub Actions minutes/month | 2,000 min | 3,000 min |

> For running a personal Hermes Agent backend, **GitHub Free is more than enough** — 120 core-hours per month gives you ~60 hours of uptime with a 2-core machine.

---

<p align="center">
  <a href="05-create-codespace.md">← Previous: Create a Codespace</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="../../README.md">Back to Guide Home →</a>
</p>

<p align="center">
  <strong>Part 6 / 6 — 🎉 You've completed the setup!</strong>
</p>

---

<p align="center">
  <strong>⭐ Star this repo if you found this guide helpful!</strong>
</p>
