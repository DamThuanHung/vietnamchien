# CLAUDE.md — Vietnam Chiến

> Game FPS theme Chiến tranh Việt Nam (Pháp – Mỹ – Việt)
> Stack: Godot 4.6 (Forward Plus, Jolt Physics, DirectX 12) + GDScript
> Cảm hứng gameplay: Counter-Strike (round + economy + bomb defuse)

---

## 📂 TÀI LIỆU DỰ ÁN — ĐỌC TRƯỚC KHI LÀM BẤT CỨ VIỆC GÌ

| File | Khi nào đọc |
|---|---|
| [docs/STATE.md](docs/STATE.md) | **Đầu mỗi buổi** — biết đang ở đâu |
| [docs/BACKLOG.md](docs/BACKLOG.md) | **Đầu mỗi buổi** — biết task tiếp theo |
| [docs/SESSION_LOG.md](docs/SESSION_LOG.md) | Đầu buổi — biết buổi trước làm gì |
| [docs/GDD.md](docs/GDD.md) | Khi cần tra design (chế độ, vũ khí, map) |
| [docs/ROADMAP.md](docs/ROADMAP.md) | Khi cần tra lộ trình dài hạn |
| [docs/WORKFLOW.md](docs/WORKFLOW.md) | Khi cần tra quy tắc tương tác |
| [docs/TESTING.md](docs/TESTING.md) | Trước khi đánh dấu task ✅ |
| [docs/DECISION_LOG.md](docs/DECISION_LOG.md) | Khi đề xuất → kiểm tra đã từ chối chưa |

---

## ✅ PRE-FLIGHT CHECKLIST (mỗi turn em phải tự confirm)

```
[ ] Đã đọc STATE.md để biết đang làm gì?
[ ] Identifier mới có dùng tiếng Việt snake_case không?
[ ] Magic number đã đưa lên const chưa?
[ ] Số liệu vũ khí có nằm trong weapon_data.gd, không lẫn vào gun.gd?
[ ] Tương tác cross-scene có dùng signal không?
[ ] Có giữ nguyên gameplay loop CS:GO không?
```

---

## VAI TRÒ AI

Bạn là **Game Developer AI** cho dự án solo này.
Nhiệm vụ: viết GDScript sạch, đặt tên tiếng Việt nhất quán, không phá vỡ gameplay loop hiện có.

**Quy trình mỗi buổi:** xem [docs/WORKFLOW.md](docs/WORKFLOW.md). Tóm tắt:
- Anh gõ `/bat_dau` → em load STATE + BACKLOG + SESSION_LOG, đề xuất task
- Anh gõ `/ket_thuc` → em update STATE + SESSION_LOG + BACKLOG, commit
- Anh gõ `/danh_gia` → em review tuần
- Anh gõ `/kiem_tra` → em chạy checklist trong TESTING.md

---

## QUY TẮC BẤT BIẾN

1. **Tiếng Việt cho mọi identifier** (biến, hàm, signal, action). Đây là quy ước CỨNG của dự án — không trộn lẫn tiếng Anh kiểu `playerHealth`, dùng `mau_hien_tai`.
2. **Snake_case** cho biến/hàm/file (theo chuẩn GDScript + tiếng Việt không dấu).
3. **PascalCase** cho class_name, enum, scene root.
4. **Không hardcode magic number** trong logic gameplay — đưa lên `const` đầu file.
5. Khi sửa số liệu vũ khí — sửa trong `scripts/weapon_data.gd`, KHÔNG sửa trực tiếp trong `gun.gd`.
6. Mọi tương tác giữa node phải qua **signal** hoặc qua `get_node()` trong `_ready()`, không reach across scene tree giữa chừng.
7. Khi không chắc — đọc code thực tế, không đoán.

---

## ARCHITECTURE TỔNG QUAN

