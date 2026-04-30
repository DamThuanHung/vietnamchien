# NHẬT KÝ QUYẾT ĐỊNH — VIỆT NAM CHIẾN

> Mỗi quyết định lớn ghi 1 entry. Khi anh từ chối 1 cách làm — em ghi vào đây để không đề xuất lại.
> Format: ngày | quyết định | lý do | ai đề xuất

---

## 2026-04-30

### #006 — Slash commands dùng tiếng Việt
- **Quyết định:** Dùng `/bat_dau`, `/ket_thuc`, `/danh_gia`, `/kiem_tra` thay vì `/start`, `/end`...
- **Lý do:** Vi phạm quy tắc tiếng Việt của chính dự án nếu dùng tiếng Anh
- **Đề xuất:** Anh phát hiện và yêu cầu đổi
- **Áp dụng:** Tất cả slash command trong [.claude/commands/](../.claude/commands/)

### #005 — Hooks là cơ chế đảm bảo CỨNG, memory + CLAUDE.md là MỀM
- **Quyết định:** Dùng hooks trong settings.json để chặn vi phạm quy tắc ở mức tool call
- **Lý do:** Memory + prompt có thể quên/bỏ qua. Hooks không bypass được.
- **Đề xuất:** Em (Claude) khi anh hỏi "làm sao chắc chắn tuân thủ"
- **Áp dụng:** [.claude/settings.json](../.claude/settings.json)

### #004 — Tạo file docs/ trong project, không chỉ memory
- **Quyết định:** GDD, ROADMAP, WORKFLOW... đều có file riêng trong `docs/`
- **Lý do:** Memory anh không xem được trực tiếp. File trong project là nguồn sự thật bền vững.
- **Đề xuất:** Em
- **Áp dụng:** Toàn bộ thư mục [docs/](.)

### #003 — STATE.md là file quan trọng nhất
- **Quyết định:** STATE.md được update mỗi `/ket_thuc`, đọc mỗi `/bat_dau`
- **Lý do:** Tránh em phải hỏi anh "đã làm tới đâu rồi" mỗi buổi
- **Đề xuất:** Em
- **Áp dụng:** [STATE.md](STATE.md)

## 2026-04-17

### #002 — Engine: Godot 4.6 + GDScript
- **Quyết định:** Dùng Godot 4.6 với Forward Plus, Jolt Physics, DirectX 12
- **Lý do:** Open source, miễn phí, đủ mạnh cho FPS, GDScript dễ học
- **Đề xuất:** Em (Claude)

### #001 — Tiếng Việt cho mọi identifier
- **Quyết định:** Biến/hàm/file/signal đều tiếng Việt snake_case
- **Lý do:** Game cho người Việt, dev là người Việt, đọc code thân thiện hơn
- **Đề xuất:** Anh
- **Áp dụng:** Toàn bộ codebase, được enforce bởi hook trong settings.json

---

## QUYẾT ĐỊNH ĐÃ TỪ CHỐI

*Khi anh từ chối 1 đề xuất của em, em ghi vào đây để không đề xuất lại.*

*(Trống)*
