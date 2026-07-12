#!/usr/bin/env bash
# =============================================================================
# postCreate.sh — Hermes Agent Installation (one-time setup)
# Runs once when the Codespace is first created.
# =============================================================================
set -euo pipefail

WORKSPACE="$(pwd)"
LOG_DIR="$WORKSPACE"
TIMESTAMP=$(date)

echo "=== postCreate.sh started at $TIMESTAMP === " >> "$LOG_DIR/setup.log"

# ---------------------------------------------------------------------------
# Install Hermes Agent via pip (avoids interactive setup wizard)
# ---------------------------------------------------------------------------
echo "[INFO] Installing Hermes Agent via pip..." >> "$LOG_DIR/setup.log"
pip install hermes-agent
echo "[INFO] Hermes Agent installed." >> "$LOG_DIR/setup.log"

# ---------------------------------------------------------------------------
# Initialize Hermes config (Blank Slate) — prevents wizard on first serve
# ---------------------------------------------------------------------------
export PATH="$PATH:$HOME/.local/bin"
mkdir -p "$HOME/.hermes"

# Create placeholder config to silence the first-run wizard
cat > "$HOME/.hermes/config.yaml" << 'HERMESCFG'
model:
  default: ""
display:
  interface: cli
agent:
  max_turns: 90
HERMESCFG
echo "[INFO] Hermes config initialized (Blank Slate)." >> "$LOG_DIR/setup.log"
hermes --version >> "$LOG_DIR/setup.log" 2>&1 || true

# ---------------------------------------------------------------------------
# Install Tailscale (needed for remote access)
# ---------------------------------------------------------------------------
echo "[INFO] Installing Tailscale..." >> "$LOG_DIR/setup.log"
curl -fsSL https://tailscale.com/install.sh | sh
echo "[INFO] Tailscale installed." >> "$LOG_DIR/setup.log"

echo "=== postCreate.sh completed === " >> "$LOG_DIR/setup.log"
