# Thiết lập Git & GitHub trên máy local

> ⚙️ Làm **một lần duy nhất** — các lần sau không cần làm lại.

## Cài đặt Git (nếu chưa có)

**Windows:** https://git-scm.com/download/win → Download → Install (mặc định hết)

Kiểm tra:
```bash
git --version
# Output mẫu: git version 2.45.0.windows.1
```

## Cấu hình Git

Mở **Git Bash** (hoặc terminal) và chạy:

```bash
git config --global user.name "Tên của bạn"
git config --global user.email "email@đã dùng để đăng ký GitHub"
```

Ví dụ:
```bash
git config --global user.name "skappafrost"
git config --global user.email "skappafrost@gmail.com"
```

## Xác thực với GitHub

### Option A — Token (khuyên dùng)

1. Vào **https://github.com/settings/tokens** → **Generate new token (classic)**
2. Tick scopes: `repo` (đầy đủ), `workflow`, `admin:org`
3. Click **Generate token** → **Copy token ngay lập tức** (không xem lại được sau khi thoát)
4. Dùng token này làm mật khẩu khi push

### Option B — GitHub CLI

```bash
# Windows (Git Bash)
winget install GitHub.cli

# Hoặc download từ https://cli.github.com/
gh auth login
```

Chọn:
- `GitHub.com`
- `HTTPS`
- `Paste an authentication token` (dùng token từ Option A)
- hoặc `Login with a web browser`

## Push code lên GitHub lần đầu

```bash
cd /path/to/codespaces-hermes-server
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/[USERNAME]/codespaces-hermes-server.git
git push -u origin main
```

> 🔐 Nếu được hỏi password, dùng **Personal Access Token** thay vì mật khẩu GitHub.
