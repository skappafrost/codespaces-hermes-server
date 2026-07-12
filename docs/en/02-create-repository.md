# Create a New Repository (Private)

<p align="center">
  <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Logo" width="120"/>
</p>

<p align="center">
  <span style="display: inline-block; background: #28a745; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px; margin: 0 4px;">⏰ 3 minutes</span>
  <span style="display: inline-block; background: #6f42c1; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px; margin: 0 4px;">💰 Free</span>
</p>

Guide to creating a **Private** repository on GitHub — only you and invited collaborators can view it.

---

## 📋 Requirements

| Requirement | Details |
|------------|---------|
| ✅ GitHub account | Created and logged in (see [previous guide](01-create-github-account.md)) |
| 🌐 Web browser | Chrome, Edge, Firefox, or Safari |
| 📝 Repository name | Only letters, numbers, hyphens (`-`) and underscores (`_`) |

---

## 🚀 Steps

### Step 1: Open the Create Repository Page

There are **3 ways** to get started:

| Way | Action |
|:---:|--------|
| **1** | Click the **+** button in the top-right corner → Select **"New repository"** |
| **2** | Navigate directly to: [github.com/new](https://github.com/new) |
| **3** | From Dashboard → click the **"Create repository"** button (if available) |

> 💡 **Tip:** The fastest way is **way 2** — bookmark `github.com/new` for later use.

---

### Step 2: Fill in the Repository Details

On the create repository page, enter the following information:

| Field | Value | Required? | Description |
|-------|-------|:---------:|-------------|
| **Owner** | Your account (or organization) | ✅ | Choose who will own this repository |
| **Repository name** | `your-project-name` | ✅ | Repository name — should be short, memorable, and meaningful |
| **Description** | Short project description | ❌ | Example: "My first web store project" |
| **Visibility** | **Private** | ✅ | Select **Private** so only you and invited collaborators can access it |

> ⚠️ **Warning:** Choose **Private** if the project contains sensitive information, commercial source code, or personal assignments. A public repository can be seen by anyone on the Internet!

#### Detailed field explanations

**Owner:**
- You can create a repository under your personal name or under an organization
- If you don't have an organization, it defaults to your personal account

**Repository name:**
- Use only lowercase letters, numbers, hyphens (`-`) and underscores (`_`)
- Do not use spaces, special characters, or uppercase letters (recommended)
- Examples: `my-first-project`, `blog-source`, `ecommerce-app`

**Visibility — Public vs Private:**

| Criteria | Public | Private |
|----------|:------:|:-------:|
| Anyone can view | ✅ | ❌ |
| Only invited people can view | ❌ | ✅ |
| Good for open source | ✅ | ❌ |
| Good for personal/work projects | ❌ | ✅ |
| GitHub Free | Unlimited | Unlimited |

---

### Step 3: ❌ DO NOT Initialize Anything

In the **"Initialize this repository with"** section, **uncheck all items**:

| Item | Status | Reason |
|------|:-----:|--------|
| Add a README file | ❌ Unchecked | Will add after cloning to local machine |
| Add .gitignore | ❌ Unchecked | Will configure inside `.devcontainer` |
| Choose a license | ❌ Unchecked | Not needed for a private repo |

> 🎯 **Why not initialize?** — We will configure the project from scratch using `.devcontainer` and a ready-made template, giving us better control over the directory structure and avoiding conflicts.

---

### Step 4: Click "Create Repository"

After re-checking all the information:

| Check | Value |
|-------|-------|
| Owner | ✅ Correct account/desired owner |
| Repository name | ✅ Valid, not a duplicate |
| Description | ✅ (optional) |
| Visibility | ✅ **Private** |
| Initialize | ✅ **Nothing** selected |

Click the **"Create repository"** button.

---

### Step 5: Result Page

> ✅ **You can skip this step** — it's purely informational. If you already saw the repository was created successfully, feel free to move on.

After successful creation, you will see the setup guide page:

```
Quick setup — if you've done this kind of thing before
or create a new repository on the command line
…
```

This page provides commands to connect your local repository to the remote one:

#### 📦 Connect an existing local repository

```bash
git remote add origin https://github.com/your-username/your-repo.git
git branch -M main
git push -u origin main
```

#### 🆕 Create a new local repository

```bash
echo "# your-repo" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/your-username/your-repo.git
git push -u origin main
```

> 💡 **Tip:** Copy these commands — you will use them in the next guide when configuring `.devcontainer`.

---

## 🎯 Summary

You have successfully created a **Private Repository** on GitHub:

| Property | Value |
|----------|-------|
| 📌 Address | `https://github.com/your-username/your-repo` |
| 🔒 Mode | Private |
| 📁 README | ❌ Not yet |
| 📄 .gitignore | ❌ Not yet |
| 📜 License | ❌ Not yet |

---

<!-- Navigation -->
<p align="center">
  <a href="01-create-github-account.md">← Guide 1: Create an Account</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="03-setup-devcontainer.md">Setup .devcontainer →</a>
</p>

<p align="center">
  <strong>Part 2 / 7</strong>
</p>
