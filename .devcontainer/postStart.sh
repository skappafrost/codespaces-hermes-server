#!/usr/bin/env bash
set -euo pipefail

WORKDIR="/workspaces/Cloud-Agents"
LOGDIR="$WORKDIR"

echo "=== postStart.sh chạy lúc $(date) ===" > "$WORKDIR/check_startup.txt"

export PATH="$PATH:/home/codespace/.local/bin"

echo "[INFO] Chờ Codespace ổn định..." >> "$LOGDIR/startup.log"
sleep 20

####################################################
# START TAILSCALE
####################################################

echo "[INFO] Starting tailscaled..." >> "$LOGDIR/startup.log"

nohup sudo tailscaled \
    --tun=userspace-networking \
    --socks5-server=localhost:1055 \
    --outbound-http-proxy-listen=localhost:1055 \
    > "$LOGDIR/tailscale.log" 2>&1 &

####################################################
# WAIT DOCKER
####################################################

echo "[INFO] Waiting Docker..." >> "$LOGDIR/startup.log"

for i in {1..60}
do
    if docker info >/dev/null 2>&1; then
        echo "[INFO] Docker OK" >> "$LOGDIR/startup.log"
        break
    fi

    sleep 2
done

####################################################
# WAIT TAILSCALE PROCESS
####################################################

echo "[INFO] Waiting tailscaled..." >> "$LOGDIR/startup.log"

for i in {1..30}
do
    if pgrep tailscaled >/dev/null; then
        echo "[INFO] tailscaled OK" >> "$LOGDIR/startup.log"
        break
    fi

    sleep 1
done

####################################################
# START HERMES
####################################################

echo "[INFO] Starting Hermes..." >> "$LOGDIR/startup.log"

setsid \
/home/codespace/.local/bin/hermes serve \
    --host 0.0.0.0 \
    --port 9119 \
    >> "$LOGDIR/hermes.log" 2>&1 \
    < /dev/null &

sleep 5

####################################################
# VERIFY
####################################################

if pgrep -f "hermes serve" >/dev/null
then
    echo "[SUCCESS] Hermes started." >> "$LOGDIR/startup.log"
else
    echo "[ERROR] Hermes failed to start." >> "$LOGDIR/startup.log"
fi
