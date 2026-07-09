---
title: "Amazon Cognito"
date: 2024-01-01
weight: 4
chapter: false
pre: " <b> 5.4. </b> "
---

Amazon Cognito đóng vai trò xác thực người dùng (đăng ký, đăng nhập) cho SmartCV, phát hành JWT token để Frontend gọi API an toàn.

1. Trong AWS Management Console, gõ **Cognito** trong ô tìm kiếm và nhấn Enter.
2. Nhấn **Create user pool**. Ở mục **Option for sign-in identifiers**, click chọn **Email**.
3. Các mục còn lại để mặc định, đặt tên user pool là `smartcv-users`.

![Tạo User Pool](/images/5-Workshop/5.4-Cognito/5.50.png)
**Hình 5.4.1** — Tạo User Pool `smartcv-users` với sign-in bằng Email.

#### Lấy thông tin cấu hình cho Frontend

Sau khi tạo xong, cần lấy các thông số để cấu hình React Frontend sau này:

1. Click vào User pool `smartcv-users` vừa tạo.
2. Tại trang tổng quan, sao chép **User pool ID** (ví dụ: `ap-southeast-1_xxxxxxxxx`) và lưu ra file nháp.
3. Chuyển sang tab **App integration**.
4. Cuộn xuống phần **App client list**, sao chép **Client ID** của `smartcv-frontend` và lưu ra nháp.

![Lấy thông tin User Pool ID và Client ID](/images/5-Workshop/5.4-Cognito/5.51.png)
**Hình 5.4.2** — Sao chép User pool ID và Client ID để cấu hình Frontend.
