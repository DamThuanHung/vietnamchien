---
description: Bắt đầu buổi làm việc — load STATE + BACKLOG + SESSION_LOG và đề xuất task hôm nay
---

Anh đang bắt đầu buổi làm việc mới. Em hãy thực hiện đúng quy trình bắt đầu:

1. **Đọc [docs/STATE.md](docs/STATE.md)** — biết trạng thái hiện tại của dự án
2. **Đọc top 30 dòng [docs/SESSION_LOG.md](docs/SESSION_LOG.md)** — biết buổi trước làm gì
3. **Đọc [docs/BACKLOG.md](docs/BACKLOG.md)** — biết danh sách task tiếp theo theo ưu tiên
4. **Chạy `git status` và `git log -5 --oneline`** — verify trạng thái git khớp với SESSION_LOG

Sau khi đọc xong, báo cáo cho anh theo format:

```
📍 TRẠNG THÁI HIỆN TẠI
- Buổi gần nhất: [ngày + nội dung tóm tắt 1 dòng]
- Commit cuối: [hash + message]
- Đang dở: [nếu có, từ STATE.md]

🎯 ĐỀ XUẤT HÔM NAY
[1-2 task từ BACKLOG P0, ước lượng vừa 1-2h]

⚠️ LƯU Ý
[bug/blocker/quyết định cần anh duyệt nếu có]
```

Sau đó chờ anh xác nhận hoặc đổi hướng. Không tự bắt đầu code khi anh chưa nói "làm đi" hoặc "ok".
