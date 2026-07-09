# Tạo Repository mới (Private)

<p align="center">
  <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" alt="GitHub Logo" width="120"/>
</p>

<p align="center">
  <span style="display: inline-block; background: #28a745; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px; margin: 0 4px;">⏰ 3 phút</span>
  <span style="display: inline-block; background: #6f42c1; color: white; padding: 4px 12px; border-radius: 20px; font-size: 14px; margin: 0 4px;">💰 Miễn phí</span>
</p>

Hướng dẫn tạo repository (kho chứa mã nguồn) **Private** trên GitHub — chỉ bạn và người được mời mới có thể xem.

---

## 📋 Yêu cầu

| Yêu cầu | Chi tiết |
|----------|---------|
| ✅ Tài khoản GitHub | Đã tạo và đăng nhập (xem [bài trước](01-create-github-account.md)) |
| 🌐 Trình duyệt web | Chrome, Edge, Firefox, hoặc Safari |
| 📝 Tên repository | Chỉ gồm chữ cái, số, dấu gạch ngang (`-`) và gạch dưới (`_`) |

---

## 🚀 Các bước thực hiện

### Bước 1: Mở trang tạo Repository

Có **3 cách** để bắt đầu:

| Cách | Thao tác |
|:----:|----------|
| **1** | Nhấn nút **+** ở góc trên bên phải → chọn **"New repository"** |
| **2** | Truy cập trực tiếp: [github.com/new](https://github.com/new) |
| **3** | Từ Dashboard → nhấn nút **"Create repository"** (nếu có) |

> 💡 **Mẹo:** Cách nhanh nhất là dùng cách **2** — bookmark `github.com/new` để dùng sau này.

---

### Bước 2: Điền thông tin Repository

Trên trang tạo repository, nhập các thông tin sau:

| Trường | Giá trị | Bắt buộc? | Mô tả |
|--------|---------|:---------:|-------|
| **Owner** | Tài khoản của bạn (hoặc tổ chức) | ✅ | Chọn ai sẽ sở hữu repository này |
| **Repository name** | `ten-du-an-cua-ban` | ✅ | Tên repository — nên ngắn gọn, dễ nhớ, có ý nghĩa |
| **Description** | Mô tả ngắn về dự án | ❌ | Ví dụ: "Dự án web bán hàng đầu tiên" |
| **Visibility** | **Private** | ✅ | Chọn **Private** để chỉ bạn và cộng tác viên được mời mới truy cập được |

> ⚠️ **Cảnh báo:** Chọn **Private** nếu dự án chứa thông tin nhạy cảm, mã nguồn thương mại, hoặc bài tập cá nhân. Public repository có thể bị bất kỳ ai trên Internet nhìn thấy!

#### Giải thích chi tiết các trường

**Owner:**
- Bạn có thể tạo repository dưới tên cá nhân hoặc dưới một tổ chức (Organization)
- Nếu chưa có tổ chức, mặc định sẽ là tài khoản cá nhân của bạn

**Repository name:**
- Chỉ dùng chữ thường, số, dấu gạch ngang (`-`) và gạch dưới (`_`)
- Không dùng khoảng trắng, ký tự đặc biệt hay chữ hoa (khuyến nghị)
- Ví dụ: `my-first-project`, `blog-source`, `ecommerce-app`

**Visibility — Public vs Private:**

| Tiêu chí | Public | Private |
|----------|:------:|:-------:|
| Mọi người có thể xem | ✅ | ❌ |
| Chỉ người được mời mới xem được | ❌ | ✅ |
| Tốt cho open source | ✅ | ❌ |
| Tốt cho dự án cá nhân/công việc | ❌ | ✅ |
| GitHub Free | Không giới hạn | Không giới hạn |

---

### Bước 3: ❌ KHÔNG khởi tạo bất cứ thứ gì

Trong phần **"Initialize this repository with"**, **bỏ chọn tất cả các mục**:

| Mục | Trạng thái | Lý do |
|-----|:----------:|-------|
| Add a README file | ❌ Bỏ chọn | Sẽ thêm sau khi clone về máy |
| Add .gitignore | ❌ Bỏ chọn | Sẽ cấu hình trong `.devcontainer` |
| Choose a license | ❌ Bỏ chọn | Không cần cho private repo |

> 🎯 **Tại sao không khởi tạo?** — Chúng ta sẽ cấu hình dự án từ đầu bằng `.devcontainer` và template có sẵn, giúp kiểm soát tốt hơn cấu trúc thư mục và tránh xung đột.

---

### Bước 4: Nhấn "Create repository"

Sau khi kiểm tra lại tất cả thông tin:

| Kiểm tra | Giá trị |
|----------|---------|
| Owner | ✅ Đúng tài khoản/muốn dùng |
| Repository name | ✅ Hợp lệ, không trùng |
| Description | ✅ (tùy chọn) |
| Visibility | ✅ **Private** |
| Initialize | ✅ **Không** chọn gì |

Nhấn nút **"Create repository"** (Tạo repository).

---

### Bước 5: Trang kết quả

Sau khi tạo thành công, bạn sẽ thấy trang hướng dẫn:

```
Quick setup — if you've done this kind of thing before
or create a new repository on the command line
…
```

Trang này cung cấp các lệnh để kết nối repository local với remote:

#### 📦 Kết nối repository local có sẵn

```bash
git remote add origin https://github.com/ten-cua-ban/ten-repo.git
git branch -M main
git push -u origin main
```

#### 🆕 Tạo repository local mới

```bash
echo "# ten-repo" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/ten-cua-ban/ten-repo.git
git push -u origin main
```

> 💡 **Mẹo:** Copy các dòng lệnh này — bạn sẽ dùng chúng trong bài tiếp theo khi cấu hình `.devcontainer`.

---

## 🎯 Tổng kết

Bạn đã tạo thành công một **Repository Private** trên GitHub:

| Thuộc tính | Giá trị |
|------------|---------|
| 📌 Địa chỉ | `https://github.com/ten-cua-ban/ten-repo` |
| 🔒 Chế độ | Private |
| 📁 README | ❌ Chưa có |
| 📄 .gitignore | ❌ Chưa có |
| 📜 License | ❌ Chưa có |

---

## 📚 Bài tiếp theo

➡️ **[Cấu hình .devcontainer](03-setup-devcontainer.md)** — Thiết lập môi trường phát triển với Dev Container.

---

<p align="center">
  <a href="01-create-github-account.md">← Previous</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="03-setup-devcontainer.md">Next → Cấu hình .devcontainer</a>
</p>
