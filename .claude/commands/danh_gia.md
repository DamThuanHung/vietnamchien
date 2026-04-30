---
description: Đánh giá tuần — so sánh BACKLOG ↔ ROADMAP ↔ STATE, báo gap, đề xuất tuần sau
---

Anh muốn đánh giá tiến độ. Em hãy:

1. **Đọc [docs/STATE.md](docs/STATE.md), [docs/BACKLOG.md](docs/BACKLOG.md), [docs/ROADMAP.md](docs/ROADMAP.md), [docs/SESSION_LOG.md](docs/SESSION_LOG.md)** (top 100 dòng cuối cùng)

2. **Chạy `git log --oneline --since="7 days ago"`** — xem commits 7 ngày qua

3. **Phân tích:**
   - Tuần qua làm được gì (tính theo task xong + commits)
   - Còn vướng task nào? Tại sao?
   - So với ROADMAP, đang ở đâu? Có chệch không?
   - Tốc độ trung bình (giờ/buổi, task/tuần)

4. **Báo cáo theo format:**

```
📅 ĐÁNH GIÁ TUẦN [yyyy-mm-dd → yyyy-mm-dd]

✅ ĐÃ LÀM (tuần qua)
- [bullet]

🚧 ĐANG LÀM
- [bullet hoặc "Không có"]

❌ CHƯA LÀM (theo BACKLOG P0 đã đặt)
- [bullet hoặc "Tất cả P0 đã xong"]

📊 SO VỚI ROADMAP
- Đang ở giai đoạn: [tháng X-Y theo ROADMAP]
- Tiến độ: [đúng kế hoạch / sớm / trễ X tuần]
- Chệch hướng nếu có: [bullet]

💡 ĐỀ XUẤT TUẦN SAU
- Top 3 task ưu tiên: [bullet với ước lượng giờ]
- Cần quyết định gì: [bullet hoặc "Không có"]

⚙️ ĐIỀU CHỈNH ROADMAP nếu cần
- [bullet hoặc "Không cần"]
```

Sau đó hỏi anh: "Anh thấy đề xuất tuần sau ổn không? Có muốn đổi gì?"

Nếu anh đồng ý → update [docs/BACKLOG.md](docs/BACKLOG.md) và [docs/ROADMAP.md](docs/ROADMAP.md) theo đó, rồi commit.
