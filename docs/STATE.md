# TRẠNG THÁI HIỆN TẠI — VIỆT NAM CHIẾN

> **File quan trọng nhất.** Em đọc đầu mỗi buổi để biết đang ở đâu.
> Cập nhật: cuối mỗi buổi qua `/ket_thuc`.

---

## CẬP NHẬT GẦN NHẤT

- **Ngày:** 2026-04-30
- **Commit gần nhất:** `8ed3468` — chore: dọn dòng trống do Godot tự sinh
- **Build cuối cùng chạy được:** Chưa verify trong session này — cần test khi mở Godot
- **Session hiện tại:** Setup hạ tầng Phase 1 (docs + hooks + commands)

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
| Lựu đạn (G) | ✅ Done | [grenade.gd](../scripts/grenade.gd) |
| Bom defuse (F) | ✅ Done | [bomb.gd](../scripts/bomb.gd) |

### Enemy
| Tính năng | Trạng thái | File |
|---|---|---|
| AI 3 trạng thái (tuần tra/đuổi/tấn công) | ✅ Done | [enemy.gd](../scripts/enemy.gd) |
| NavigationAgent3D | ✅ Done | |
| Thanh máu world-space | ✅ Done | |
| Cầm súng có model | ❌ Chưa | |
| Animation bắn | ❌ Chưa | |
| Phân team/faction (VN/Mỹ/Pháp) | ❌ Chưa | |
| Biết mua súng | ❌ Chưa | |
| Biết đặt/gỡ bom | ❌ Chưa | |

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
| Scoreboard (Tab) đầy đủ | ❌ Chỉ placeholder | |

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
| Settings (âm lượng, sensitivity) | ❌ Chưa | |
| Bảng kết quả cuối trận | ❌ Chưa | |

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

1. Test build hiện tại trong Godot — verify mọi tính năng còn chạy
2. Thêm âm thanh bắn súng cho 3-5 súng chính
3. Hoàn thiện scoreboard (Tab) hiển thị đủ team/kill/death/score
