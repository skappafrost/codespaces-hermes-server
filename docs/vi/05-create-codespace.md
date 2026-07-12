# Tạo Codespace từ Repository

> ⏱️ **Thời gian:** 3 phút &nbsp;|&nbsp; 🎯 **Mục tiêu:** Khởi tạo Codespace đầu tiên và làm quen với giao diện

---

## 📌 Trước khi bắt đầu

Hãy đảm bảo bạn đã hoàn thành các bước trước:

| # | Bước | Trạng thái |
|---|------|------------|
| 1 | [Tạo tài khoản GitHub](01-create-github-account.md) | ✅ Hoàn thành |
| 2 | [Tạo Repository](02-create-repository.md) | ✅ Hoàn thành |
| 3 | [Cấu hình .devcontainer](03-setup-devcontainer.md) | ✅ Hoàn thành |
| 4 | [Cấu hình Idle Timeout](04-configure-idle-timeout.md) | ✅ Hoàn thành (quan trọng!) |

> ⚠️ **Chưa cấu hình Idle Timeout?** Dừng lại và làm [Bước 4](04-configure-idle-timeout.md) trước — nếu tạo Codespace xong mới cấu hình, bạn phải restart Codespace để áp dụng.

---

## 🚀 Các bước tạo Codespace

### Bước 1: Điều hướng đến Repository

