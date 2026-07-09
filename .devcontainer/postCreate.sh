#!/usr/bin/env bash
# =============================================================================
# postCreate.sh — Hermes Agent Installation (one-time setup)
# Runs once when the Codespace is first created.
# =============================================================================
set -euo pipefail

WORKSPACE="/workspaces/codespaces-hermes-server"
LOG_DIR="$WORKSPACE"
TIMESTAMP=$(date)

echo "=== postCreate.sh started at $TIMESTAMP ===" >> "$LOG_DIR/setup.log"

# Install Hermes Agent (one-time — only runs on initial Codespace creation)
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

echo "[INFO] Hermes Agent installed successfully." >> "$LOG_DIR/setup.log"
