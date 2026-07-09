# Quản lý Codespace qua GitHub CLI

> ⏱️ **Thời gian:** 10 phút &nbsp;|&nbsp; 🎯 **Mục tiêu:** Cài đặt GitHub CLI và tạo shortcut để start/stop Codespace nhanh chóng

---

## 📌 Tại sao cần GitHub CLI?

Sau khi thiết lập Hermes server trên Codespace, bạn sẽ thường xuyên:
- 🔄 **Bật Codespace** khi cần dùng Hermes
- ⏹️ **Tắt Codespace** khi không dùng để tiết kiệm core-hours
- 📋 **Kiểm tra trạng thái** — Codespace còn sống hay đã tắt?

Thay vì phải vào GitHub bằng trình duyệt mỗi lần, **GitHub CLI** (`gh`) cho phép bạn làm tất cả từ terminal — nhanh hơn, tiện hơn, và có thể tự động hoá bằng script.

---

## 🚀 Các bước thực hiện

### Bước 1: Cài đặt GitHub CLI

#### 🪟 Windows (Git Bash / PowerShell)

```bash
# Cách 1 — winget (Windows 10/11)
winget install GitHub.cli

# Cách 2 — Download từ website
# Vào https://cli.github.com/ → Download → Install
```

#### 🍎 macOS

```bash
brew install gh
```

#### 🐧 Linux (Ubuntu/Debian)

```bash
# Dùng apt
(type -p curl >/dev/null || sudo apt-get install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update
sudo apt-get install gh -y
```

#### 🐧 Linux (CentOS/Fedora/RHEL)

```bash
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh -y
```

#### 🐧 Codespace (đã cài sẵn)

> 💡 **Tin vui:** GitHub CLI **đã được cài sẵn** trong mọi Codespace! Bạn không cần cài lại.

Kiểm tra:

```bash
gh --version
# Output mẫu: gh version X.Y.Z (2025-...)
```

---

### Bước 2: Xác thực GitHub CLI

> ⚠️ **Làm một lần duy nhất** — các lần sau không cần xác thực lại.

```bash
gh auth login
```

Làm theo hướng dẫn:

1. Chọn **GitHub.com**
2. Chọn **HTTPS** (giao thức)
3. Chọn **Login with a web browser** (dễ nhất)
4. Một mã 8 chữ số hiện ra — copy nó
5. Nhấn **Enter** để mở trình duyệt
6. Dán mã xác nhận → **Continue** → **Authorize GitHub CLI**
7. ✅ **Xong!** Terminal sẽ báo `✓ Authentication complete.`

> 💡 **Mẹo:** Nếu bạn ở trên Codespace — nơi không có GUI browser — chọn **Paste an authentication token** và dùng Personal Access Token (xem [Appendix](appendix-local-git-setup.md)).

---

### Bước 3: Các lệnh quản lý Codespace cơ bản

Dưới đây là các lệnh `gh` bạn sẽ dùng thường xuyên:

#### 👁️ Xem danh sách Codespace

```bash
gh codespace list
```

Output mẫu:

```
NAME                         DISPLAY NAME     REPOSITORY                          BRANCH  STATE     CREATED AT
codespaces-hermes-server-xxx codespaces-hermes codespaces-hermes-server/codespaces main    Available 2025-07-01
```

> `STATE = Available` ➜ đang chạy. `STATE = Shutdown` ➜ đã tắt.

#### ℹ️ Xem chi tiết Codespace

```bash
gh codespace view
```

Nếu có nhiều Codespace, nó sẽ hỏi bạn chọn cái nào.

#### ▶️ Bật Codespace

```bash
gh codespace create --repo codespaces-hermes-server
```

> ⏳ Mất khoảng 30 giây đến 2 phút để Codespace khởi động. Hermes sẽ tự động chạy nhờ `postStart.sh`.

#### ⏹️ Tắt Codespace

```bash
gh codespace stop
```

> 💡 **Tiết kiệm core-hours:** Luôn chạy lệnh này khi bạn không dùng Hermes nữa.

#### 🗑️ Xoá Codespace (khi không cần nữa)

```bash
gh codespace delete
```

> ⚠️ Xoá Codespace sẽ mất toàn bộ dữ liệu trên đó. **Hermes config, skills, memory đều mất!** Chỉ xoá nếu bạn đã backup.

#### 🔐 SSH vào Codespace

```bash
gh codespace ssh
```

