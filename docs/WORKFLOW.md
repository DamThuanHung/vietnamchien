# QUY TRÌNH LÀM VIỆC — VIỆT NAM CHIẾN

> Quy tắc tương tác giữa **Anh** (developer) và **Em** (Claude AI).
> File này là hợp đồng làm việc giữa hai bên. Cả hai phải tuân thủ.

---

## 1. PHÂN VAI

| Vai | Người | Nhiệm vụ |
|---|---|---|
| Developer | Anh | Định hướng, quyết định, chạy thử, báo lỗi |
| Coder | Em (Claude) | Viết toàn bộ code, design hệ thống, đề xuất giải pháp |
| Tester | Anh | Test trong Godot, chụp màn hình lỗi |

**Anh KHÔNG cần code.** Em KHÔNG được bắt anh tự sửa hay tự đoán.

---

## 2. NGÔN NGỮ

- **100% tiếng Việt** trong giao tiếp
- Không trộn tiếng Anh trừ tên kỹ thuật bắt buộc (Godot, GDScript, raycast, signal...)
- Mọi giải thích, hướng dẫn, comment đều bằng tiếng Việt

---

## 3. TỪ KHÓA LỆNH

| Anh nói | Em làm |
|---|---|
| **"làm đi"** | Tự quyết định và thực hiện luôn, không hỏi thêm |
| **"tư vấn"** | Đưa ra các lựa chọn, để anh quyết |
| **"ok"** trong context có đề xuất | Coi như "làm đi" cho đề xuất đó |
| **"không"** / **"sai"** | Dừng, hỏi lại trước khi tiếp |

---

## 4. QUY TRÌNH MỖI BUỔI LÀM VIỆC

### Bắt đầu
Anh gõ: `/bat_dau`

Em sẽ:
1. Đọc [docs/STATE.md](STATE.md) — biết đang ở đâu
2. Đọc [docs/SESSION_LOG.md](SESSION_LOG.md) — biết buổi trước làm gì
3. Đọc [docs/BACKLOG.md](BACKLOG.md) — biết task tiếp theo
4. Báo cáo: "Hôm nay đề xuất làm X, dự kiến Y phút"

### Trong buổi
- Em viết code, anh chạy thử
- Anh báo lỗi → em sửa
- Em luôn check CLAUDE.md trước khi viết
- Magic number → const đầu file
- Số liệu súng → chỉ sửa ở `weapon_data.gd`
- Cross-scene → qua signal

### Kết thúc
Anh gõ: `/ket_thuc`

Em sẽ:
1. Update [docs/STATE.md](STATE.md) với trạng thái mới
2. Append vào [docs/SESSION_LOG.md](SESSION_LOG.md)
3. Update [docs/BACKLOG.md](BACKLOG.md) (đánh dấu xong/thêm task mới)
4. `git commit` toàn bộ thay đổi
5. Báo cáo tổng kết buổi

---

## 5. CHIA TASK

- 1 task = 1-2 giờ vừa với 1 buổi
- Task lớn hơn → em chia nhỏ
- Task nhỏ hơn → gộp lại đến đủ 1 buổi
- Mỗi task phải có **tiêu chí xong rõ ràng** (testable)

---

## 6. NẾU 3 NGÀY ANH KHÔNG NHẮN

- Em coi như tạm dừng dự án
- Buổi quay lại: anh gõ `/bat_dau`, em load context lại từ đầu
- Không hối thúc, không trách

---

## 7. CUỐI TUẦN

Anh gõ: `/danh_gia`

Em sẽ:
1. So sánh [docs/BACKLOG.md](BACKLOG.md) ↔ [docs/ROADMAP.md](ROADMAP.md) ↔ [docs/STATE.md](STATE.md)
2. Báo cáo: tuần này làm được gì, có chệch roadmap không, đề xuất tuần sau làm gì
3. Cập nhật ROADMAP nếu cần

---

## 8. KHI EM ĐỀ XUẤT GÌ LẠ

Anh chỉ cần hỏi: **"có khớp [docs/GDD.md](GDD.md) không?"** hoặc **"có khớp [CLAUDE.md](../CLAUDE.md) không?"**

Em phải:
- Tự kiểm tra ngay
- Nếu không khớp → rút lại đề xuất
- Nếu khớp → giải thích chỗ khớp

---

## 9. KHI MEMORY HẾT HẠN HOẶC SAI

- Memory chỉ là gợi nhớ nhanh, **không phải nguồn sự thật**
- Nguồn sự thật: file trong `docs/` và code thực tế
- Em phải verify bằng cách đọc file/code trước khi khẳng định

---

## 10. QUY TẮC BẤT BIẾN (KHÔNG ĐƯỢC VI PHẠM)

1. ✅ Tiếng Việt cho mọi identifier code
2. ✅ Snake_case cho biến/hàm/file
3. ✅ Không hardcode magic number
4. ✅ Số liệu súng chỉ ở `weapon_data.gd`
5. ✅ Cross-scene qua signal
6. ✅ Không xóa file mà không hỏi
7. ✅ Không force push, không reset --hard mà không hỏi
8. ✅ Mỗi buổi phải commit checkpoint trước khi nghỉ
