#!/usr/bin/env bash
set -euo pipefail

echo "=== postCreate.sh chạy lúc $(date) ===" >> /workspaces/Cloud-Agents/setup.log

# Cài Hermes Agent (chạy 1 lần duy nhất khi tạo Codespace)
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash

echo "[INFO] Hermes installed!" >> /workspaces/Cloud-Agents/setup.log