> Lệnh này mở một SSH session trực tiếp vào Codespace — rất hữu ích để debug hoặc chạy lệnh thủ công.

#### 🔌 Quản lý Port

```bash
gh codespace ports
# Xem danh sách port đang mở

gh codespace ports forward 9119:9119
# Forward port 9119 từ Codespace về máy local
```

#### 📜 Xem logs

```bash
gh codespace logs
# Xem logs của Codespace (hữu ích khi debug)
```

---

### Bước 4: Tạo Shortcut Start/Stop

Thay vì gõ lệnh dài mỗi lần, bạn có thể tạo **script** hoặc **alias** để chỉ gõ một từ.

#### 🪟 Windows — Batch Script

Tạo file `codespace-start.bat`:

```batch
@echo off
echo === Dang bat Codespace Hermes Server ===
gh codespace create --repo codespaces-hermes-server
echo === Done! Hermes will auto-start via postStart.sh ===
pause
```

Tạo file `codespace-stop.bat`:

```batch
@echo off
echo === Dang tat Codespace Hermes Server ===
gh codespace stop
echo === Done! Core-hours saved. ===
pause
```

> Đặt 2 file này ở desktop hoặc trong `C:\Users\<tên>\` để chạy bất cứ lúc nào.

#### 🪟 Windows — PowerShell Script (nâng cao)

Tạo file `codespace-manager.ps1`:

```powershell
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("start","stop","status","restart")]
    [string]$Action
)

$CODESPACE_NAME = "codespaces-hermes-server"

switch ($Action) {
    "start" {
        Write-Host "🔄 Starting Codespace..." -ForegroundColor Cyan
        gh codespace create --repo $CODESPACE_NAME
        Write-Host "✅ Codespace started!" -ForegroundColor Green
    }
    "stop" {
        Write-Host "⏹️ Stopping Codespace..." -ForegroundColor Yellow
        gh codespace stop
        Write-Host "✅ Codespace stopped. Core-hours saved!" -ForegroundColor Green
    }
    "status" {
        Write-Host "📋 Checking status..." -ForegroundColor Cyan
        gh codespace list
    }
    "restart" {
        Write-Host "🔄 Restarting Codespace..." -ForegroundColor Cyan
        gh codespace stop
        Start-Sleep -Seconds 5
        gh codespace create --repo $CODESPACE_NAME
        Write-Host "✅ Codespace restarted!" -ForegroundColor Green
    }
}
```

Sử dụng:

```powershell
.\codespace-manager.ps1 start     # Bật
.\codespace-manager.ps1 stop      # Tắt
.\codespace-manager.ps1 status    # Kiểm tra
.\codespace-manager.ps1 restart   # Khởi động lại
```

#### 🐧 Linux/macOS — Shell Script

Tạo file `codespace.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

CODESPACE_REPO="codespaces-hermes-server"
ACTION="${1:-status}"

case "$ACTION" in
    start)
        echo "🔄 Starting Codespace..."
        gh codespace create --repo "$CODESPACE_REPO"
        echo "✅ Codespace started. Hermes will auto-start."
        ;;
    stop)
        echo "⏹️ Stopping Codespace..."
        gh codespace stop
        echo "✅ Codespace stopped. Core-hours saved!"
        ;;
    status)
        echo "📋 Codespace status:"
        gh codespace list
        ;;
    restart)
        echo "🔄 Restarting Codespace..."
        gh codespace stop
        sleep 5
        gh codespace create --repo "$CODESPACE_REPO"
        echo "✅ Codespace restarted!"
        ;;
    ssh)
        echo "🔐 Opening SSH session..."
        gh codespace ssh
        ;;
    logs)
        echo "📜 Fetching logs..."
        gh codespace logs
        ;;
    *)
        echo "Usage: $0 {start|stop|status|restart|ssh|logs}"
        exit 1
        ;;
esac
```

Cấp quyền thực thi và đặt vào PATH:

```bash
chmod +x codespace.sh
sudo mv codespace.sh /usr/local/bin/codespace-hermes
# Giờ bạn chỉ cần gõ:
codespace-hermes start
codespace-hermes stop
codespace-hermes status
```

#### 🐧 Linux/macOS — Alias (siêu nhanh)

Thêm vào `~/.bashrc` hoặc `~/.zshrc`:

```bash
# =====================
# Codespace Hermes Shortcuts
# =====================
alias cs-start='gh codespace create --repo codespaces-hermes-server'
alias cs-stop='gh codespace stop'
alias cs-status='gh codespace list'
alias cs-restart='gh codespace stop && sleep 3 && gh codespace create --repo codespaces-hermes-server'
alias cs-ssh='gh codespace ssh'
alias cs-logs='gh codespace logs'
```

Sau đó:

```bash
source ~/.bashrc  # hoặc mở terminal mới

