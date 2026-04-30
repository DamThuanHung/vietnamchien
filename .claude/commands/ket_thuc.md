---
description: Kết thúc buổi — update STATE + SESSION_LOG + BACKLOG, commit, báo cáo tổng kết
---

Anh đang kết thúc buổi làm việc. Em hãy thực hiện đúng quy trình kết thúc:

1. **Chạy `git status` và `git diff --stat`** — xem buổi này đã sửa file gì
2. **Update [docs/STATE.md](docs/STATE.md):**
   - Cập nhật ngày, commit gần nhất
   - Đổi trạng thái tính năng đã hoàn thành: ❌ → 🟡 → ✅
   - Cập nhật bug đang biết, file đang dở
   - Cập nhật "Next 3 tasks" theo BACKLOG mới
3. **Append entry vào [docs/SESSION_LOG.md](docs/SESSION_LOG.md)** ở **đầu file** (mới nhất trên cùng):
   ```
   ## Session [yyyy-mm-dd] — [tên buổi]
   **Thời lượng:** [ước lượng]
   ### Đã làm
   - [bullet]
   ### Lỗi gặp + cách fix
   - [bullet hoặc "Không có"]
   ### Anh feedback
   - [bullet hoặc "Không có"]
   ### Commits trong session
   - [hash — message]
   ### Next session
   - [bullet]
   ```
4. **Update [docs/BACKLOG.md](docs/BACKLOG.md):**
   - Đánh dấu task đã xong → chuyển xuống "ĐÃ HOÀN THÀNH"
   - Thêm task mới phát sinh trong buổi
5. **Update [docs/DECISION_LOG.md](docs/DECISION_LOG.md)** nếu có quyết định lớn
6. **Commit toàn bộ thay đổi** với message format:
   ```
   <type>: <mô tả ngắn buổi này>

   - [bullet 1-3 thay đổi chính]

   Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
   ```
   `<type>` = `feat` | `fix` | `refactor` | `docs` | `chore`

7. **Báo cáo tổng kết:**
```
✅ ĐÃ KẾT THÚC BUỔI [ngày]

📊 TỔNG KẾT
- Đã làm: [X tính năng / Y dòng code / Z file]
- Commits: [danh sách hash + message]

📍 STATE
- Tính năng vừa lên ✅: [list]
- Tính năng vừa lên 🟡: [list]

🎯 BUỔI SAU
- Đề xuất bắt đầu: [task từ BACKLOG P0]
```

Hỏi anh: "Có cần làm gì khác trước khi nghỉ không anh?"
