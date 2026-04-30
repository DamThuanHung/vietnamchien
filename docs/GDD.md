# GAME DESIGN DOCUMENT — VIỆT NAM CHIẾN

> Tài liệu thiết kế chính thức. Mọi quyết định gameplay phải khớp file này.
> File này là **nguồn sự thật** về thiết kế game. Khi memory hết hạn — tra ở đây.

---

## 1. ĐỊNH DANH

| Hạng mục | Giá trị |
|---|---|
| Tên game | Việt Nam Chiến |
| Thể loại | FPS góc nhìn thứ nhất |
| Phong cách tham chiếu | CS:GO 2 (round + economy + bomb defuse) |
| Engine | Godot 4.6 (Forward Plus, Jolt Physics, DirectX 12) |
| Ngôn ngữ | GDScript |
| Nền tảng giai đoạn 1 | PC Windows |
| Nền tảng tương lai | Mobile (Android/iOS) |
| Đối tượng người chơi | Người Việt Nam, mọi lứa tuổi |
| Điểm khác biệt | Bối cảnh lịch sử Việt Nam (Pháp – Mỹ – Việt) |
| Ngày khởi động | 17/04/2026 |

---

## 2. CHẾ ĐỘ CHƠI

| # | Chế độ | Tiếng Anh | Số người | Ưu tiên |
|---|---|---|---|---|
| 1 | **Đặt Bom** | Bomb Defuse | 5v5 | 🔴 Làm trước (giống CS) |
| 2 | **Đấu Đội** | Team Deathmatch | 5v5 hoặc 8v8 | 🟡 Làm sau |
| 3 | **Sinh Tử** | Free For All | 8-12 | 🟡 Làm sau |
| 4 | **Sinh Tồn** | Battle Royale | 30-50 | 🟢 Cuối cùng |

### Chi tiết chế độ Đặt Bom (ưu tiên 1)
- 2 đội: tấn công đặt bom, phòng thủ gỡ bom
- Hiệp 115 giây
- Đội đầu tiên thắng 8 hiệp = thắng game
- Bom đếm ngược 40 giây, gỡ bom mất 10 giây
- Map có 2 site bom: A và B

---

## 3. MAP

### Map đã làm
- **Nhà Tù Hỏa Lò** (Hà Nội) — ban ngày — *map khởi đầu*
- **Map test** — sandbox cho dev

### Map kế hoạch
| Thứ tự | Tên | Bối cảnh |
|---|---|---|
| 2 | Địa đạo Củ Chi | Kháng chiến chống Mỹ |
| 3 | Điện Biên Phủ | Kháng chiến chống Pháp |
| 4 | Phố cổ Hội An | Đường phố |
| 5 | Vịnh Hạ Long | Biển đảo |
| 6 | Chợ Bến Thành | Sài Gòn |

---

## 4. NHÂN VẬT — 2 PHE THEO MAP

> **Quyết định 01/05/2026:** Chỉ có 2 phe trong 1 trận đánh. Đúng lịch sử (Việt Nam đánh từng cuộc kháng chiến riêng) và đúng phong cách CS:GO (2 đội).

### Đội A — Phe người chơi (cố định mọi map)
- **Tên hiển thị:** BỘ ĐỘI CỤ HỒ
- **Màu nhận diện:** Đỏ (#F24D4D)
- **Vai trò trong code:** `doi_a`, group `nguoi_choi`

### Đội B — Phe địch (thay đổi theo map)
| Phe | Tên hiển thị | Màu | Map sử dụng |
|---|---|---|---|
| `my` | LÍNH MỸ | Xanh dương (#4090FF) | Map test, Địa đạo Củ Chi (sau) |
| `phap` | LÍNH PHÁP | Xanh lá (#4DBF59) | Hỏa Lò, Điện Biên Phủ (sau) |

### Cấu hình phe địch cho map
Mỗi map .tscn có thuộc tính `@export phe_dich` trên root node (qua [game_manager.gd](../scripts/game_manager.gd)). Khi map load, [tran_dau.gd](../scripts/tran_dau.gd) (autoload) cập nhật trạng thái trận. Enemy đọc từ TranDau để có đúng tên/màu.

---

## 5. VŨ KHÍ

### Súng ban đầu (theo lịch sử Việt Nam)
| Tên | Loại | Phe |
|---|---|---|
| K54 | Súng lục | viet_nam |
| K50M | Tiểu liên | viet_nam |
| AK-47 | Súng trường | viet_nam |
| M16 | Súng trường | my |
| Mosin-Nagant | Bắn tỉa | viet_nam |
| SVD Dragunov | Bắn tỉa | viet_nam |
| RPG-7 | Phóng lựu | viet_nam |

### Database vũ khí
File: [scripts/weapon_data.gd](../scripts/weapon_data.gd) — chứa toàn bộ schema. **Không sửa số liệu ở chỗ khác.**

---

## 6. GAMEPLAY MỤC TIÊU: GIỐNG CS:GO 2

Người dùng yêu cầu rõ: **làm giống CS:GO 2 nhất có thể**.

### Tính năng bắt buộc (đã làm)
- ✅ Crosshair động (nở khi di chuyển/bắn)
- ✅ Kill feed góc trên phải
- ✅ Hệ thống hiệp + đếm giờ
- ✅ Màn hình chết + respawn
- ✅ Đếm kill / scoreboard placeholder
- ✅ Hệ thống mua súng (buy menu)
- ✅ Recoil súng
- ✅ Economy (tiền theo kill/win/lose)
- ✅ Bomb defuse mechanics

### Tính năng còn thiếu
- ❌ Âm thanh súng, bước chân, beep bom
- ❌ Scoreboard hoàn chỉnh
- ❌ Animation enemy cầm súng và bắn
- ❌ Multiplayer

---

## 7. ECONOMY (theo CS:GO)

| Hạng mục | Giá trị |
|---|---|
| Tiền ban đầu | 800$ |
| Tiền tối đa | 16000$ |
| Reward kill bằng súng | 300$ |
| Reward kill bằng dao | 800$ |
| Reward đặt/gỡ bom | 300$ |
| Win hiệp | 3250$ |
| Loss bonus (1→5 hiệp liên tiếp) | 1400$ → 3400$ |

Chi tiết: [scripts/economy.gd](../scripts/economy.gd)

---

## 8. ROUND SYSTEM

| Hạng mục | Giá trị |
|---|---|
| Thời gian 1 hiệp | 115 giây |
| Thời gian nghỉ giữa hiệp | 5 giây |
| Số hiệp để win | 8 |

Chi tiết: [scripts/round_manager.gd](../scripts/round_manager.gd)

---

## 9. RÀNG BUỘC PHI CHỨC NĂNG

- 1-2 giờ làm việc/ngày (solo dev)
- Tiếng Việt cho mọi identifier code
- Snake_case cho biến/hàm/file
- PascalCase cho class_name/enum/scene root
- Ưu tiên bản chạy được trước, đẹp sau
