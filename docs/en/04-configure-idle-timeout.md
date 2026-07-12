# Configure Idle Timeout for Codespace

> ⏱️ **Duration:** 2 minutes &nbsp;|&nbsp; 🎯 **Goal:** Increase idle timeout from 30 minutes to 240 minutes

---

## 📌 Why Increase Idle Timeout?

By default, GitHub Codespaces will **automatically shut down after 30 minutes of inactivity** (idle). This is a very short period and is unsuitable when running Hermes Agent as a personal server.

**Problems with the default 30 minutes:**

| Problem | Description |
|---------|-------------|
| 🛑 **Codespace shuts down constantly** | Just leave the keyboard for a few minutes and the Hermes server stops working |
| 📉 **Loss of connection** | Hermes Desktop/CLI cannot remote into the Codespace when it's off |
| 🔄 **Frequent restarts** | Each time it shuts down you have to go to GitHub to restart, wasting boot time |
| 💸 **Wasted capacity** | Each stop/restart doesn't take advantage of already allocated resources |

> ⚠️ **IMPORTANT WARNING:** This setting **must be configured BEFORE creating a Codespace for the first time**. The new idle timeout **only takes effect for Codespaces created AFTER** you configure it. If you already created a Codespace, you must **delete and recreate it** — restarting the Codespace will **NOT** apply the new idle timeout.

---

## 🛠️ Steps

### Step 1: Open GitHub Settings

1. Log in to [github.com](https://github.com)
2. Click your **avatar** in the top-right corner
3. Select **Settings** from the dropdown menu

### Step 2: Go to Codespaces

1. In the left sidebar of the Settings page, scroll down
2. Click **Codespaces** (under **Code, planning, and automation**)

### Step 3: Adjust Idle Timeout

1. Find the **Default idle timeout** setting
2. Enter the value **`240`** (minutes) — equivalent to **4 hours**
3. Click the **Save** button to save

---

## 🔢 Idle Timeout Option Details

GitHub Codespaces allows you to configure idle timeout in the range:

| Value | Suitable for | Notes |
|-------|-------------|-------|
| **5–30 minutes** | Learning, quick experiments | ⚠️ Too short for Hermes server |
| **30–60 minutes** | Short coding sessions | ⚠️ May still shut down mid-session |
| **240 minutes (max — recommended)** | Hermes server, background tasks | ✅ Best for long uptime |

> 💡 **Tip:** 240 minutes is the sweet spot — long enough for Hermes to stay online when you need it, but short enough for the Codespace to auto-shut down if you forget, avoiding wasted core-hours.

---

## ⏰ Core-Hours: Understand to Save

### GitHub Free gives you **120 core-hours / month**

Each Codespace you create consumes core-hours based on:
- **Number of CPU cores** of the VM
- **Uptime** (including idle, unless shut down by timeout)

**How core-hours are calculated:**

```
Core-hours = (Number of cores) × (Hours of runtime)
```

Example:
- 2-core Codespace running 4 hours/day = 8 core-hours/day
- 30 days × 8 = 240 core-hours → **exceeds Free quota**
- But the Codespace will **auto-shut down after 240 minutes idle** → significant savings

### Tips to save core-hours

| Tip | Details |
|-----|---------|
| ✅ **Use a 2-core machine** | Choose a 2-core machine instead of 4-core or 8-core — enough to run Hermes Agent |
| ✅ **240-min idle timeout** | Not too short (loses connection), not too long (wastes resources) |
| ✅ **Stop when not in use** | If you know you won't use it for 8+ hours, proactively Stop the Codespace |
| ✅ **Monitor usage** | Go to Settings → Codespaces → see **Monthly included usage** |
| ❌ **Don't run multiple Codespaces at once** | Each Codespace consumes its own core-hours |

---

## 🔍 Verify Saved Configuration

After saving, you can verify by:

1. Go back to **Settings → Codespaces**
2. Look at the **Default idle timeout** setting
3. The displayed value will be **240 minutes**

> ✅ **Confirmed:** Configuration saved successfully! Now you can move on to the next step.

---

## ❌ Common Errors

| Error | Cause | Fix |
|-------|-------|-----|
| Can't find Codespaces in Settings | Codespaces not yet activated | Just create a Codespace once and this section appears |
| Idle timeout doesn't apply to running Codespace | Setting only applies to Codespaces created **after** configuration | Delete old Codespace → create new Codespace |
| Value won't save | Network error or session expired | Refresh the page and try again |
| Can't enter a value > 240 | GitHub Free limits max to 240 minutes | Choose a value ≤ 240 |

---

<!-- Navigation -->
<p align="center">
  <a href="03-setup-devcontainer.md">← Lesson 3: Configure .devcontainer</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="05-create-codespace.md">Lesson 5: Create a Codespace →</a>
</p>

<p align="center">
  <strong>Part 4 / 7</strong>
</p>
