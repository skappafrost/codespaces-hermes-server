# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| latest  | ✅ Yes    |

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please **do not** open a public issue.

Instead, send a private report to **skappafrost@gmail.com**.

We will:
1. Acknowledge receipt within 48 hours
2. Investigate and determine scope within 5 business days
3. Release a fix or mitigation as soon as possible
4. Credit the reporter (with permission) in the release notes

## Scope

This project provides configuration files and documentation for running Hermes Agent on GitHub Codespaces. Security concerns include:

- **Exposed authentication credentials** in `.env` or config files
- **Unsecured Tailscale tunnels** leaving ports open
- **Codespace idle timeout bypass** causing resource exhaustion
- **Data privacy** when running AI agents in cloud environments

## Best Practices

- Always use strong, unique passwords for `HERMES_DASHBOARD_BASIC_AUTH`
- Set Codespace idle timeout to prevent unnecessary exposure
- Keep your Tailscale authentication tokens private
- Never commit `.env` files or credentials to version control
