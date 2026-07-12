# Create a Codespace from Your Repository

<p align="center">
  <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Logo" width="120"/>
</p>

<p align="center">
  <span style="display: inline-block; background: #d29922; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px; margin: 0 4px;">⏰ 3 minutes</span>
  <span style="display: inline-block; background: #6f42c1; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px; margin: 0 4px;">💰 Free (core-hours only)</span>
</p>

Step-by-step guide to creating your first GitHub Codespace — a cloud development environment you can access from anywhere.

---

## 📋 Prerequisites

| Requirement | Details |
|-------------|---------|
| ✅ GitHub account | Created and logged in (see [Part 1](01-create-github-account.md)) |
| ✅ Private repository | Created (see [Part 2](02-create-repository.md)) |
| ✅ .devcontainer configured | Config files in place (see [Part 3](03-setup-devcontainer.md)) |
| ✅ Idle timeout set | 240 minutes configured (see [Part 4](04-configure-idle-timeout.md)) |

---

## 🚀 Steps

### Step 1: Go to Your Repository

Open your browser and navigate to your repository on GitHub.

### Step 2: Open the Codespaces Tab

1. Click the green **Code** button
2. Select the **Codespaces** tab

### Step 3: Create the Codespace

Click **Create codespace on main** (or **New codespace** if you've created one before).

> 💡 The default machine is **2 core — 8GB RAM**. To change it after creation, go to **https://github.com/codespaces** → click **`...`** → **Change machine type**. Free tier only offers 2 options: 2-core (8GB) or 4-core (8GB).

> ⏳ **Wait 30 seconds to 2 minutes** while GitHub provisions a virtual machine. The first launch is the slowest because it builds the container image; subsequent launches are faster thanks to caching.

---

## 🖥️ Codespace Interface

Once the Codespace loads, you'll see a full VS Code environment running in your browser:

| Area | Location | Purpose |
|------|----------|---------|
| 📁 **Explorer** | Left sidebar | File tree — browse and manage project files |
| ✏️ **Editor** | Center | Code editor — write and edit your code |
| 💲 **Terminal** | Bottom panel | Run shell commands — install software, run scripts |
| 🌿 **Branch name** | Bottom-left corner | Shows current branch (e.g., `main`) |

> 💡 **Tip:** You can open multiple terminal tabs by clicking the **+** icon in the terminal panel. Use the split terminal button to view terminals side by side.

---

## ✅ Verification Checks

Run these commands in the terminal to verify your environment:

| Command | What to check |
|---------|---------------|
| `uname -a` | Linux kernel version and architecture |
| `df -h / \| tail -1` | Disk space (~30 GB available) |
| `python3 --version` | Python version (usually 3.x) |
| `git --version` | Git version |

```bash
# Quick sanity check — run all at once
uname -a && df -h / | tail -1 && python3 --version && git --version
```

> If these commands produce expected output, your Codespace is ready to use.

---

## 🎮 Basic Operations

| Action | How to do it |
|--------|--------------|
| 🛑 **Stop** | File → Close Remote Connection (or press `F1` → "Codespaces: Stop Current Codespace") |
| 🔄 **Restart** | Code → Codespaces → click your Codespace name |
| 🗑️ **Delete** | Code → Codespaces → `...` (more options) → Delete |
| 💻 **Open in VS Code Desktop** | Code → Codespaces → `...` → Open in VS Code Desktop |

> 💡 **Tip:** Opening in VS Code Desktop gives you a richer experience with your local extensions, themes, and keybindings — great for longer coding sessions.

---

## 📝 Important Notes

| Item | Details |
|------|---------|
| ⏱️ **Idle timeout** | 240 minutes (if you followed [Part 4](04-configure-idle-timeout.md)) |
| 💾 **Storage** | ~30 GB per Codespace |
| 🌐 **Network** | If you lose internet, just refresh the page — your session resumes |
| 💰 **Core-hours** | 120 hours/month on the Free tier (2-core machine = 60 hours of wall-clock time) |

### 💾 Disk Space Breakdown

The free-tier Codespace comes with a **32 GB disk**, but not all of it is available for your files:

| Component | Size | Notes |
|-----------|------|-------|
| 💻 **VS Code + extensions** | ~15 GB | Pre-installed on every restart — **can't remove**, it's part of the Codespace image |
| 📂 **Available for your data** | ~17 GB | Enough for Hermes + dependencies + projects |
| ⚡ **/tmp (SSD scratch)** | **~44 GB** | Very fast SSD, but **cleared on shutdown** — great for temporary file processing |

> 💡 **Tip:** For large file operations (downloads, extraction, compilation), use `/tmp` — it's 2× larger than the main disk and much faster. Just copy your results to the working directory before shutting down.

---

## 🎯 Summary

| Item | Value |
|------|-------|
| ✅ Result | A running cloud development environment |
| 🔗 Access | Via browser or VS Code Desktop |
| 💵 Cost | Free (billed to GitHub core-hours) |
| ⏱️ First launch | ~30 sec – 2 min |
| 📦 Storage | ~30 GB |

---

## 📚 Next Part

➡️ **[Install Hermes & Connect Remote](06-install-hermes-connect-remote.md)** — Set up Hermes Agent server + Tailscale VPN for remote access.

---

<p align="center">
  <a href="04-configure-idle-timeout.md">← Previous: Configure Idle Timeout</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="06-install-hermes-connect-remote.md">Next → Install Hermes & Connect Remote</a>
</p>