### Gameplay loop (kiểu CS:GO)
```
Main Menu → chọn map → vào map
  ├─ RoundManager: 115s/hiệp, nghỉ 5s, đội đầu tiên thắng 8 hiệp = thắng game
  ├─ Player (CharacterBody3D, group "nguoi_choi"):
  │    └─ Camera3D
  │         └─ Gun (xử lý input bắn/ngắm/nạp + raycast)
  ├─ Economy: tiền theo kết quả hiệp + kill, max 16000$
  ├─ BuyMenu (mở bằng B): mua súng từ weapon_data.SUNG
  ├─ HUD: máu, đạn, tiền, thời gian, killfeed, scoreboard (Tab)
  └─ Enemy (group "dich"): NavigationAgent3D, state machine TUAN_TRA/TRUY_DUOI/TAN_CONG
```

### Scene chính
| File | Vai trò |
|---|---|
| `maps/hoa_lo.tscn` | Map khởi đầu — nhà tù Hỏa Lò (set trong project.godot) |
| `maps/map_test.tscn` | Map test sandbox |
| `scenes/player.tscn` | Player FPS (chứa Camera3D/Gun, BuyMenu, Economy, HUD) |
| `scenes/enemy.tscn` | Bot AI có NavigationAgent3D + thanh máu world-space |
| `scenes/round_manager.tscn` | Quản lý hiệp + điểm |
| `scenes/buy_menu.tscn` | Menu mua súng (CanvasLayer) |
| `scenes/bomb.tscn` / `grenade.tscn` | Bom đặt + lựu đạn ném |
| `scenes/hud.tscn` | HUD trong game |
| `scenes/main_menu.tscn` / `pause_menu.tscn` | UI menu |

### Script ↔ Scene mapping
Mỗi `.tscn` có 1 `.gd` cùng tên trong `scripts/`. `weapon_data.gd` là **data class** (không attach vào scene), được `new()` ad-hoc.

---

## INPUT MAPPING (đã định nghĩa trong project.godot)

| Action | Phím | Ghi chú |
|---|---|---|
| `di_truoc` `di_lui` `di_trai` `di_phai` | W A S D | Di chuyển |
| `jump` | Space | Nhảy |
| `chay` | Shift | **Đi nhẹ** (ngược CS truyền thống — Shift = walk, mặc định = chạy) |
| `ngoi` | Ctrl | Crouch |
| `ban` | Chuột trái | Bắn / ném lựu đạn / chém cận chiến |
| `ngam` | Chuột phải | ADS |
| `nap_dan` | R | Reload (cận chiến không nạp được) |
| `dat_bom` | E | Đặt bom (nếu có) / Gỡ bom (nếu trong tầm 2.5m) |
| `chon_slot_1` | 1 | Chọn slot súng chính |
| `chon_slot_2` | 2 | Chọn slot súng lục |
| `chon_slot_3` | 3 | Chọn slot cận chiến (mặc định dao găm) |
| `chon_slot_4` | 4 | Chọn slot lựu đạn (chuột trái = ném) |
| `chuyen_nhanh` | Q | Nhảy nhanh về slot vừa cầm trước đó (kiểu CS) |
| `mo_buy_menu` | B | Mở/đóng menu mua súng |
| `mo_bang_diem` | Tab | Xem điểm |

---

## ECONOMY & ROUND (constants chính)

`scripts/round_manager.gd`:
- `THOI_GIAN_HIEU_P = 115` giây
- `THOI_GIAN_NGHI = 5` giây giữa hiệp
- `SO_THANG_DE_WIN = 8` hiệp

`scripts/economy.gd`:
- `TIEN_BAN_DAU = 800$`, `TIEN_TOI_DA = 16000$`
- Reward: kill súng 300$, kill dao 800$, đặt/gỡ bom 300$
- Loss bonus: thua 1→5 hiệp liên tiếp = 1400 → 3400$
- Win hiệp: 3250$, Lose hiệp cơ bản: 1400$

---

## WEAPON DATA SCHEMA

Mỗi entry trong `SUNG` (file `scripts/weapon_data.gd`) cần các trường:

**Bắt buộc:** `ten`, `loai`, `phe`, `gia`, `sat_thuong`, `nhan_sat_thuong_dau`, `chuot_trai`, `chuot_phai`, `dan_trong_bang`, `so_bang_du_phong`, `thoi_gian_nap`, `kieu_ban`, `he_so_toc_do`

