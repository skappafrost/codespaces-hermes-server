# Create a Codespace from Your Repository

> ⏱️ **Time:** 3 minutes &nbsp;|&nbsp; 🎯 **Goal:** Initialize your first Codespace and get familiar with the interface

---

## 📌 Before You Begin

Make sure you have completed the previous steps:

| # | Step | Status |
|---|------|--------|
| 1 | [Create a GitHub Account](01-create-github-account.md) | ✅ Complete |
| 2 | [Create a Repository](02-create-repository.md) | ✅ Complete |
| 3 | [Configure .devcontainer](03-setup-devcontainer.md) | ✅ Complete |
| 4 | [Configure Idle Timeout](04-configure-idle-timeout.md) | ✅ Complete (important!) |

> ⚠️ **Haven't configured Idle Timeout yet?** Stop and do [Step 4](04-configure-idle-timeout.md) first — if you create the Codespace and configure it afterwards, you'll have to restart the Codespace for the changes to apply.

---

## 🚀 Steps to Create a Codespace

### Step 1: Navigate to Your Repository

1. Sign in to [github.com](https://github.com)
2. In the left sidebar, click on the repository you created in Step 2 (e.g., `codespaces-hermes-server`)
3. The repository page will appear with tabs like **Code**, **Issues**, **Pull requests**, etc.

### Step 2: Open the Codespaces Tab

1. Click the green **Code** button (top right)
2. In the dropdown that appears, click the **Codespaces** tab
3. Click **Create codespace on main** (or your default branch name)

### Step 3: Create the Codespace

Click **Create codespace on main** (or **New codespace** if you've created one before).

> 💡 By default, the Codespace uses a **2 core — 8GB RAM** machine. To change it after creation, go to **https://github.com/codespaces** → click **`...`** → **Change machine type**. The free tier only offers 2 options: 2-core (8GB) or 4-core (8GB).

> ⏳ Wait **30 seconds to 2 minutes** for GitHub to provision the virtual machine. The first time takes the longest because it needs to build the Docker image; subsequent starts are faster thanks to caching.

##### 📀 Disk Space Information

The free-tier Codespace comes with **32 GB of hard drive space**, but here's what you need to know:

| Item | Capacity | Notes |
|------|----------|-------|
| **💻 VS Code + extensions** | ~15 GB | VS Code is automatically installed on every restart — **cannot be removed** because it's part of the Codespace image |
| **📂 Available for code & data** | ~17 GB | Enough for Hermes + dependencies + project files |
| **⚡ /tmp (super-fast SSD)** | **~44 GB** | Very high speed, but **cleared when the Codespace shuts down** — use for temporary file processing |

> 💡 **Tip:** If you need to process large files (download, extract, compile), use the `/tmp` directory — it's twice as large as the main disk and much faster! Just copy the results to your working directory before shutting down the Codespace.

### Step 4: Wait for the Codespace to Initialize

After clicking create, the Codespace will begin initializing. This process includes:

1. **Provisioning VM** (~30 seconds) — GitHub allocates the virtual machine
2. **Cloning repository** (~10 seconds) — Code is cloned into the container
3. **Running devcontainer** (~1-3 minutes) — Docker builds the image according to `.devcontainer/devcontainer.json`
4. **Running postCreate.sh** (~2-5 minutes) — Installs Hermes Agent and dependencies

> ⏳ Total wait time: **5-10 minutes** depending on network speed. This only happens **once** — subsequent Codespace starts will be much faster.

> 🔴 **SERIOUS WARNING:** While waiting, **DO NOT** click any button like "Cancel", "Stop", "Close", "Skip", "Remind me later", or close the browser tab. If you interrupt the process mid-way:
> - `postCreate.sh` will **not** run → Hermes and Tailscale will **not be installed**
> - The Codespace will start but without Hermes → wasted time debugging
> - **The only fix** is to delete this Codespace and create a new one from scratch
> 
> **Be patient and wait until you see the terminal screen** with the command prompt (a line like `@your-codespace-name ➜ /workspaces/...`) — that's when you can start working.

---

## 🖥️ Getting Familiar with the Codespace Interface

Once the Codespace is ready, you'll see the Visual Studio Code interface in your browser with the following components:

```
┌─────────────────────────────────────────────────────┐
│  🌐 codespaces-hermes-server  ● main  ───────────── │
├──────────┬──────────────────────────────────────────┤
│ 🔍      │                                          │
│ 📁      │   Welcome - VS Code                      │
│ 📂      │   ────────────────────────────            │
│ EXPLORER│   Start → Open Folder → Clone Repository │
│ ├─ .devcontainer    │                              │
│ │  ├─ devcontainer.json                            │
│ │  ├─ postCreate.sh │                              │
│ │  └─ postStart.sh  │                              │
│ ├─ docs/            │                              │
│ ├─ .gitignore       │                              │
│ ├─ LICENSE          │                              │
│ └─ README.md        │                              │
│                      │                              │
│                      │                              │
├──────────────────────┴──────────────────────────────┤
│ ⚡ bash ● codespace@main:~$ ▍                       │
└─────────────────────────────────────────────────────┘
```

### Main Areas

| Area | Location | Function |
|------|----------|----------|
| **🔍 Activity Bar** | Left edge | Icons: Explorer, Search, Source Control, Extensions |
| **📁 Explorer (Sidebar)** | Left side | Shows the repository file tree |
| **📝 Editor** | Center | Where you view and edit code |
| **⚡ Terminal** | Bottom | Command line for running Bash commands |
| **🌿 Branch** | Bottom-left corner | Shows current branch (`main`) |
| **🔗 Ports** | Bottom-right corner | Manage port forwarding |

---

## ✅ Verification Checks

Open the **Terminal** in Codespace (if not already open, press `` Ctrl+` ``) and run the following commands:

### System Checks

```bash
# Check operating system information
uname -a
```
**Expected result:** Linux kernel information — the Codespace runs on a Linux container (usually Ubuntu).

```bash
# Check disk space
df -h
```
**Expected result:** Total capacity ~**30GB** (see the Important Notes section below).

### Developer Tools Checks

```bash
# Check Python
python3 --version
```
**Expected result:** `Python 3.x.x` (latest Python version).

```bash
# Check Git
git --version
```
**Expected result:** `git version 2.x.x`.

```bash
# Check Node.js (usually pre-installed)
node --version
npm --version
```

### Hermes Agent Check

```bash
# Check if Hermes is installed (if postCreate.sh has finished running)
hermes --version
```
**Expected result:** Displays the Hermes Agent version.

> 💡 If `hermes --version` doesn't work yet, `postCreate.sh` may still be running. Wait a few more minutes and try again.

---

## 🎮 Codespace Management Operations

### Codespace Dashboard

From the Codespace interface, you can perform the following operations:

| Action | How to do it | Result |
|--------|-------------|--------|
| **⏹️ Stop** | Press `Ctrl+Shift+P` → type "Codespaces: Stop" | Stops the Codespace, frees resources |
| **🔄 Restart** | `Ctrl+Shift+P` → "Codespaces: Restart" | Restarts the Codespace (applies config changes) |
| **🗑️ Delete** | Go to [github.com/codespaces](https://github.com/codespaces) → click ⋮ → Delete | Permanently deletes the Codespace |
| **💻 Open in VS Code** | Click "Open in VS Code" at the bottom left | Opens the Codespace in VS Code Desktop |

### From the GitHub Page

You can also manage all your Codespaces at: **[github.com/codespaces](https://github.com/codespaces)**

This page shows a list of all your Codespaces with their status:

| Status | Meaning | Core-hours |
|--------|---------|------------|
| 🟢 **Active** | Running | Consuming core-hours |
| 🟡 **Inactive** | Stopped but not deleted | Not consuming core-hours |
| 🔴 **Shutdown** | Turned off due to idle timeout | Not consuming core-hours |
| ⚪ **Deleted** | Deleted, no longer exists | 0 |

---

## 📋 Important Information to Remember

### Technical Specifications

| Parameter | Value | Notes |
|-----------|-------|-------|
| **⏱️ Idle Timeout** | 30 minutes (default) → **240 minutes** (after configuration) | Configured in [Step 4](04-configure-idle-timeout.md) |
| **💾 Storage capacity** | ~30 GB | Enough for Hermes Agent + code + dependencies |
| **🌐 Network** | Container has Internet access | Required for downloading packages and connecting to Tailscale |
| **⏰ Core-hours (Free)** | 120 hours/month | 2-core Codespace: ~60 hours of actual runtime per month |
| **🔒 Privacy** | Isolated container, only you have access | Each Codespace is a separate container |
| **📂 Persistent storage** | Data in `/home/codespace` is preserved between stop/start cycles | Only lost when you Delete the Codespace |
| **🔌 Port forwarding** | Built-in, public or private | Used for the Hermes API server |

### Important Notes

| ⚠️ | Content |
|-----|---------|
| 🕒 | **Idle timeout takes effect after configuration** — if you create the Codespace before setting it up, you need to Restart the Codespace for it to apply |
| 💾 | **30GB is total capacity** — includes OS, tools, code, and packages. Hermes + dependencies only take a few hundred MB, plenty of room |
| 🌐 | **Codespace has Internet access** — you can install any additional tools via apt, pip, npm, etc. |
| ⏰ | **120 core-hours/month** with 2-core = max 60 hours of continuous runtime per month. The 240-minute idle timeout helps avoid waste |

---

## 🔍 Common Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| "Create codespace on main" button is greyed out / missing | Code hasn't been pushed to the repo | Push the `.devcontainer/*` files to the `main` branch |
| Codespace fails to initialize | Core-hour quota exhausted | Check at [github.com/settings/billing](https://github.com/settings/billing) |
| postCreate.sh errors | Incorrect file structure | Double-check your `.devcontainer/postCreate.sh` file |
| Terminal not showing | Terminal not opened yet | Press `` Ctrl+` `` or go to View → Terminal |
| Codespace is slow | First-time initialization | Wait 5-10 minutes, subsequent starts will be faster |
| Sudden connection loss | Unstable network | Refresh the page; the Codespace retains its state |

---

## 🎉 Congratulations!

You have successfully created your first Codespace and are now ready to move on to the final step — installing Hermes Agent and connecting remotely!
---

<!-- Navigation -->
<p align="center">
  <a href="04-configure-idle-timeout.md">← Part 4: Configure Idle Timeout</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="06-install-hermes-connect-remote.md">Part 6: Install Hermes →</a>
</p>

<p align="center">
  <strong>Part 5 / 7</strong>
</p>
