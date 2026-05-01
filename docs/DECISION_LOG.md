# NHẬT KÝ QUYẾT ĐỊNH — VIỆT NAM CHIẾN

> Mỗi quyết định lớn ghi 1 entry. Khi anh từ chối 1 cách làm — em ghi vào đây để không đề xuất lại.
> Format: ngày | quyết định | lý do | ai đề xuất

---

## 2026-05-02

### #009 — Chiến lược Vertical Slice cho visual upgrade
- **Quyết định:** Polish 1 cảnh nhỏ (1 phòng + 1 súng + 1 enemy) lên ~75% CS:GO 2 trước trong file `maps/vertical_slice.tscn`, sau đó nhân kỹ thuật ra cho map_test/hoa_lo và 28 súng còn lại.
- **Lý do:** Tránh polish nhẹ 100 chỗ rồi không thấy đâu vào đâu. Vertical Slice chứng minh được cho user là engine + asset có thể đạt tới mức đó, sau đó nhân ra có template.
- **Đề xuất:** Em (Claude)
- **Áp dụng:** [maps/vertical_slice.tscn](../maps/vertical_slice.tscn) — phòng 10x10x3m + lighting AAA + VFX bắn ngon

### #008 — Mục tiêu visual = ~75% CS:GO 2 (không phải 100%)
- **Quyết định:** Đặt north star visual cho game = CS:GO 2 nhưng mục tiêu thực tế là đạt ~70-80% chứ không phải 100%.
- **Lý do:**
  1. Em không tạo được asset 3D (model, texture, animation) — phải dựa vào CC0/CC-BY từ Sketchfab/Polyhaven/Mixamo
  2. Godot 4.6 ≠ Source 2 — một số kỹ thuật của CS2 (volumetric smoke vật lý, network rollback) không có sẵn
  3. Solo dev 1-2h/ngày ≠ 50-100 dev Valve nhiều năm
- **Đề xuất:** Em (Claude) — giải thích sự thật, không hứa quá
- **Áp dụng:** Mọi đề xuất visual đối chiếu CS:GO 2, asset từ CC0, lộ trình 6-9 tháng tới alpha test

## 2026-05-01

### #007 — Game chỉ có 2 phe trong 1 trận, phe địch thay đổi theo map
- **Quyết định:** Bỏ thiết kế 3 phe (VN/Mỹ/Pháp) chung 1 trận. Mỗi map có 1 phe địch riêng (Mỹ HOẶC Pháp). Đội A luôn là Bộ đội Cụ Hồ.
- **Lý do:**
  1. Đúng lịch sử Việt Nam — không đánh Mỹ + Pháp cùng lúc trong cùng cuộc chiến
  2. Đúng phong cách CS:GO — 2 đội rõ ràng, không 3
  3. Đúng GDD ban đầu (Phe Bắc — Đội Đỏ vs Phe Nam — Đội Xanh)
  4. Bảng điểm 2 cột to gọn hơn 3 hàng nhỏ
- **Đề xuất:** Anh phát hiện và yêu cầu sửa
- **Áp dụng:** [scripts/tran_dau.gd](../scripts/tran_dau.gd) autoload, @export phe_dich trong [game_manager.gd](../scripts/game_manager.gd), [docs/GDD.md](GDD.md) section 4 đã cập nhật

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