**Cho súng có ngắm:** `tam_ban`, `toc_do_ban`, `toc_do_ngam`, `do_zoom_ngam`, `do_chinh_xac_ngam`, `do_giat_doc`, `do_giat_ngang`, `toc_do_hoi_phuc`, `recoil_khi_di_chuyen`, `recoil_khi_ngam`, `do_chinh_xac_dung/di/chay/ngoi`

**Loại (`loai`):** `can_chien`, `sung_luc`, `tieu_lien`, `sung_truong`, `sung_may`, `ban_tia`, `phong_luu`, `luu_dan`

**Phe (`phe`):** `viet_nam`, `my`, `phap`, `chung`

**Kiểu bắn (`kieu_ban`):** `tu_dong`, `ban_tu_dong`, `bolt_action`, `burst`, `can_chien`, `nem`

> Khi thêm vũ khí mới: copy 1 block hoàn chỉnh trong file rồi đổi key + thông số. BuyMenu tự sinh button theo `THU_TU_LOAI`.

---

## CONVENTION ĐẶT TÊN TIẾNG VIỆT (đã thấy trong code)

| Khái niệm | Tiếng Việt dùng trong code |
|---|---|
| Player | `nguoi_choi` (group + biến) |
| Enemy | `dich` (group), `Enemy` (class) |
| Health | `mau_hien_tai`, `mau_toi_da` |
| Damage | `sat_thuong`, `nhan_sat_thuong()` |
| Money | `tien` |
| Round | `hiep_p` (typo: nên là `hiep` — xem Decision Log) |
| Team | `doi_a`, `doi_b` |
| Magazine | `dan_trong_bang`, `so_bang_du_phong` |
| Recoil | `do_giat_doc`, `do_giat_ngang` |
| ADS | `dang_ngam`, `do_zoom_ngam` |
| Detect range | `tam_phat_hien` |

---

## CHECKLIST TRƯỚC KHI VIẾT CODE

```
[ ] Đã đọc CLAUDE.md này?
[ ] Identifier mới có dùng tiếng Việt snake_case không?
[ ] Magic number đã đưa lên const chưa?
[ ] Số liệu vũ khí có nằm trong weapon_data.gd, không lẫn vào gun.gd?
[ ] Tương tác cross-scene có dùng signal không?
[ ] Có giữ nguyên gameplay loop CS:GO (round → buy → fight → reset) không?
```

---

## FOLDER STRUCTURE

```
vietnam-chien/
├── project.godot           # Cấu hình engine + input map
├── icon.svg
├── maps/                   # File .tscn map
├── scenes/                 # Prefab/scene reusable
├── scripts/                # GDScript (1 .gd cho 1 scene + weapon_data, game_manager)
├── ui/                     # (rỗng — sẽ chứa theme/font sau)
├── assets/
│   ├── models/             # .glb / .gltf
│   ├── textures/
│   ├── sounds/
│   └── music/
└── CLAUDE.md
```

---

## DECISION LOG

➡️ Đã tách ra file riêng: [docs/DECISION_LOG.md](docs/DECISION_LOG.md)

Khi anh từ chối 1 cách làm — ghi vào file đó để không đề xuất lại.

---

## TODO ĐÃ BIẾT (từ đọc code)

- [ ] HUD chưa thấy script nội bộ (chỉ thấy gọi từ ngoài) — cần đọc kỹ `scripts/hud.gd` khi sửa HUD
- [ ] Folder `ui/` rỗng — chưa có theme/font hệ thống
- [ ] Chưa có git history — file `.editorconfig`/`.gitattributes` đã có sẵn nhưng chưa từng commit
- [ ] `bomb.gd` / `grenade.gd` / `muzzle_flash.gd` chưa được đọc trong session setup này — đọc khi cần sửa
- [ ] Enemy chỉ có 1 loại AI cơ bản, chưa có team/faction (Mỹ vs VN vs Pháp)
- [ ] Chưa có hệ thống score/scoreboard hoàn chỉnh (chỉ có placeholder)
- [ ] Map mới chỉ có 2 file, chưa có pipeline tạo map nhanh
