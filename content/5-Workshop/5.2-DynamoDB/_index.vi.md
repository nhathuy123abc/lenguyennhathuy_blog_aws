---
title: "Amazon DynamoDB"
date: 2024-01-01
weight: 2
chapter: false
pre: " <b> 5.2. </b> "
---

DynamoDB dùng mô hình **Single-Table Design** để lưu toàn bộ dữ liệu của SmartCV (Applications, Notes, Settings, Status Events) trong một bảng duy nhất, tối ưu chi phí và hiệu năng truy vấn.

1. Trong AWS Management Console, gõ **DynamoDB** trong ô tìm kiếm và nhấn Enter.
2. Nhấn vào **Tables** ở sidebar bên trái, chọn **Create table**.
3. Tạo bảng tên `smartcv`.

![Tạo bảng DynamoDB](/images/5-Workshop/5.2-DynamoDB/5.3.jpg)
**Hình 5.2.1** — Tạo bảng `smartcv` trong DynamoDB.

4. Thiết lập khóa chính (Primary key):
   - **Partition key:** `PK` (String)
   - **Sort key:** `SK` (String)
5. Tạo Global Secondary Index (GSI) để tối ưu truy vấn theo chiều phụ:
   - Vào **Indexes** → **Create index**
   - **Partition key:** `GSI1PK` (String)
   - **Sort key:** `GSI1SK` (String)
   - **Index name:** `GSI1`

![Tạo GSI1](/images/5-Workshop/5.2-DynamoDB/5.4.jpg)
**Hình 5.2.2** — Tạo Global Secondary Index GSI1 (GSI1PK/GSI1SK).

6. Cuộn xuống phần **Time To Live (TTL)**, bật TTL và đặt tên thuộc tính TTL là `expiresAt` để tự động xóa dữ liệu hết hạn (ví dụ: session tạm, cache phân tích AI).

![Bật TTL](/images/5-Workshop/5.2-DynamoDB/5.5.jpg)
**Hình 5.2.3** — Bật Time To Live (TTL) với thuộc tính `expiresAt`.

7. Nhấn **Create table** để hoàn tất.

Bảng DynamoDB `smartcv` với khóa `PK`/`SK` và index `GSI1` (`GSI1PK`/`GSI1SK`) đã sẵn sàng phục vụ backend.