# Dùng:
cs-start      # Bật
cs-stop       # Tắt
cs-status     # Kiểm tra
cs-restart    # Khởi động lại
cs-ssh        # SSH vào Codespace
```

---

### Bước 5: Tự động kiểm tra Codespace trước khi dùng (nâng cao)

Tạo script `codespace-auto-connect.sh` — tự động bật Codespace nếu đang tắt, đợi Hermes chạy, rồi mở Hermes:

```bash
#!/usr/bin/env bash
set -euo pipefail

CODESPACE_REPO="codespaces-hermes-server"
HERMES_PORT=9119

echo "🔍 Checking Codespace status..."

# Kiểm tra Codespace đang chạy không
CODESPACE_STATUS=$(gh codespace list --json state -q '.[0].state' 2>/dev/null || echo "none")

if [ "$CODESPACE_STATUS" = "Available" ]; then
    echo "✅ Codespace is already running."
elif [ "$CODESPACE_STATUS" = "Shutdown" ] || [ "$CODESPACE_STATUS" = "none" ]; then
    echo "🔄 Codespace is offline. Starting now..."
    gh codespace create --repo "$CODESPACE_REPO"
    echo "⏳ Waiting for Hermes to start..."
    sleep 30
else
    echo "⚠️ Unknown status: $CODESPACE_STATUS"
    gh codespace list
fi

# Lấy IP Tailscale hoặc local
TAILSCALE_IP=$(tailscale ip 2>/dev/null || echo "")

if [ -n "$TAILSCALE_IP" ]; then
    echo "🌐 Hermes server at: http://$TAILSCALE_IP:$HERMES_PORT"
else
    echo "🌐 Hermes server might be at localhost:$HERMES_PORT"
fi

echo "🎉 Done! Open Hermes Desktop or CLI to connect."
```

> Script này kiểm tra thông minh: nếu Codespace đang chạy thì dùng luôn, nếu tắt thì tự bật và đợi Hermes online.

---

## 🧠 Mẹo & Lưu ý

| Tình huống | Giải pháp |
|------------|-----------|
| **Quên tắt Codespace -> tốn core-hours** | Đặt alias `cs-stop` ở ngay đầu `~/.bashrc` để dễ nhớ |
| **Codespace báo lỗi "no codespace"** | Chạy `gh codespace create --repo codespaces-hermes-server` trước |
| **Gh không tìm thấy lệnh codespace** | Cập nhật gh: `gh upgrade` hoặc cài lại |
| **Nhiều Codespace cùng lúc** | Dùng `gh codespace list` để xem, `gh codespace stop -c <tên>` để tắt cái cụ thể |
| **Muốn SSH mà không cần nhớ tên** | `gh codespace ssh` — nó hiện menu chọn |
| **Xoá nhầm Codespace** | Không thể undo. Luôn backup Hermes trước khi xoá (`hermes backup`) |

---

## 📊 So sánh: Trình duyệt vs CLI

| Thao tác | Trình duyệt | GitHub CLI |
|----------|-------------|------------|
| Bật Codespace | Repo → Code → Codespaces → click tên | `cs-start` (1 giây) |
| Tắt Codespace | File → Close Remote → Stop | `cs-stop` (1 giây) |
| Kiểm tra trạng thái | Vào repo → Code → Codespaces | `cs-status` (1 giây) |
| SSH vào Codespace | Không làm được | `cs-ssh` (1 giây) |
| Xem logs | Phải mở Codespace → terminal | `cs-logs` (1 giây) |

> 🚀 CLI nhanh hơn **10-50 lần** so với dùng trình duyệt!

---

## 📚 Tiếp theo

- ⬅️ [Bài 6: Cài Hermes & Kết nối Remote](06-install-hermes-connect-remote.md)
- 📘 [Thiết lập Git trên máy local (Appendix)](appendix-local-git-setup.md)

---

<!-- Navigation -->
<p align="center">
  <a href="06-install-hermes-connect-remote.md">← Bài 6: Kết nối Remote</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="index.md">📖 Về mục lục</a>
</p>

<p align="center">
  <strong>Phần 7 / 7 — 🎉 Bonus: quản lý Codespace như một pro!</strong>
</p>
