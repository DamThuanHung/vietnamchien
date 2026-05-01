# BACKLOG — VIỆT NAM CHIẾN

> Danh sách task. Phân theo độ ưu tiên P0 / P1 / P2.
> Cập nhật cuối mỗi buổi qua `/ket_thuc`.

---

## P0 — LÀM NGAY (3-5 task)

| # | Task | Ước lượng | Phụ thuộc |
|---|---|---|---|
| 30 | **Fix model AK-47 hiển thị** trong vertical_slice (Test 1 → adjust transform) | 30 phút - 1h | — |
| 31 | Vertical Slice Tầng 2: tải texture tường gạch nhà tù từ ambientCG → áp PBR | 1-1.5h | Anh tải 5-7 texture |
| 32 | Vertical Slice Tầng 4: animation reload + ADS cho AK-47 từ Mixamo | 2-3h | Anh tải animation |
| 4 | Thiết kế level Hỏa Lò thật (thay skeleton) — phòng giam, sân trong, 2 site bom A/B | 3-4 buổi | — |
| 22 | Thêm âm thanh nạp đạn (reload) cho từng súng | 1-1.5 giờ | Tải file reload riêng |

---

## P1 — LÀM SAU (sau khi P0 xong)

| # | Task | Ước lượng |
|---|---|---|
| 23 | Thay tiếng M1 Garand (đang dùng tạm Mosin) — tải từ freesound.org Rijam CC0 | 30 phút | Cần tài khoản freesound |
| 6 | Animation reload + ADS cho súng | 2 giờ |
| 7 | Model nhân vật cho enemy (cầm súng) | 3 giờ + có model |
| 8 | Animation bắn cho enemy | 1.5 giờ |
| 10 | Enemy biết mua súng theo economy | 2 giờ |
| 11b | Enemy biết đặt bom (đã có gỡ bom — commit a92d2c2) | 1.5 giờ |
| 14 | Build Windows test | 1 giờ |
| 33 | **10 bug code logic không khớp data** — burst M16A1, AoE M79/RPG-7, headshot multiplier, recoil chi tiết, accuracy tư thế, hold breath sniper, warm-up súng máy, cận chiến chuột phải, lựu đạn data lệch, scope x4/x8 | 4-6 buổi gộp |
| 34 | Vertical Slice Tầng 5: model nhân vật + animation từ Mixamo cho enemy | 3-4 buổi |
| 35 | Vertical Slice Tầng 6: post-processing final (color grading film, sharpen, motion blur tinh tế) | 1 buổi |

---

## P2 — Ý TƯỞNG / SAU NÀY

| # | Task | Ghi chú |
|---|---|---|
| 15 | Quyết định multiplayer: Godot Multiplayer API hay Nakama | Cần research |
| 16 | Sync vị trí player qua mạng | Sau khi quyết tech |
| 17 | Sync bắn/máu | |
| 18 | Lobby/matchmaking đơn giản | |
| 19 | Map thứ 2: Địa đạo Củ Chi | |
| 20 | Polish UI (font tiếng Việt đẹp, theme nâu/đỏ chiến tranh) | |
| 21 | Tài liệu hướng dẫn chơi cho người test alpha | |

---

## ĐÃ HOÀN THÀNH (lưu trữ)

*Chuyển task sang đây khi đánh dấu ✅. Giữ tham khảo.*

- ✅ Player di chuyển WASD + nhảy + ngồi *(session 17/04)*
- ✅ Bắn súng raycast + recoil + ADS *(session 17/04)*
- ✅ AI địch 3 trạng thái *(session 17/04)*
- ✅ HUD đầy đủ trừ scoreboard *(session 17/04)*
- ✅ Bomb defuse mechanics *(session 17/04)*
- ✅ Lựu đạn AoE *(session 17/04)*
- ✅ Buy menu *(session 17/04)*
- ✅ Round manager + economy *(session 17/04)*
- ✅ Main menu + pause menu *(session 17/04)*
- ✅ Map test sandbox *(session 17/04)*
- ✅ Skeleton map Hỏa Lò *(session 17/04)*
- ✅ Database vũ khí 1011 dòng *(session 17/04)*
- ✅ Setup hạ tầng dự án (docs/, hooks, slash commands) *(session 30/04)*
- ✅ Test build Godot — toàn bộ tính năng cũ vẫn chạy *(session 30/04)*
- ✅ Sửa lỗi: súng xoay theo chuột khi mở menu mua súng *(session 30/04)*
- ✅ Đổi menu chính làm cảnh khởi động (F5 → menu chính) *(session 30/04)*
- ✅ Bảng điểm (Tab) đầy đủ: tỷ số đội + danh sách người chơi + tổng địch *(session 30/04)*
- ✅ Bảng kết quả cuối trận: tiêu đề thắng/thua + nút về menu + đếm ngược 15s *(session 30/04)*
- ✅ Cài đặt (độ nhạy chuột, âm lượng, hiển thị FPS) — autoload CauHinh, lưu/đọc cau_hinh.cfg *(session 30/04)*
- ✅ Enemy phân phe theo map (Bộ đội Cụ Hồ vs Lính Mỹ/Lính Pháp) — autoload TranDau *(session 01/05)*
- ✅ Âm thanh bắn súng cho 28/29 vũ khí (mỗi khẩu file riêng, không fallback) — Free Firearm Sound Library + Q009 + 3 Melee + Vincent Sevedge *(session 01/05, commit d1e4499)*
- ✅ Âm thanh bước chân + beep bom + tiếng nổ lựu đạn *(session 01/05, commit d1e4499)*
- ✅ Enemy biết gỡ bom — state GO_BOM trong enemy.gd *(session 01-02/05, commit a92d2c2)*
- ✅ Hệ thống 4 slot vũ khí kiểu CS:GO (1/2/3/4 + Q chuyển nhanh) — player.gd *(session 02/05, commit 63f2c4b)*
- ✅ Vũ khí cận chiến (dao găm slot 3) — gun.gd, dùng tam_tan_cong, không trừ đạn/recoil *(session 02/05, commit 63f2c4b)*
- ✅ Đổi phím gỡ bom F→E — project.godot *(session 02/05, commit 63f2c4b)*
