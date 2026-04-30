# NHẬT KÝ SESSION — VIỆT NAM CHIẾN

> Append-only. Mỗi buổi làm việc thêm 1 entry mới ở **đầu file** (mới nhất trên cùng).
> Cập nhật qua `/ket_thuc`.

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
