#!/usr/bin/env bash
# =============================================================================
# postCreate.sh — Hermes Agent Installation (one-time setup)
# Runs once when the Codespace is first created.
# =============================================================================
set -euo pipefail

WORKSPACE="$(pwd)"
LOG_DIR="$WORKSPACE"
TIMESTAMP=$(date)

echo "=== postCreate.sh started at $TIMESTAMP ===" >> "$LOG_DIR/setup.log"

# Install Hermes Agent (one-time — only runs on initial Codespace creation)
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
echo "[INFO] Hermes Agent installed successfully." >> "$LOG_DIR/setup.log"

# Install Tailscale (needed for remote access)
curl -fsSL https://tailscale.com/install.sh | sh
echo "[INFO] Tailscale installed successfully." >> "$LOG_DIR/setup.log"

echo "=== postCreate.sh completed ===" >> "$LOG_DIR/setup.log"
