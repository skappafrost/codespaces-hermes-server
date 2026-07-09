# Contributing to Codespaces Hermes Server

Thank you for considering contributing! This project aims to provide the best possible guide for running Hermes Agent on free GitHub Codespaces.

## How to Contribute

### 📝 Documentation Improvements

- Fix typos, grammar, or unclear phrasing in any language
- Add missing steps or edge cases
- Improve formatting, tables, or code blocks
- Translate into additional languages

### 🛠️ Script Improvements

- Enhance `.devcontainer` scripts for reliability
- Add support for alternative VPN solutions
- Improve error handling and recovery

### 🐛 Reporting Issues

Open an issue with:
- A clear description of the problem
- Steps to reproduce (if applicable)
- Suggested fix (if you have one)

## Pull Request Guidelines

1. **Fork** the repository
2. **Branch** from `main` — name your branch descriptively (e.g. `fix/tailscale-path`, `docs/ko-translation`)
3. **Commit** with clear messages (e.g. `fix: correct workspace path in postStart.sh`)
4. **Push** to your fork and open a PR
5. Ensure the PR description explains what changed and why

## Style Guide

### Documentation

- Use **semantic line breaks** (one sentence per line) for easier diff review
- Badges: use `⏰` for time, `💰` for cost, `⚠️` for warnings, `💡` for tips
- Code blocks must specify the language (e.g. ` ```bash `, ` ```json `)
- Tables should be clean and properly aligned
- Navigation: every doc page has `← Previous` and `Next →` links

### Scripts

- All shell scripts must start with `#!/usr/bin/env bash` and `set -euo pipefail`
- Use English for all inline comments
- Log all significant actions to the log directory
- Use meaningful variable names

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>: <description>

[optional body]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

## Code of Conduct

Be respectful and constructive. This project is open to everyone regardless of experience level.

## Questions?

Open an issue or email **skappafrost@gmail.com**.
