# Configure Codespace Idle Timeout

<p align="center">
  <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Logo" width="120"/>
</p>

<p align="center">
  <span style="display: inline-block; background: #d29922; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px; margin: 0 4px;">⏰ 2 minutes</span>
  <span style="display: inline-block; background: #cb2431; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px; margin: 0 4px;">⚠️ Must do BEFORE creating your first Codespace</span>
</p>

Step-by-step guide to increasing the Codespace idle timeout from the default 30 minutes to 240 minutes (4 hours).

---

## 📋 Prerequisites

| Requirement | Details |
|-------------|---------|
| ✅ GitHub account | Created and logged in (see [Part 1](01-create-github-account.md)) |
| ✅ Private repository | Created (see [Part 2](02-create-repository.md)) |
| 🌐 Web browser | Chrome, Edge, Firefox, or Safari |

---

## 🚀 Steps

### Step 1: Navigate to Codespaces Settings

Go to your repository on GitHub, then:

1. Click the **Settings** tab (top navigation bar)
2. In the left sidebar, expand **Code and automation**
3. Click **Codespaces**

> 💡 **Tip:** You can also reach this page directly at `https://github.com/settings/codespaces` for global settings, or navigate through your repo's Settings for per-repository settings.

---

### Step 2: Set the Idle Timeout

| Field | Setting |
|-------|---------|
| **Idle timeout** | ⬇️ Open the dropdown and select **240 minutes** |

The dropdown offers several options — scroll down until you find **240 minutes** (4 hours).

---

### Step 3: Save

Click the **Save** button to apply the change.

> ✅ **Important:** The setting takes effect **only for new Codespaces created after this change**. Any Codespace that was already created before this setting was saved must be **deleted and recreated** — simply restarting will **not** apply the new timeout.

---

## ❓ Why Change the Timeout?

The **default idle timeout is only 30 minutes** — very short. If your Codespace sits idle for half an hour (e.g., while you're reading docs, taking a break, or working in another window), it shuts down automatically.

By raising it to **240 minutes (4 hours)**, you give yourself enough time for a full work session without unexpected interruptions.

| Timeout | Behavior |
|---------|----------|
| ⏳ **30 min** (default) | Codespace shuts down after 30 min of inactivity |
| ✅ **240 min** (recommended) | Codespace stays alive for up to 4 hours of inactivity |

> ⚠️ **Important:** The Codespace still shuts down after the timeout even if you have unsaved work — make sure your editor autosaves or you save frequently.

---

## 💡 Core-Hours Math

GitHub Free includes **120 core-hours per month**. Here's how the math works out:

| Setting | Calculation | Result |
|---------|-------------|--------|
| Idle timeout | 240 min = 4 hours | — |
| Codespace spec | 2-core machine | — |
| Daily usage | 4 hours/day | — |
| Monthly consumption | 4 h × 2 cores × 30 days = 240 core-hours | ❌ Over limit |
| **Recommended daily limit** | ~4 hours/day on a **2-core** machine | ✅ ~120 core-hours |

**Practical tip:** A 2-core Codespace running 4 hours/day uses roughly 120 core-hours/month, fitting comfortably within the Free tier. If you need more time, consider stopping the Codespace when you're done instead of letting it idle.

---

## 🎯 Summary

| Item | Value |
|------|-------|
| 🔧 Setting | Idle Timeout |
| ⏱️ New value | **240 minutes** (4 hours) |
| ⏱️ Old value | 30 minutes (default) |
| 💰 Cost | Free — this is a setting, not a paid feature |
| 💡 Benefit | Prevents premature shutdown during work sessions |

---

<!-- Navigation -->
<p align="center">
  <a href="03-setup-devcontainer.md">← Previous: Set up .devcontainer</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="05-create-codespace.md">Next: Create a Codespace →</a>
</p>

<p align="center">
  <strong>Part 4 / 7</strong>
</p>
