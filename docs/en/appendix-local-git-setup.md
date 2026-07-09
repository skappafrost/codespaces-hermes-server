# Local Git Setup & GitHub Authentication

> ⚙️ One-time setup — you won't need to repeat this.

## Install Git (if not installed)

**Windows:** https://git-scm.com/download/win → Download → Install (defaults are fine)

Verify:
```bash
git --version
# Sample output: git version 2.45.0.windows.1
```

## Configure Git

Open **Git Bash** (or terminal) and run:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

Example:
```bash
git config --global user.name "skappafrost"
git config --global user.email "skappafrost@gmail.com"
```

## Authenticate with GitHub

### Option A — Personal Access Token (recommended)

1. Go to **https://github.com/settings/tokens** → **Generate new token (classic)**
2. Tick scopes: `repo` (full), `workflow`, `admin:org`
3. Click **Generate token** → **Copy the token immediately** (it cannot be viewed later)
4. Use this token as your password when pushing

### Option B — GitHub CLI

```bash
# Windows (Git Bash)
winget install GitHub.cli

# Or download from https://cli.github.com/
gh auth login
```

Choose:
- `GitHub.com`
- `HTTPS`
- `Paste an authentication token` (use the token from Option A)
- or `Login with a web browser`

## Push Code for the First Time

```bash
cd /path/to/codespaces-hermes-server
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/[USERNAME]/codespaces-hermes-server.git
git push -u origin main
```

> 🔐 If prompted for a password, use your **Personal Access Token** instead of your GitHub password.
