# NHẬT KÝ SESSION — VIỆT NAM CHIẾN

> Append-only. Mỗi buổi làm việc thêm 1 entry mới ở **đầu file** (mới nhất trên cùng).
> Cập nhật qua `/ket_thuc`.

---

## Session 2026-04-30 → 2026-05-01 — Buổi siêu năng suất

**Thời lượng:** ước lượng 4-5 giờ (buổi dài, kéo qua nửa đêm)
**Người làm:** Anh + Claude

### Đã làm (8 hạng mục lớn)
1. **Lập hạ tầng dự án** — tạo `docs/` (8 tài liệu: GDD, ROADMAP, WORKFLOW, BACKLOG, STATE, SESSION_LOG, DECISION_LOG, TESTING), `.claude/settings.json` với hooks, 4 lệnh tắt tiếng Việt (`/bat_dau`, `/ket_thuc`, `/danh_gia`, `/kiem_tra`)
2. **Sửa cảnh khởi động** — F5 đi vào menu chính thay vì map skeleton Hỏa Lò
3. **Sửa lỗi súng xoay theo chuột** khi mở menu mua súng — chặn input player + gun khi BuyMenu mở (giống CS:GO không pause tree)
4. **Bảng điểm (Tab)** đầy đủ — 2 cột đội + tỷ số + tiền + sống/chết
5. **Bảng kết quả cuối trận** — thay thông báo text 1 dòng bằng bảng điểm phóng to + tiêu đề thắng/thua + nút "Về Menu Chính" + đếm ngược 15s
6. **Cài đặt** — autoload `CauHinh`, lưu/đọc `user://cau_hinh.cfg`, giao diện 2 thanh trượt (độ nhạy + âm lượng) + công tắc FPS, mở từ main_menu hoặc pause_menu
7. **Kiểm tra build** — chạy SMOKE TEST, 7/8 mục đạt, mục 8 chỉ là "stub trống" chưa làm (đã làm ở việc 4)
8. **Phân phe theo map** — quyết định lớn: bỏ thiết kế 3 phe (VN/Mỹ/Pháp) thành 2 phe (Bộ đội Cụ Hồ vs Lính Mỹ HOẶC Lính Pháp), mỗi map có @export phe_dich. Tạo autoload `TranDau`. Bảng điểm/kết quả/thông báo dùng tên đội động.

### Phím debug (chỉ ở chế độ thử)
- **F1** — +5000$ (test menu mua súng)
- **F2** — Đội A thắng trận (test bảng kết quả)
- **F3** — Đội B thắng trận

### Lỗi gặp + cách sửa
- **Lỗi:** Action `mo_bang_diem` gắn nhầm phím Delete thay vì Tab → sửa `physical_keycode 4194312 → 4194306` trong project.godot
- **Lỗi:** Pause menu và cài đặt chồng lên nhau khi mở từ pause → ẩn pause khi mở cài đặt, hiện lại khi đóng
- **Lỗi:** Bảng điểm và bảng kết quả ban đầu dùng tên đội cứng "ĐỘI A — VIỆT NAM CHIẾN THẮNG" → đổi thành tên động từ TranDau

### Anh feedback (đã ghi vào quy tắc)
- Yêu cầu **slash command tiếng Việt** (`/start` → `/bat_dau`, `/end` → `/ket_thuc`)
- Yêu cầu **tiếng Việt 100% kể cả từ kỹ thuật có thể dịch** (PASS → ĐẠT, bug → lỗi, stub → hàm rỗng, ...)
- Yêu cầu **không hỏi kết thúc**, cứ tiếp tục cho đến khi anh nói rõ
- **Quyết định lớn:** 2 phe theo map, không 3 phe — đúng lịch sử + đúng CS:GO

### Ghi chốt trong session (8)
- `8ed3468` — chore: dọn dòng trống Godot
- `3866292` — docs: setup hạ tầng Phase 1
- `b26d4fd` — fix: đổi main scene về menu chính
- `92dcee6` — fix: chặn input khi mở buy menu
- `959af6c` — feat: bảng điểm (Tab)
- `b76a100` — feat: bảng kết quả cuối trận
- `0cc1e36` — feat: cài đặt
- `8b77518` — feat: phân phe theo map

