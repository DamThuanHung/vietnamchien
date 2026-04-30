---
description: Chạy checklist test cho 1 feature theo TESTING.md — anh chạy game, em hỏi từng bước
argument-hint: [tên_feature, ví dụ: player, ban_sung, bom, enemy, round, economy, hud, smoke]
---

Anh muốn test feature: **$ARGUMENTS**

Em hãy:

1. **Đọc [docs/TESTING.md](docs/TESTING.md)** và tìm checklist tương ứng với feature `$ARGUMENTS`

2. **Nếu không có argument hoặc argument là `smoke`** → chạy SMOKE TEST tổng quát

3. **Nếu argument không có trong TESTING.md** → báo: "Chưa có checklist cho `$ARGUMENTS`. Anh muốn em soạn không?"

4. **Cách chạy:**
   - Hỏi anh từng mục một, không bắn cả list ra cùng lúc
   - Anh trả lời "ok" / "pass" / "fail [chi tiết]"
   - Em ghi nhận, sang mục kế tiếp
   - Nếu fail → hỏi chi tiết, đề xuất cách fix

5. **Cuối cùng, báo cáo:**

```
📋 KẾT QUẢ TEST [$ARGUMENTS] — [yyyy-mm-dd]

✅ PASS: [X/Y mục]
❌ FAIL: [danh sách mục fail kèm mô tả]
⏭️ SKIP: [nếu có]

🐛 BUG MỚI PHÁT HIỆN
- [bullet hoặc "Không có"]

🔧 ĐỀ XUẤT FIX
- [bullet ưu tiên cao → thấp]
```

6. Nếu phát hiện bug → thêm vào "Bug đang biết" trong [docs/STATE.md](docs/STATE.md) và tạo task fix trong [docs/BACKLOG.md](docs/BACKLOG.md) (P0 nếu blocking, P1 nếu không).

Sau test:
- Nếu tất cả pass → đề xuất đánh dấu ✅ trong STATE.md cho feature đó
- Nếu có fail → giữ 🟡 và liệt kê task fix
