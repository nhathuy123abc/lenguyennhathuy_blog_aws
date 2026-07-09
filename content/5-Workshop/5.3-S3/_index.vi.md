---
title: "Amazon S3"
date: 2024-01-01
weight: 3
chapter: false
pre: " <b> 5.3. </b> "
---

S3 bucket sẽ được dùng để lưu trữ file PDF Resume của dự án. Để bảo mật, bucket này sẽ hoàn toàn **private**, nhưng Frontend có thể upload file trực tiếp thông qua **Presigned URLs**.

1. Truy cập dịch vụ **Amazon S3** trên AWS Console, chọn Region **`ap-southeast-1`** (giống Region đã dùng cho DynamoDB).
2. Click **Create bucket**.
3. **General configuration:**
   - **Bucket name:** Nhập `smartcv-resumes-YOUR_NAME` (tên bucket phải duy nhất toàn cầu, thay `YOUR_NAME` bằng tên của bạn).
   - **AWS Region:** `ap-southeast-1`.
4. **Block Public Access settings:** đảm bảo **Block all public access** đang **Bật (Checked)** — không mở public bucket này.
5. Click **Create bucket**.
6. Sau khi tạo xong, click vào tên bucket, chuyển sang tab **Permissions**.
7. Cuộn xuống phần **Cross-origin resource sharing (CORS)**, click **Edit** và dán đoạn JSON sau:

```json
[
  {
    "AllowedHeaders": ["*"],
    "AllowedMethods": ["GET", "PUT"],
    "AllowedOrigins": ["*"],
    "ExposeHeaders": []
  }
]
```

![Tạo Bucket](/images/5-Workshop/5.3-S3/5.45.png)
**Hình 5.3.1** — Tạo S3 bucket `smartcv-resumes-YOUR_NAME` với Block Public Access đang bật.

![Cấu hình CORS](/images/5-Workshop/5.3-S3/5.49.png)
**Hình 5.3.2** — Cấu hình CORS cho phép Frontend upload qua Presigned URL.

Bucket `smartcv-resumes-YOUR_NAME` đã sẵn sàng để Lambda tạo Presigned URL và tích hợp upload từ Frontend.
