# TRẠNG THÁI HIỆN TẠI — VIỆT NAM CHIẾN

> **File quan trọng nhất.** Em đọc đầu mỗi buổi để biết đang ở đâu.
> Cập nhật: cuối mỗi buổi qua `/ket_thuc`.

---

## CẬP NHẬT GẦN NHẤT

- **Ngày:** 2026-05-02
- **Commit gần nhất:** sẽ commit ở `/ket_thuc` buổi này — visual upgrade + Vertical Slice + GitHub remote setup
- **Build cuối cùng chạy được:** ✅ vertical_slice.tscn chạy với lighting AAA + VFX bắn ngon
- **Session hiện tại:** ĐÃ KẾT THÚC. Buổi visual upgrade lớn — 13 hạng mục (xem SESSION_LOG.md).
- **Repo cloud:** https://github.com/DamThuanHung/vietnamchien (private, đã push)

## ĐANG DỞ (ưu tiên đầu buổi sau)

- **Model AK-47 không hiển thị trong viewport** dù file `assets/models/ak47.glb` (9.7MB, từ Sketchfab) đã copy vào project và instance trong `scenes/player.tscn`. Đã thử scale 1.0 → 0.3 → 0.05, vẫn không thấy. Cần làm **Test 1** đầu buổi sau: trong Godot FileSystem, double-click `ak47.glb` để preview model — biết model có hiển thị được không, từ đó adjust transform.

---

## TÍNH NĂNG — TRẠNG THÁI CHI TIẾT

### Player
| Tính năng | Trạng thái | File |
|---|---|---|
| Di chuyển WASD | ✅ Done | [player.gd](../scripts/player.gd) |
| Nhảy (Space) | ✅ Done | |
| Ngồi (C/Ctrl) | ✅ Done | |
| Chạy (Shift = đi nhẹ, mặc định = chạy) | ✅ Done | |
| Camera FPS | ✅ Done | |

### Bắn súng
| Tính năng | Trạng thái | File |
|---|---|---|
| Raycast bắn | ✅ Done | [gun.gd](../scripts/gun.gd) |
| ADS chuột phải | ✅ Done | |
| Recoil dọc + ngang | ✅ Done | |
| Nạp đạn (R) | ✅ Done | |
| Muzzle flash | ✅ Done | [muzzle_flash.gd](../scripts/muzzle_flash.gd) |
| Animation reload | ❌ Chưa | |
| Animation ADS | ❌ Chưa | |
| Âm thanh bắn | ❌ Chưa | Folder sounds rỗng |

### Vũ khí
| Tính năng | Trạng thái | File |
|---|---|---|
| Database 1011 dòng | ✅ Done | [weapon_data.gd](../scripts/weapon_data.gd) |
| Buy menu (B) | ✅ Done | [buy_menu.gd](../scripts/buy_menu.gd) |
| Lựu đạn (slot 4) | ✅ Done | [grenade.gd](../scripts/grenade.gd) |
| Bom defuse (E) | ✅ Done | [bomb.gd](../scripts/bomb.gd) |
| Hệ thống 4 slot vũ khí (1/2/3/4 + Q chuyển nhanh) | ✅ Done | [player.gd](../scripts/player.gd) |
| Vũ khí cận chiến (dao găm slot 3) | ✅ Done | [gun.gd](../scripts/gun.gd) tam_tan_cong, không trừ đạn |
| Âm thanh bắn (28/29 vũ khí) | ✅ Done | commit d1e4499 |
| Âm thanh bước chân + beep bom + nổ lựu đạn | ✅ Done | commit d1e4499 |

