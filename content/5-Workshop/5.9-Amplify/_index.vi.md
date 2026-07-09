---
title: "AWS Amplify"
date: 2024-01-01
weight: 9
chapter: false
pre: " <b> 5.9. </b> "
---

AWS Amplify dùng để build và deploy Frontend React của SmartCV lên Internet, kết nối với Backend đã tạo ở các mục trước (API Gateway, Cognito).

#### Bước 1: Khởi tạo Amplify App

1. Truy cập dịch vụ **AWS Amplify** trên AWS Console.
2. Chọn **New app** → **Host web app**, kết nối tới repository chứa mã nguồn Frontend (GitHub/GitLab/Bitbucket) và chọn đúng branch cần deploy.
3. Đặt tên app là `smartcv-frontend`.

![Khởi tạo tên Amplify App](/images/5-Workshop/5.9-Amplify/5.9.1.png)
**Hình 5.9.1** — Khởi tạo Amplify App với tên `smartcv-frontend`.

4. Xác nhận cấu hình build mặc định Amplify tự nhận diện (framework React/Vite), bổ sung các biến môi trường cần thiết cho Frontend (URL API Gateway, User Pool ID, Client ID... lấy từ các mục trước) nếu dự án yêu cầu.
5. Nhấn **Save and deploy** để Amplify tự động build và deploy.

#### Bước 2: Kiểm tra trạng thái Deploy

1. Sau khi build xong (thường mất vài phút), vào lại trang tổng quan của app `smartcv-frontend`.
2. Kiểm tra trạng thái deploy của branch đã chọn — nếu hiển thị **Deployed** với dấu tích màu xanh, nghĩa là Frontend đã lên thành công.

![Kiểm tra deploy thành công trên Amplify](/images/5-Workshop/5.9-Amplify/5.9.2.png)
**Hình 5.9.2** — Trạng thái Deployed (tích xanh) trên Amplify Console.

3. Click vào domain mặc định của Amplify (dạng `https://main.xxxxxxxxxx.amplifyapp.com`) để mở thử Frontend SmartCV trên trình duyệt.

{{% notice note %}}
Nếu muốn gắn domain riêng thay cho domain mặc định của Amplify, xem tiếp mục [5.10 Amazon Route 53](../5.10-route53/).
{{% /notice %}}
