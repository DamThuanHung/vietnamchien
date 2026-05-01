# NHẬT KÝ SESSION — VIỆT NAM CHIẾN

> Append-only. Mỗi buổi làm việc thêm 1 entry mới ở **đầu file** (mới nhất trên cùng).
> Cập nhật qua `/ket_thuc`.

---

## Session 2026-05-02 — Visual upgrade + Vertical Slice + GitHub remote

**Thời lượng:** ~3-4 giờ
**Người làm:** Anh + Claude

### Đã làm (13 hạng mục)
1. **Dọn dẹp đầu buổi:** phát hiện 3 file modified chưa commit là feature lớn (slot system 1/2/3/4 + Q chuyển nhanh + cận chiến + đổi gỡ bom F→E) → test ổn → commit `63f2c4b` + đồng bộ docs `490292c`
2. **Setup GitHub remote:** tạo repo private https://github.com/DamThuanHung/vietnamchien, push toàn bộ 14 commit cũ + 2 commit mới
3. **Audit data vũ khí toàn bộ:** đọc weapon_data.gd (1011 dòng, 29 entry) + bomb.gd + grenade.gd + gun.gd full → phát hiện 10 bug code logic không khớp data
4. **Quyết định mục tiêu visual:** ~75% CS:GO 2 với chiến lược Vertical Slice
5. **Tạo vertical_slice.tscn:** phòng 10x10x3m, 6 thanh sắt cửa sổ, lighting AAA (ACES + SSAO + SSIL + SSR + volumetric fog density 0.022 + glow), normal map noise tường/sàn/trần, ReflectionProbe, đèn vàng OmniLight + mặt trời xiên god rays
6. **Tạo autoload `vfx_manager.gd`:** bullet impact (14 spark + 8 dust + decal lưu vĩnh viễn 60 max FIFO + flash light), blood splatter (22 hạt máu), tracer (3.5mm + 50% phát có), muzzle smoke
7. **Update muzzle_flash.gd:** multi-layer (light energy 6 + sprite emission 8 + smoke particle qua VfxManager)
8. **Update gun.gd:** gọi VfxManager cho impact/blood/tracer, forward camera shake về player
9. **Update player.gd:** headbob khi đi/chạy (sin oscillation 7-11 Hz, biên độ 0.03-0.06), weapon sway theo chuột (lerp), camera shake forward từ gun.rung_camera_khi_ban()
10. **Update scenes/player.tscn:** thêm 6 chi tiết viewmodel primitive (bolt + charging handle + rear sight + 2 sight wings + muzzle brake), material PBR ngon hơn (anisotropy 0.7 + clearcoat 0.3 + normal noise)
11. **Asset pipeline:** Sketchfab block tài khoản mới → hướng dẫn anh tạo Epic Games account → login Sketchfab → tải `wburton's AK-47` (CC-BY) → `assets/models/ak47.glb` (9.7MB texture 2k)
12. **Tạo `docs/CREDITS.md`** ghi credit `wburton`
13. **Apply ModelAK47** ext_resource vào player.tscn + auto-hide viewmodel primitive cũ trong gun.gd._ready()

### Đang dở (chuyển sang đầu buổi sau)
- **Model AK-47 không hiển thị trong viewport** — đã thử scale 1.0 → 0.3 → 0.05 vẫn không thấy. Đầu buổi 03/05 cần làm **Test 1**: double-click `ak47.glb` trong FileSystem để preview model trong Godot editor → biết model có hiển thị được không + kích thước thật → adjust transform/scale/rotation chính xác.

### Quyết định lớn
- **#008** — Mục tiêu visual = ~75% CS:GO 2 (không thể 100% với solo dev + Godot)
- **#009** — Chiến lược Vertical Slice: polish 1 cảnh nhỏ trước, nhân ra sau
- Asset CC0/CC-BY từ Sketchfab/Polyhaven/Mixamo (không tạo asset mới)

### 10 bug code logic phát hiện (chưa fix)
1. Burst M16A1 — code chỉ bắn 1 viên/phát thay vì 3
2. AoE phóng lựu (M79, RPG-7) — code chỉ raycast 1 mục tiêu, không nổ
3. Headshot multiplier `nhan_sat_thuong_dau: 4.0` — không có detection phần thân
4. Recoil chi tiết `do_giat_doc/ngang` từng khẩu — code chỉ tính theo loại
5. Accuracy đứng/đi/chạy/ngồi — không dùng
6. Hold breath sniper `co_hold_breath: true` — không có phím kích hoạt
7. Warm-up súng máy `thoi_gian_khoi_dong` — không dùng
8. Cận chiến chuột phải đâm mạnh x2 — chuột phải = ADS rỗng
9. Lựu đạn data ↔ code lệch — data 400 ST/4m vs grenade.gd hardcode 180/5m
10. Scope x4/x8 sniper `do_zoom_scope` — chỉ dùng `do_zoom_ngam`

### Memory đã lưu (cho session sau)
- `feedback_doc_roadmap.md` — phải đọc ROADMAP.md khi đề xuất task lớn
- `feedback_visual_first.md` — ưu tiên visual hơn data audit, "xong" = code XONG + đồ họa XONG
- `project_visual_target_csgo2.md` — north star = CS:GO 2 ~75%

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