### Enemy
| Tính năng | Trạng thái | File |
|---|---|---|
| AI 3 trạng thái (tuần tra/đuổi/tấn công) | ✅ Done | [enemy.gd](../scripts/enemy.gd) |
| NavigationAgent3D | ✅ Done | |
| Thanh máu world-space | ✅ Done | |
| Cầm súng có model | ❌ Chưa | |
| Animation bắn | ❌ Chưa | |
| Phân phe theo map (Mỹ / Pháp) | ✅ Done | TranDau autoload + @export phe_dich, mỗi map 1 phe địch |
| Biết mua súng | ❌ Chưa | |
| Biết gỡ bom | ✅ Done | enemy.gd state GO_BOM (commit a92d2c2) |
| Biết đặt bom | ❌ Chưa | |

### HUD
| Tính năng | Trạng thái | File |
|---|---|---|
| Máu | ✅ Done | [hud.gd](../scripts/hud.gd) |
| Đạn | ✅ Done | |
| Tiền ($) | ✅ Done | |
| Crosshair động | ✅ Done | |
| Kill feed | ✅ Done | |
| Đồng hồ hiệp | ✅ Done | |
| Điểm A/B | ✅ Done | |
| HUD bom | ✅ Done | |
| Thanh gỡ bom | ✅ Done | |
| Bảng điểm (Tab) đầy đủ | ✅ Done | Hiện tỷ số 2 đội + người chơi + tổng địch |

### Round / Economy
| Tính năng | Trạng thái | File |
|---|---|---|
| 115s/hiệp, win 8/15 | ✅ Done | [round_manager.gd](../scripts/round_manager.gd) |
| Reset player giữa hiệp | ✅ Done | |
| Kết thúc game → main_menu | ✅ Done | |
| Economy CS:GO style | ✅ Done | [economy.gd](../scripts/economy.gd) |
| Loss bonus 1400→3400$ | ✅ Done | |

### Menu / UI
| Tính năng | Trạng thái | File |
|---|---|---|
| Main menu | ✅ Done | [main_menu.gd](../scripts/main_menu.gd) |
| Pause menu (ESC) | ✅ Done | [pause_menu.gd](../scripts/pause_menu.gd) |
| Buy menu (B) | ✅ Done | [buy_menu.gd](../scripts/buy_menu.gd) |
| Cài đặt (độ nhạy, âm lượng, FPS) | ✅ Done | Lưu vào user://cau_hinh.cfg, mở từ main_menu hoặc pause_menu |
| Bảng kết quả cuối trận | ✅ Done | Hiện bảng điểm + tiêu đề thắng/thua + đếm ngược 15s + nút về menu |

### Map
| Tên | Trạng thái | File |
|---|---|---|
| map_test | ✅ Có 4 tường, 5 địch, bom site A/B, 9 thùng | [map_test.tscn](../maps/map_test.tscn) |
| hoa_lo (Hỏa Lò) | 🟡 Skeleton — chưa có level design thật | [hoa_lo.tscn](../maps/hoa_lo.tscn) |

### Multiplayer
| Tính năng | Trạng thái |
|---|---|
| Tech stack quyết định | ❌ Chưa |
| Sync vị trí | ❌ Chưa |
| Sync bắn/máu | ❌ Chưa |
| Lobby | ❌ Chưa |

---

## BUG ĐANG BIẾT

*(Trống — chưa có bug nào ghi nhận trong session này)*

---

## FILE ĐANG DỞ

*(Trống)*

---

## NEXT 3 TASKS (lấy từ [BACKLOG.md](BACKLOG.md))

P0 đầu buổi sau:
1. **Fix model AK-47 hiển thị** trong vertical_slice.tscn (Test 1 → adjust transform)

P0 lớn — Vertical Slice tiếp:
2. Tải texture tường gạch nhà tù PBR từ ambientCG → áp vào vertical_slice.tscn (Tầng 2)
3. Animation reload + ADS cho AK-47 (Tầng 4) — tải animation từ Mixamo

P1 — fix code logic (10 bug đã phát hiện):
4. Burst M16A1, AoE M79/RPG-7, headshot multiplier, recoil chi tiết, accuracy tư thế, hold breath, warm-up súng máy, cận chiến chuột phải, lựu đạn data lệch, scope x4/x8
