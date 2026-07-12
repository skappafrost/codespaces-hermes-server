# Create a New Private Repository

> **⏰ Time:** 3 minutes · **💰 Cost:** Free · **🔧 Level:** Beginner

---

Now that you have a GitHub account, the next step is to create a private repository that will host your Codespaces Hermes Server setup.

---

## Step 1: Open the Create Repository Page

You can get there in two ways:

- **Option A:** Click the **`+`** icon (top-right of any GitHub page) → Select **New repository**
- **Option B:** Navigate directly to **[https://github.com/new](https://github.com/new)**

---

## Step 2: Fill in the Repository Details

Enter the following information on the **Create a new repository** page:

| Field | Value |
|:---|---|
| **Owner** | `[your GitHub username]` |
| **Repository name** | `codespaces-hermes-server` |
| **Description** | `Free Codespaces setup guide for Hermes Agent server` |
| **Visibility** | 🔘 **Private** (selected) |

> ⚠️ **Important:** Select **Private** so your configuration and any potential secrets remain accessible only to you.

---

## Step 3: ❌ DO NOT Initialize the Repository

**Skip all of the following checkboxes:**

- ❌ ~~Add a README file~~
- ❌ ~~Add .gitignore~~
- ❌ ~~Choose a license~~

You will add these files manually in the next steps. Starting with a completely empty repository avoids merge conflicts when you push your local setup.

---

## Step 4: Click "Create Repository"

Once you've filled in the fields, click the green **Create repository** button at the bottom of the page.

---

## Step 5: Verify the Result

After creation, you'll be taken to a **Quick setup** page that displays git remote commands similar to this:

```bash
git remote add origin https://github.com/<your-username>/codespaces-hermes-server.git
git branch -M main
git push -u origin main
```

This page confirms your repository is ready. Keep this tab open — you'll return to it after setting up your local environment.

---

## ✅ Done! Your Private Repository Is Ready.

You now have an empty private repository named `codespaces-hermes-server` waiting to receive your project files.

---

<!-- Navigation -->
<p align="center">
  <a href="01-create-github-account.md">← Create a GitHub Account</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="03-setup-devcontainer.md">Setup .devcontainer →</a>
</p>

<p align="center">
  <strong>Part 2 / 7</strong>
</p>

---

*Need help? Check [GitHub's repository documentation](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository).*
