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

echo "[INFO] Waiting for Codespace to stabilize..." >> "$LOG_DIR/startup.log"

# Wait loop instead of fixed sleep — checks until Hermes port is ready
for i in {1..15}; do
    if ss -tlnp 2>/dev/null | grep -q :9119; then
        break
    fi
    sleep 2
done

# ---------------------------------------------------------------------------
# START TAILSCALE DAEMON
# ---------------------------------------------------------------------------
echo "[INFO] Starting tailscaled..." >> "$LOG_DIR/startup.log"

nohup sudo tailscaled \
    --tun=userspace-networking \
    --socks5-server=localhost:1055 \
    --outbound-http-proxy-listen=localhost:1055 \
    > "$LOG_DIR/tailscale.log" 2>&1 &

# ---------------------------------------------------------------------------
# WAIT FOR DOCKER
# ---------------------------------------------------------------------------
echo "[INFO] Waiting for Docker..." >> "$LOG_DIR/startup.log"

for i in {1..60}; do
    if docker info >/dev/null 2>&1; then
        echo "[INFO] Docker is ready." >> "$LOG_DIR/startup.log"
        break
    fi
    sleep 2
done

# ---------------------------------------------------------------------------
# WAIT FOR TAILSCALE PROCESS
# ---------------------------------------------------------------------------
echo "[INFO] Waiting for tailscaled process..." >> "$LOG_DIR/startup.log"

for i in {1..30}; do
    if pgrep tailscaled >/dev/null; then
        echo "[INFO] tailscaled is running." >> "$LOG_DIR/startup.log"
        break
    fi
    sleep 1
done

# ---------------------------------------------------------------------------
# START HERMES SERVER
# ---------------------------------------------------------------------------
echo "[INFO] Starting Hermes server..." >> "$LOG_DIR/startup.log"

setsid \
hermes serve \
    --host 0.0.0.0 \
    --port 9119 \
    >> "$LOG_DIR/hermes.log" 2>&1 \
    < /dev/null &

sleep 5

# ---------------------------------------------------------------------------
# VERIFY HERMES IS RUNNING
# ---------------------------------------------------------------------------
if pgrep -f "hermes serve" >/dev/null; then
    echo "[SUCCESS] Hermes server started successfully." >> "$LOG_DIR/startup.log"
else
    echo "[ERROR] Hermes server failed to start." >> "$LOG_DIR/startup.log"
fi
