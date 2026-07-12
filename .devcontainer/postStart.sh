#!/usr/bin/env bash
# =============================================================================
# postStart.sh — Launch Hermes Server + Tailscale (every Codespace restart)
# Runs every time the Codespace starts (including after stop/start).
# =============================================================================
set -euo pipefail

WORKSPACE="$(pwd)"
LOG_DIR="$WORKSPACE"
TIMESTAMP=$(date)

echo "=== postStart.sh started at $TIMESTAMP ===" > "$WORKSPACE/check_startup.txt"

export PATH="$PATH:$HOME/.local/bin"

# ---------------------------------------------------------------------------
# START TAILSCALE DAEMON
# ---------------------------------------------------------------------------
echo "[INFO] Starting tailscaled..." >> "$LOG_DIR/startup.log"

nohup sudo tailscaled \
    --tun=userspace-networking \
    > "$LOG_DIR/tailscale.log" 2>&1 &

# ---------------------------------------------------------------------------
# WAIT FOR TAILSCALE PROCESS
# ---------------------------------------------------------------------------
echo "[INFO] Waiting for tailscaled process..." >> "$LOG_DIR/startup.log"

for _ in {1..30}; do
    if pgrep tailscaled >/dev/null; then
        echo "[INFO] tailscaled is running." >> "$LOG_DIR/startup.log"
        break
    fi
    sleep 1
done

# ---------------------------------------------------------------------------
# START HERMES SERVER (guard: don't spawn duplicate)
# ---------------------------------------------------------------------------
echo "[INFO] Starting Hermes server..." >> "$LOG_DIR/startup.log"

if ! pgrep -f "hermes serve" >/dev/null; then
    setsid \
    hermes serve \
        --host 127.0.0.1 \
        --port 9119 \
        >> "$LOG_DIR/hermes.log" 2>&1 \
        < /dev/null &
fi

sleep 5

# ---------------------------------------------------------------------------
# VERIFY HERMES IS RUNNING
# ---------------------------------------------------------------------------
if pgrep -f "hermes serve" >/dev/null; then
    echo "[SUCCESS] Hermes server started successfully." >> "$LOG_DIR/startup.log"
else
    echo "[ERROR] Hermes server failed to start." >> "$LOG_DIR/startup.log"
fi
