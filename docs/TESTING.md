# CHECKLIST TEST — VIỆT NAM CHIẾN

> Trước khi đánh dấu 1 feature là ✅ Done, phải pass checklist tương ứng ở đây.
> Anh chạy theo, em hỏi từng bước.

---

## SMOKE TEST (chạy mỗi buổi sau khi sửa code)

- [ ] Mở Godot, project load không lỗi
- [ ] Nhấn F5 → main_menu xuất hiện
- [ ] Click "Chơi Ngay" → vào map không crash
- [ ] Player di chuyển WASD được
- [ ] Bắn chuột trái — đạn ra, có muzzle flash
- [ ] ESC → pause menu hiện
- [ ] B → buy menu hiện
- [ ] Tab → scoreboard hiện (kể cả placeholder)

**Nếu 1 mục fail → KHÔNG commit, sửa trước.**

---

## TEST PLAYER

- [ ] WASD di chuyển 4 hướng đúng
- [ ] Space nhảy có gravity hợp lý
- [ ] Shift = đi nhẹ (chậm hơn mặc định)
- [ ] Ctrl/C = ngồi, camera hạ thấp
- [ ] Camera FPS không lệch khi xoay 360°
- [ ] Không xuyên tường

## TEST BẮN SÚNG

- [ ] Chuột trái = bắn, raycast trúng tường có hit mark
- [ ] Recoil dọc rõ rệt
- [ ] Recoil ngang random trái/phải
- [ ] Chuột phải = ADS, FOV thu nhỏ
- [ ] R = nạp đạn, có cooldown
- [ ] Hết đạn không bắn được

## TEST VŨ KHÍ

- [ ] B mở buy menu, hiện theo phân loại
- [ ] Mua súng → tiền trừ đúng
- [ ] Không đủ tiền → không mua được
- [ ] Đổi súng → animation chuyển có hợp lý
- [ ] G = ném lựu đạn, nổ sau 3s, sát thương AoE 5m

## TEST BOM

- [ ] F khi đứng ở site = đặt bom
- [ ] Bom đếm ngược 40s
- [ ] F khi gần bom = gỡ, mất 10s
- [ ] Bom nổ → sát thương + thắng hiệp cho phe đặt

## TEST ENEMY AI

- [ ] Enemy ở chế độ tuần tra ban đầu
- [ ] Nhìn thấy player → chuyển truy đuổi
- [ ] Vào tầm bắn → tấn công
- [ ] Bắn enemy → máu giảm, có hiệu ứng
- [ ] Enemy chết → biến mất / nằm xuống

## TEST ROUND

- [ ] Hiệp bắt đầu, đồng hồ đếm 115s
- [ ] Hết hiệp → 5s nghỉ → hiệp tiếp
- [ ] Đội nào thắng → +1 điểm A hoặc B
- [ ] Đạt 8 thắng → kết thúc game, về main_menu

## TEST ECONOMY

- [ ] Bắt đầu: 800$
- [ ] Kill = +300$ (súng) / +800$ (dao)
- [ ] Win hiệp = +3250$
- [ ] Lose hiệp đầu = +1400$
- [ ] Lose 5 hiệp liên tiếp = +3400$
- [ ] Cap 16000$, không vượt

## TEST HUD

- [ ] Máu hiển thị, giảm khi bị bắn
- [ ] Đạn hiển thị, giảm khi bắn
- [ ] Tiền hiển thị đúng
- [ ] Crosshair nở khi di chuyển/bắn
- [ ] Kill feed hiện khi giết enemy
- [ ] Đồng hồ hiệp đếm ngược chuẩn

---

## CHECKLIST TRƯỚC KHI COMMIT

- [ ] Code không có TODO/FIXME mới
- [ ] Không có `print()` debug còn sót
- [ ] Identifier mới đều tiếng Việt snake_case
- [ ] Magic number đã đưa lên `const`
- [ ] Smoke test pass
- [ ] [docs/STATE.md](STATE.md) đã update nếu trạng thái thay đổi
- [ ] [docs/SESSION_LOG.md](SESSION_LOG.md) đã append entry buổi này
- [ ] [docs/BACKLOG.md](BACKLOG.md) đã đánh dấu task xong / thêm task mới

---

## CHECKLIST TRƯỚC KHI ĐÁNH DẤU TASK ✅

- [ ] Tính năng chạy đúng theo mô tả task trong BACKLOG
- [ ] Đã pass test phần liên quan ở trên
- [ ] Không gây regression cho tính năng cũ
- [ ] Code được commit
- [ ] STATE.md đã update từ ❌/🟡 → ✅
