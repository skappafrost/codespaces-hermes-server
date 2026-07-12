# Cấu hình .devcontainer cho Codespace

Trong phần này, bạn sẽ tạo **3 file cấu hình** trong thư mục `.devcontainer/` của repository trên GitHub. Các file này giúp Codespace tự động cài đặt Hermes Agent và khởi động server mỗi khi bạn bật Codespace lên.

---

## 📖 .devcontainer là gì?

`.devcontainer` là một thư mục đặc biệt trong repository GitHub. Khi bạn tạo một Codespace, GitHub tự động phát hiện thư mục này và dùng cấu hình bên trong để thiết lập môi trường phát triển.

Nó gồm 3 thành phần chính:

| File | Vai trò |
|------|---------|
| `devcontainer.json` | File cấu hình chính: khai báo port, extension VS Code, và các script sẽ chạy |
| `postCreate.sh` | Chạy **một lần duy nhất** khi Codespace được tạo — dùng để cài Hermes Agent |
| `postStart.sh` | Chạy **mỗi lần** Codespace khởi động (kể cả sau stop/start) — khởi động Tailscale + Hermes server |

> 💡 **Cách hoạt động:** Khi Codespace khởi động, GitHub đọc `devcontainer.json`, thấy lệnh `postCreateCommand` và `postStartCommand`, rồi tự động gọi các script `.sh` tương ứng.

---

## 🛠️ Cách tạo 3 file trên GitHub Web UI

Bạn sẽ thao tác trực tiếp trên giao diện web của GitHub — không cần cài đặt gì trên máy tính.

### Bước 1: Vào repository của bạn

1. Mở trình duyệt, đăng nhập [github.com](https://github.com)
2. Vào repository bạn đã tạo ở phần trước (ví dụ: `codespaces-hermes-server`)

### Bước 2: Tạo thư mục `.devcontainer/`

1. Click nút **Add file** → **Create new file**
2. Trong ô "Name your file...", gõ: `.devcontainer/devcontainer.json`
   - GitHub tự động tạo thư mục `.devcontainer/` khi bạn đặt tên file có dấu `/`
3. Copy nội dung bên dưới vào ô "Edit new file"

### Bước 3: Tạo `devcontainer.json`

```json
{
  "postCreateCommand": "bash .devcontainer/postCreate.sh",
  "postStartCommand": "bash .devcontainer/postStart.sh",
  "forwardPorts": [9119],
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-azuretools.vscode-docker",
        "eamodio.gitlens",
        "mhutchie.git-graph"
      ],
      "settings": {
        "terminal.integrated.defaultProfile.linux": "bash"
      }
    }
  }
}
```

**Giải thích từng trường:**

| Trường | Ý nghĩa |
|--------|---------|
| `postCreateCommand` | Lệnh chạy **một lần** khi Codespace được tạo lần đầu — gọi script cài Hermes |
| `postStartCommand` | Lệnh chạy **mỗi lần** Codespace start — gọi script khởi động Tailscale + Hermes |
| `forwardPorts` | Port 9119 được mở để bạn truy cập Hermes server từ bên ngoài |
| `customizations.vscode.extensions` | Các extension VS Code được cài tự động: Docker, GitLens, Git Graph |
| `customizations.vscode.settings` | Cấu hình mặc định cho terminal trong VS Code |

4. Ở dưới cùng, chọn **"Commit directly to the main branch"** và click **Commit new file**

### Bước 4: Tạo `postCreate.sh`

Lặp lại thao tác: **Add file** → **Create new file** với đường dẫn `.devcontainer/postCreate.sh`

```bash
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
```

**Script này làm gì?**
- Ghi log thời gian bắt đầu
- Tải và cài Hermes Agent bằng lệnh `curl` từ trang chủ
- Ghi log kết quả thành công

> ⚠️ Script này chỉ chạy **1 lần duy nhất** khi Codespace được tạo mới — không chạy lại khi bạn start/stop Codespace.

Commit file này.

### Bước 5: Tạo `postStart.sh`

**Add file** → **Create new file** với đường dẫn `.devcontainer/postStart.sh`

```bash
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
```

**Script này làm gì?**

| Bước | Mô tả |
|------|-------|
| 🚀 Start tailscaled | Chạy Tailscale daemon với chế độ userspace networking |
| 👁️ Chờ Tailscale | Xác nhận tiến trình tailscaled đã chạy |
| 🤖 Start Hermes | Chạy `hermes serve` nền (guard: bỏ qua nếu đã chạy) |
| ✅ Kiểm tra | Xác nhận Hermes server đã chạy thành công |

> 🔐 **Port 9119** là cổng mặc định của Hermes Server. Bạn sẽ dùng port này để kết nối từ Hermes Desktop sau này.

Commit file này.

---

> ⚠️ **Lưu ý lần đầu chạy Codespace:** Khi bạn tạo Codespace mới, `postCreate.sh` sẽ cài Hermes + Tailscale, và `postStart.sh` cũng chạy luôn trong lần boot đầu tiên. Nếu bạn thấy `[ERROR] Hermes server failed to start` trong log, đừng lo — điều này có thể xảy ra nếu:
> - Tiến trình cài Hermes trong `postCreate.sh` chưa hoàn tất
> - Bạn chưa tạo file `~/.hermes/.env` với thông tin auth (sẽ làm ở bước sau)
> 
> **Cứ tiếp tục làm theo hướng dẫn.** Sau khi hoàn thành các bước còn lại (tạo auth + đăng nhập Tailscale), restart Codespace 1 lần là mọi thứ sẽ chạy ổn.

---

## 📂 Cấu trúc thư mục sau khi hoàn tất

Sau khi tạo 3 file, repository của bạn sẽ trông như thế này:

```text
codespaces-hermes-server/
└── .devcontainer/
    ├── devcontainer.json       # Config: gọi postCreate.sh + postStart.sh
    ├── postCreate.sh           # Cài Hermes Agent (1 lần)
    └── postStart.sh            # Khởi động Tailscale + Hermes serve (mỗi lần start)
```

---

## ✅ Kiểm tra nhanh

Sau khi commit cả 3 file, hãy vào repository của bạn trên GitHub và kiểm tra:

1. ✅ Thư mục `.devcontainer/` hiển thị trong repository
2. ✅ File `devcontainer.json` có nội dung JSON hợp lệ
3. ✅ File `postCreate.sh` và `postStart.sh` có quyền thực thi (executable)
4. ✅ Cả 3 file đều nằm trong nhánh `main`

> 💡 **Mẹo:** Trên giao diện web GitHub, file `.sh` sẽ hiển thị với biểu tượng terminal và màu xanh lá — đó là dấu hiệu file đã có quyền thực thi.

---

## 🔜 Tiếp theo

Sau khi cấu hình xong `.devcontainer`, bạn cần **cấu hình Idle Timeout** để Codespace không tự động tắt quá sớm.

---

<!-- Navigation -->
<p align="center">
  <a href="02-create-repository.md">← Tạo Repository</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="04-configure-idle-timeout.md">Cấu hình Idle Timeout →</a>
</p>

<p align="center">
  <strong>Phần 3 / 7</strong>
</p>