1. Đăng nhập vào [github.com](https://github.com)
2. Ở thanh bên trái, click vào repository bạn đã tạo ở Bước 2 (ví dụ: `codespaces-hermes-server`)
3. Trang repository sẽ hiện ra với các tab như **Code**, **Issues**, **Pull requests**, v.v.

### Bước 2: Mở Codespaces

1. Click vào nút **Code** màu xanh lá cây (góc trên bên phải)
2. Trong dropdown hiện ra, click vào tab **Codespaces**
3. Click nút **Create codespace on main** (hoặc tên nhánh mặc định)

### Bước 3: Tạo Codespace

Click **Create codespace on main** (hoặc **New codespace** nếu đã tạo trước đó).

> 💡 Mặc định Codespace dùng máy **2 core — 8GB RAM**. Nếu muốn đổi, sau khi tạo xong vào **https://github.com/codespaces** → click **`...`** → **Change machine type**. Free tier chỉ có 2 lựa chọn: 2-core (8GB) hoặc 4-core (8GB).

> ⏳ Đợi **30 giây đến 2 phút** để GitHub khởi tạo máy ảo. Lần đầu lâu nhất vì phải build Docker image; lần sau nhanh hơn nhờ cache.

##### 📀 Thông tin về ổ đĩa

Codespace free tier có **32 GB ổ cứng**, nhưng cần biết:

| Hạng mục | Dung lượng | Ghi chú |
|----------|-----------|---------|
| **💻 VS Code + extensions** | ~15 GB | VS Code tự động cài mỗi lần restart — **không thể gỡ** vì nó là một phần của Codespace image |
| **📂 Dùng được cho code & data** | ~17 GB | Đủ cho Hermes + dependencies + project files |
| **⚡ /tmp (SSD siêu nhanh)** | **~44 GB** | Tốc độ rất cao, nhưng **bị xoá khi tắt Codespace** — dùng để xử lý file tạm thời |

> 💡 **Mẹo:** Nếu bạn cần xử lý file lớn (download, extract, compile), hãy dùng thư mục `/tmp` — nó rộng gấp đôi ổ chính và nhanh hơn nhiều! Chỉ cần copy kết quả về thư mục làm việc trước khi tắt Codespace.

### Bước 4: Đợi Codespace khởi tạo

Sau khi click tạo, Codespace sẽ bắt đầu khởi tạo. Quá trình này gồm:

1. **Provisioning VM** (~30 giây) — GitHub cấp phát máy ảo
2. **Cloning repository** (~10 giây) — Code được clone vào container
3. **Chạy devcontainer** (~1-3 phút) — Docker build image theo `.devcontainer/devcontainer.json`
4. **Chạy postCreate.sh** (~2-5 phút) — Cài đặt Hermes Agent và các dependencies

> ⏳ Tổng thời gian chờ: **5-10 phút** tùy tốc độ mạng. Đây là việc chỉ xảy ra **một lần duy nhất** — lần sau start lại Codespace sẽ nhanh hơn nhiều.

---

## 🖥️ Làm quen với giao diện Codespace

Khi Codespace đã sẵn sàng, bạn sẽ thấy giao diện Visual Studio Code trong trình duyệt với các thành phần sau:

```
┌─────────────────────────────────────────────────────┐
│  🌐 codespaces-hermes-server  ● main  ───────────── │
├──────────┬──────────────────────────────────────────┤
│ 🔍      │                                          │
│ 📁      │   Welcome - VS Code                      │
│ 📂      │   ────────────────────────────            │
│ EXPLORER│   Start → Open Folder → Clone Repository │
│ ├─ .devcontainer    │                              │
│ │  ├─ devcontainer.json                            │
│ │  ├─ postCreate.sh │                              │
│ │  └─ postStart.sh  │                              │
│ ├─ docs/            │                              │
│ ├─ .gitignore       │                              │
│ ├─ LICENSE          │                              │
│ └─ README.md        │                              │
│                      │                              │
│                      │                              │
├──────────────────────┴──────────────────────────────┤
│ ⚡ bash ● codespace@main:~$ ▍                       │
└─────────────────────────────────────────────────────┘
```

### Các khu vực chính

| Khu vực | Vị trí | Chức năng |
|---------|--------|-----------|
| **🔍 Activity Bar** | Viền trái | Các icon: Explorer, Search, Source Control, Extensions |
| **📁 Explorer (Sidebar)** | Bên trái | Hiển thị cây thư mục của repository |
| **📝 Editor** | Trung tâm | Nơi bạn xem và chỉnh sửa code |
| **⚡ Terminal** | Phía dưới | Dòng lệnh để chạy commands (Bash) |
| **🌿 Branch** | Góc dưới trái | Hiển thị nhánh hiện tại (`main`) |
| **🔗 Ports** | Góc dưới phải | Quản lý port forwarding |

---

## ✅ Kiểm tra xác nhận

Mở **Terminal** trong Codespace (nếu chưa mở, nhấn `` Ctrl+` ``) và chạy các lệnh sau:

### Kiểm tra hệ thống

```bash
# Kiểm tra thông tin hệ điều hành
uname -a
```
**Kết quả mong đợi:** Thông tin Linux kernel — Codespace chạy trên container Linux (thường là Ubuntu).

```bash
# Kiểm tra dung lượng ổ đĩa
df -h
```
**Kết quả mong đợi:** Dung lượng tổng ~**30GB** (xem mục Important Notes bên dưới).

### Kiểm tra công cụ phát triển

```bash
# Kiểm tra Python
python3 --version
```
**Kết quả mong đợi:** `Python 3.x.x` (phiên bản Python mới nhất).

```bash
# Kiểm tra Git
git --version
```
**Kết quả mong đợi:** `git version 2.x.x`.

```bash
# Kiểm tra Node.js (thường có sẵn)
node --version
npm --version
```

### Kiểm tra Hermes Agent

```bash
# Kiểm tra Hermes đã được cài chưa (nếu postCreate.sh đã chạy xong)
hermes --version
```
**Kết quả mong đợi:** Hiển thị phiên bản Hermes Agent.

> 💡 Nếu lệnh `hermes --version` chưa hoạt động, có thể `postCreate.sh` vẫn đang chạy. Đợi thêm vài phút và thử lại.

---

## 🎮 Các thao tác quản lý Codespace

### Bảng điều khiển Codespace

Từ giao diện Codespace, bạn có thể thực hiện các thao tác sau:

| Thao tác | Cách thực hiện | Kết quả |
|----------|---------------|---------|
| **⏹️ Stop** | Nhấn `Ctrl+Shift+P` → gõ "Codespaces: Stop" | Dừng Codespace, giải phóng tài nguyên |
| **🔄 Restart** | Dùng Ctrl+Shift+P → "Codespaces: Restart" | Khởi động lại Codespace (áp dụng thay đổi config) |
| **🗑️ Delete** | Về [github.com/codespaces](https://github.com/codespaces) → click ⋮ → Delete | Xóa hoàn toàn Codespace |
| **💻 Open in VS Code** | Click nút "Open in VS Code" ở góc dưới trái | Mở Codespace trong VS Code Desktop |

### Từ trang GitHub

Bạn cũng có thể quản lý tất cả Codespace của mình tại: **[github.com/codespaces](https://github.com/codespaces)**

Trang này hiển thị danh sách tất cả Codespace bạn đang có, kèm trạng thái:

| Trạng thái | Ý nghĩa | Core-hours |
|------------|---------|------------|
| 🟢 **Active** | Đang chạy | Đang tiêu tốn core-hours |
| 🟡 **Inactive** | Đã stop nhưng chưa xóa | Không tốn core-hours |
| 🔴 **Shutdown** | Tắt do idle timeout | Không tốn core-hours |
| ⚪ **Deleted** | Đã xóa, không còn tồn tại | 0 |

---

## 📋 Thông tin quan trọng cần nhớ

### Bảng thông số kỹ thuật

| Thông số | Giá trị | Ghi chú |
|----------|---------|---------|
| **⏱️ Idle Timeout** | 30 phút (mặc định) → **240 phút** (sau khi cấu hình) | Đã cấu hình ở [Bước 4](04-configure-idle-timeout.md) |
| **💾 Dung lượng lưu trữ** | ~30 GB | Đủ cho Hermes Agent + code + dependencies |
| **🌐 Network** | Container có quyền truy cập Internet | Cần để tải packages và kết nối Tailscale |
| **⏰ Core-hours (Free)** | 120 giờ/tháng | Codespace 2-core: ~60 giờ chạy thực tế/tháng |
| **🔒 Tính riêng tư** | Container tách biệt, chỉ bạn có quyền truy cập | Mỗi Codespace là một container riêng |
| **📂 Lưu trữ persistent** | Dữ liệu trong `/home/codespace` được giữ lại giữa các lần stop/start | Chỉ mất khi bạn Delete Codespace |
| **🔌 Port forwarding** | Có sẵn, công khai (public) hoặc riêng tư (private) | Dùng cho Hermes API server |

### Lưu ý quan trọng

| ⚠️ | Nội dung |
|-----|----------|
| 🕒 | **Idle timeout áp dụng sau khi cấu hình xong** — nếu tạo Codespace trước khi thiết lập, bạn cần Restart Codespace để áp dụng |
| 💾 | **30GB là dung lượng tổng** — bao gồm hệ điều hành, tools, code, và packages. Hermes + dependencies chỉ chiếm vài trăm MB, thoải mái |
| 🌐 | **Codespace có Internet** — bạn có thể cài thêm bất kỳ tool nào bằng apt, pip, npm, etc. |
| ⏰ | **120 core-hours/tháng** với 2-core = tối đa 60 giờ chạy liên tục/tháng. 240 phút idle timeout giúp không lãng phí |

---

## 🔍 Xử lý sự cố thường gặp

| Vấn đề | Nguyên nhân | Giải pháp |
|--------|-------------|-----------|
| Nút "Create codespace on main" bị mờ/mất | Chưa push code lên repo | Push file `.devcontainer/*` lên nhánh `main` |
| Codespace không khởi tạo được | Hết quota core-hours | Kiểm tra tại [github.com/settings/billing](https://github.com/settings/billing) |
| postCreate.sh lỗi | File không đúng cấu trúc | Kiểm tra lại file `.devcontainer/postCreate.sh` |
| Terminal không hiển thị | Chưa mở Terminal | Nhấn `` Ctrl+` `` hoặc View → Terminal |
| Codespace chậm | Lần đầu khởi tạo | Đợi 5-10 phút, lần sau sẽ nhanh hơn |
| Mất kết nối đột ngột | Mạng không ổn định | Refresh trang, Codespace vẫn giữ trạng thái |

---

## 🎉 Chúc mừng!

Bạn đã tạo thành công Codespace đầu tiên và đã sẵn sàng chuyển sang bước cuối cùng — cài đặt Hermes Agent và kết nối remote!
---

<!-- Navigation -->
<p align="center">
  <a href="04-configure-idle-timeout.md">← Bài 4: Cấu hình Idle Timeout</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="06-install-hermes-connect-remote.md">Bài 6: Cài Hermes →</a>
</p>

<p align="center">
  <strong>Phần 5 / 7</strong>
</p>
