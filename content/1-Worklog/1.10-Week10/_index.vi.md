---
title: "Worklog Tuần 10"
date: 2026-07-07
weight: 10
chapter: false
pre: " <b> 1.10. </b> "
---


### Mục tiêu tuần 10:

* Lập trình màn hình Dashboard tổng quan.
* Phát triển tính năng Kanban Board: Tích hợp thư viện @hello-pangea/dnd để thực hiện kéo thả các thẻ trạng thái công việc (Job).
* Tích hợp luồng xác thực (Authentication) qua thư viện aws-amplify & @aws-amplify/ui-react, xử lý trạng thái đăng nhập và cấu hình chế độ tối (Dark Mode).

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --------- | ------------ | --------------- | -------------- |
| 1 | - Thiết kế và lập trình giao diện cũng như các widget cho màn hình Dashboard tổng quan. | 22/06/2026 | 22/06/2026 | Tài liệu giao diện React |
| 2 | - Tìm hiểu và tích hợp thư viện @hello-pangea/dnd để hỗ trợ tính năng kéo thả. | 23/06/2026 | 23/06/2026 | Tài liệu hello-pangea/dnd |
| 3 | - Phát triển giao diện Kanban Board và xử lý việc thay đổi trạng thái thẻ Job giữa các cột. | 24/06/2026 | 24/06/2026 | Yêu cầu Kanban của dự án |
| 4 | - Tích hợp thư viện aws-amplify và @aws-amplify/ui-react cho luồng xác thực Cognito. | 25/06/2026 | 25/06/2026 | Hướng dẫn phát triển AWS Amplify |
| 5 | - Xử lý lưu trữ trạng thái đăng nhập của người dùng và thiết lập nút chuyển đổi chế độ tối (Dark Mode) toàn cục. | 26/06/2026 | 26/06/2026 | Hướng dẫn cấu hình giao diện tối |

### Kết quả đạt được tuần 10:

* Hoàn thành giao diện lập trình màn hình Dashboard tổng quan hiển thị các số liệu thống kê quan trọng.

* Phát triển thành công tính năng Kanban Board tương tác kéo thả mượt mà cho các thẻ Job bằng thư viện @hello-pangea/dnd.

* Cấu hình thành công luồng xác thực AWS Amplify Auth (aws-amplify và @aws-amplify/ui-react) để bảo vệ ứng dụng.

* Quản lý tốt trạng thái đăng nhập/đăng xuất của người dùng trên toàn hệ thống.

* Tích hợp thành công tính năng giao diện tối (Dark Mode) và cơ chế chuyển đổi giao diện linh hoạt.

### Kế hoạch tuần tiếp theo:

* Dựng biểu đồ thống kê Analytics bằng thư viện recharts.

* Hoàn thiện giao diện AI Chat UI (hiển thị markdown, streaming text).

* Phát triển Resume Manager (quản lý CV) và tính năng Import/Export file CSV (lib/csv.ts), tối ưu hóa UI cho Mobile/Tablet (Responsive).
