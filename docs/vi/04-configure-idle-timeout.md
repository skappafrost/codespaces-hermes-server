# Cấu hình Idle Timeout cho Codespace

> ⏱️ **Thời gian:** 2 phút &nbsp;|&nbsp; 🎯 **Mục tiêu:** Tăng thời gian chờ từ 30 phút lên 240 phút

---

## 📌 Tại sao cần tăng Idle Timeout?

Mặc định, GitHub Codespaces sẽ **tự động tắt sau 30 phút không hoạt động** (idle). Đây là khoảng thời gian rất ngắn và không phù hợp khi bạn chạy Hermes Agent làm server cá nhân.

**Vấn đề với mặc định 30 phút:**

| Vấn đề | Mô tả |
|---------|-------|
| 🛑 **Codespace tắt liên tục** | Chỉ cần rời bàn phải vài phút là máy chủ Hermes ngừng hoạt động |
| 📉 **Mất kết nối** | Hermes Desktop/CLI không thể remote đến Codespace khi nó đã tắt |
| 🔄 **Phải restart thường xuyên** | Mỗi lần tắt bạn phải vào GitHub khởi động lại, mất thời gian chờ boot |
| 💸 **Lãng phí dung lượng** | Mỗi lần dừng/rồi chạy lại không tận dụng được tài nguyên đã cấp phát |

> ⚠️ **CẢNH BÁO QUAN TRỌNG:** Thiết lập này **phải được thực hiện trước khi tạo Codespace lần đầu tiên**. Idle timeout mới **chỉ có hiệu lực cho Codespace được tạo SAU KHI** bạn cấu hình. Nếu bạn đã tạo Codespace trước đó, bạn phải **xoá và tạo lại** — restart Codespace sẽ **không** áp dụng idle timeout mới.

---

## 🛠️ Các bước thực hiện

### Bước 1: Mở GitHub Settings

1. Đăng nhập vào [github.com](https://github.com)
2. Click vào **avatar** của bạn ở góc trên bên phải
3. Chọn **Settings** từ menu dropdown

![Menu Settings trên GitHub](https://docs.github.com/assets/cb-34264/mw-1440/images/help/settings/userbar-account-settings.webp)

### Bước 2: Vào mục Codespaces

1. Trong thanh bên trái của trang Settings, cuộn xuống
2. Click vào **Codespaces** (nằm trong nhóm **Code, planning, and automation**)

![Mục Codespaces trong Settings](https://docs.github.com/assets/cb-30362/mw-1440/images/help/settings/codespaces-settings.png)

### Bước 3: Điều chỉnh Idle Timeout

1. Tìm mục **Default idle timeout**
2. Nhập giá trị **`240`** (phút) — tương đương **4 giờ**
3. Click nút **Save** để lưu

![Cấu hình idle timeout](https://docs.github.com/assets/cb-41199/mw-1440/images/help/codespaces/settings-default-idle-timeout.png)

---

## 🔢 Chi tiết tùy chọn Idle Timeout

GitHub Codespaces cho phép bạn cấu hình idle timeout trong khoảng:

| Giá trị | Phù hợp cho | Ghi chú |
|---------|-------------|---------|
| **5–30 phút** | Học tập, thử nghiệm nhanh | ⚠️ Quá ngắn cho Hermes server |
| **30–60 phút** | Coding session ngắn | ⚠️ Vẫn có thể bị tắt giữa chừng |
| ****240 phút (khuyến nghị)** | **Hermes server, background task** | **✅ Cân bằng giữa uptime và core-hours** |
| 480 phút (tối đa) | Dự án chạy liên tục | ⚠️ Tiêu tốn nhiều core-hours hơn |

> 💡 **Mẹo nhỏ:** 240 phút là điểm ngọt (sweet spot) — đủ dài để Hermes luôn online khi bạn cần, nhưng đủ ngắn để Codespace tự tắt nếu bạn quên, tránh lãng phí core-hours.

---

## ⏰ Core-Hours: Hiểu để tiết kiệm

### GitHub Free được tặng **120 core-hours / tháng**

Mỗi Codespace bạn tạo sẽ tiêu thụ core-hours dựa trên:
- **Số core CPU** của máy ảo
- **Thời gian chạy** (kể cả idle, trừ khi bị timeout tắt)

**Cách tính core-hours:**

```
Core-hours = (Số core) × (Số giờ chạy)
```

Ví dụ:
- Codespace 2-core chạy 4 tiếng/ngày = 8 core-hours/ngày
- 30 ngày × 8 = 240 core-hours → **vượt quota Free**
- Nhưng Codespace sẽ **tự động tắt sau 240 phút idle** → tiết kiệm đáng kể

### Mẹo tiết kiệm core-hours

| Mẹo | Chi tiết |
|-----|----------|
| ✅ **Dùng 2-core machine** | Chọn máy 2-core thay vì 4-core hoặc 8-core — đủ chạy Hermes Agent |
| ✅ **Idle timeout 240 phút** | Không quá ngắn (mất kết nối), không quá dài (lãng phí) |
| ✅ **Stop khi không dùng** | Nếu biết sẽ không dùng trong 8+ tiếng, hãy chủ động Stop Codespace |
| ✅ **Theo dõi usage** | Vào Settings → Codespaces → xem mục **Monthly included usage** |
| ❌ **Không để nhiều Codespace chạy cùng lúc** | Mỗi Codespace tiêu tốn core-hours riêng |

---

## 🔍 Kiểm tra cấu hình đã lưu

Sau khi lưu, bạn có thể kiểm tra lại bằng cách:

1. Vào lại **Settings → Codespaces**
2. Nhìn vào mục **Default idle timeout**
3. Giá trị hiển thị sẽ là **240 minutes**

> ✅ **Xác nhận:** Cấu hình đã được lưu thành công! Giờ bạn có thể chuyển sang bước tiếp theo.

---

## ❌ Lỗi thường gặp

| Lỗi | Nguyên nhân | Cách khắc phục |
|-----|-------------|----------------|
| Không thấy mục Codespaces trong Settings | Chưa kích hoạt Codespaces | Chỉ cần tạo Codespace lần đầu là mục này xuất hiện |
| Idle timeout không áp dụng cho Codespace đang chạy | Thiết lập chỉ có hiệu lực cho Codespace được tạo **sau khi** cấu hình | Xoá Codespace cũ → tạo lại Codespace mới |
| Giá trị không lưu được | Lỗi mạng hoặc session hết hạn | Refresh trang và thử lại |
| Không thể nhập giá trị > 240 | GitHub Free giới hạn tối đa 480 phút | 240 phút là đủ dùng, không cần cao hơn |

---

<!-- Navigation -->
<p align="center">
  <a href="03-setup-devcontainer.md">← Bài 3: Cấu hình .devcontainer</a>
  &nbsp;&nbsp;|&nbsp;&nbsp;
  <a href="05-create-codespace.md">Bài 5: Tạo Codespace →</a>
</p>

<p align="center">
  <strong>Phần 4 / 7</strong>
</p>