### Vị trí trên lộ trình
- Lộ trình ban đầu: tháng 4-6 = giai đoạn 1 (Nền tảng), tháng 7-9 = giai đoạn 3 (AI offline)
- Hiện tại: đã hoàn tất giai đoạn 1+2+phần lớn 3 — đi nhanh hơn lịch ~3 tháng

### Buổi sau
- Gõ `/bat_dau` đầu buổi
- Đề xuất việc tiếp theo:
  - Việc 11 P1: Enemy biết đặt/gỡ bom (~2 giờ, không cần asset)
  - Hoặc: kiếm file âm thanh .ogg/.wav để làm việc 2 P0 (âm thanh bắn súng)
  - Hoặc: bắt đầu thiết kế level Hỏa Lò (việc 4 P0, 3-4 buổi)

---

## Session 2026-04-30 — Setup hạ tầng Phase 1

**Thời lượng:** ~1.5 giờ
**Người làm:** Anh + Claude

### Đã làm
- Audit dự án: kiểm tra code hiện tại vs memory 13 ngày
- Phát hiện: code đã tracked trong commit init `ad038d0`, chỉ project.godot pending
- Commit `8ed3468`: dọn dòng trống do Godot tự sinh
- Tạo thư mục `docs/` với 8 file:
  - GDD.md (Game Design Document)
  - ROADMAP.md (Lộ trình 12 tháng)
  - WORKFLOW.md (Quy tắc làm việc)
  - BACKLOG.md (Task backlog P0/P1/P2)
  - STATE.md (Trạng thái hiện tại)
  - SESSION_LOG.md (file này)
  - DECISION_LOG.md (Quyết định)
  - TESTING.md (Checklist test)
- Tạo `.claude/settings.json` với hooks đảm bảo quy tắc
- Tạo 4 slash commands tiếng Việt: `/bat_dau`, `/ket_thuc`, `/danh_gia`, `/kiem_tra`
- Cập nhật CLAUDE.md để link tới docs/
- Cập nhật memory cho khớp trạng thái hiện tại

### Lỗi gặp + cách fix
- *(Không có lỗi nào trong session này)*

### Anh feedback
- Đổi slash commands sang tiếng Việt (`/start` → `/bat_dau`) — đã làm
- Yêu cầu hệ thống đảm bảo "chắc chắn" tuân thủ quy tắc — đã làm bằng hooks

### Commits trong session
- `8ed3468` — chore: dọn dòng trống do Godot tự sinh
- (commit final Phase 1 sẽ ghi sau)

### Next session
1. Test `/bat_dau` xem em có load context đúng không
2. Bắt đầu task P0 #1: Test build Godot
3. Sau đó task P0 #2: Thêm âm thanh

---

## Session 2026-04-17 — Khởi động dự án (memory recall)

**Thời lượng:** ước lượng 2 buổi (~3 giờ tổng)
**Ghi chú:** Session này không có log chi tiết, dựng lại từ memory.

### Đã làm
- Kickoff dự án Việt Nam Chiến
- Viết toàn bộ 14 scripts (~2270 dòng GDScript)
- Tạo 9 scenes
- Tạo map_test.tscn và skeleton hoa_lo.tscn
- Setup project.godot với input mapping tiếng Việt
- Tạo CLAUDE.md ban đầu
- Init git repo với commit `ad038d0`

### Tính năng hoàn thành
- Player FPS (di chuyển, nhảy, ngồi, bắn, ADS, recoil, nạp)
- Enemy AI 3 trạng thái
- Bomb defuse, lựu đạn
- Buy menu, economy, round manager
- HUD đầy đủ (trừ scoreboard hoàn chỉnh)
- Main menu, pause menu

### Commits
- `ad038d0` — chore: khởi tạo git + CLAUDE.md cho dự án Vietnam Chiến
