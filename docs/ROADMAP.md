# LỘ TRÌNH 12 THÁNG — VIỆT NAM CHIẾN

> Bắt đầu: **17/04/2026** — Alpha test mục tiêu: **17/04/2027**
> Cập nhật mỗi cuối tuần khi review tiến độ.

---

## TÓM TẮT LỘ TRÌNH

```
Tháng 1-2  ████████████████████ NỀN TẢNG          [đang ở đây]
Tháng 3-4  ░░░░░░░░░░░░░░░░░░░░ MAP HỎA LÒ + SÚNG
Tháng 5-6  ░░░░░░░░░░░░░░░░░░░░ AI ĐỊCH + OFFLINE
Tháng 7-9  ░░░░░░░░░░░░░░░░░░░░ MULTIPLAYER ONLINE
Tháng 10-12░░░░░░░░░░░░░░░░░░░░ MAP 2 + ALPHA TEST
```

---

## GIAI ĐOẠN 1 — NỀN TẢNG (Tháng 1-2: 17/04 → 17/06)

**Mục tiêu:** Player di chuyển và bắn được trong 1 map test. Có địch để bắn.

| Hạng mục | Trạng thái | Ghi chú |
|---|---|---|
| Player di chuyển WASD + nhảy + ngồi | ✅ Done | [player.gd](../scripts/player.gd) |
| Bắn súng raycast | ✅ Done | [gun.gd](../scripts/gun.gd) |
| ADS (chuột phải) | ✅ Done | |
| Nạp đạn (R) | ✅ Done | |
| Recoil | ✅ Done | |
| Map test | ✅ Done | [maps/map_test.tscn](../maps/map_test.tscn) |
| Enemy AI cơ bản | ✅ Done | [enemy.gd](../scripts/enemy.gd) |
| HUD (máu/đạn/crosshair) | ✅ Done | [hud.gd](../scripts/hud.gd) |
| Pause menu | ✅ Done | |
| Main menu | ✅ Done | |

**→ Giai đoạn này ĐÃ XONG SỚM.** Có thể chuyển sang giai đoạn 2.

---

## GIAI ĐOẠN 2 — MAP HỎA LÒ + SÚNG (Tháng 3-4: 17/06 → 17/08)

**Mục tiêu:** Có map Hỏa Lò chơi được, hệ thống vũ khí phong phú.

| Hạng mục | Trạng thái | Ghi chú |
|---|---|---|
| Skeleton map Hỏa Lò | ✅ Done | [maps/hoa_lo.tscn](../maps/hoa_lo.tscn) |
| Map Hỏa Lò có level design thật | ❌ Chưa | Hiện chỉ là skeleton |
| Database vũ khí phong phú | ✅ Done | 1011 dòng [weapon_data.gd](../scripts/weapon_data.gd) |
| Buy menu | ✅ Done | [buy_menu.gd](../scripts/buy_menu.gd) |
| Hệ thống máu/chết | ✅ Done | |
| Lựu đạn | ✅ Done | [grenade.gd](../scripts/grenade.gd) |
| Bom defuse | ✅ Done | [bomb.gd](../scripts/bomb.gd) |
| Round manager | ✅ Done | [round_manager.gd](../scripts/round_manager.gd) |
| Economy | ✅ Done | [economy.gd](../scripts/economy.gd) |
| Âm thanh súng | ❌ Chưa | Folder [assets/sounds/](../assets/sounds/) rỗng |
| Animation reload, ADS | ❌ Chưa | |
| Model nhân vật | ❌ Chưa | |

---

## GIAI ĐOẠN 3 — AI + OFFLINE HOÀN CHỈNH (Tháng 5-6: 17/08 → 17/10)

**Mục tiêu:** Bản offline 5v5 vs bot chạy được trọn 1 trận.

| Hạng mục | Trạng thái |
|---|---|
| AI nhiều loại (tuần tra/đuổi/tấn công) | ✅ Done |
| AI có team/faction (VN/Mỹ/Pháp) | ❌ Chưa |
| AI biết mua súng | ❌ Chưa |
| AI biết đặt/gỡ bom | ❌ Chưa |
| AI cầm súng và animation bắn | ❌ Chưa |
| Scoreboard hoàn chỉnh (Tab) | ❌ Chưa |
| Bảng kết quả cuối trận | ❌ Chưa |

---

## GIAI ĐOẠN 4 — MULTIPLAYER ONLINE (Tháng 7-9: 17/10 → 17/01)

**Mục tiêu:** 2 người chơi qua mạng được.

| Hạng mục | Trạng thái |
|---|---|
| Quyết định tech: Godot Multiplayer API hay Nakama | ❌ Chưa |
| Sync vị trí player | ❌ Chưa |
| Sync bắn/máu/chết | ❌ Chưa |
| Sync round/economy | ❌ Chưa |
| Lobby/matchmaking đơn giản | ❌ Chưa |
| Chống cheat cơ bản | ❌ Chưa |

---

## GIAI ĐOẠN 5 — MAP 2 + ALPHA (Tháng 10-12: 17/01 → 17/04)

**Mục tiêu:** Có 2 map chơi được, mời bạn bè test alpha.

| Hạng mục | Trạng thái |
|---|---|
| Map thứ 2 (chọn từ danh sách GDD) | ❌ Chưa |
| Polish UI/UX | ❌ Chưa |
| Settings (âm lượng, sensitivity, keybind) | ❌ Chưa |
| Build Windows | ❌ Chưa |
| Tài liệu hướng dẫn chơi | ❌ Chưa |
| Alpha test với 5-10 người | ❌ Chưa |

---

## CỘT MỐC QUAN TRỌNG

- **17/04/2026** — Khởi động dự án ✅
- **17/06/2026** — Cuối giai đoạn 1 (Nền tảng)
- **17/08/2026** — Cuối giai đoạn 2 (Map Hỏa Lò + Súng)
- **17/10/2026** — Cuối giai đoạn 3 (Offline xong)
- **17/01/2027** — Cuối giai đoạn 4 (Multiplayer)
- **17/04/2027** — **🎯 ALPHA TEST**
