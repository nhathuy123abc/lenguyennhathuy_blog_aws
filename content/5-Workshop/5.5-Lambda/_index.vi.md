---
title: "AWS Lambda"
date: 2024-01-01
weight: 5
chapter: false
pre: " <b> 5.5. </b> "
---


Trước khi làm phần này, đảm bảo bạn đã hoàn thành bước **Enable Model Access** cho Amazon Bedrock ở mục [5.10](../5.10-bedrock/). Nếu chưa, các hàm Lambda gọi Bedrock (`insights`, `digest`) sẽ bị lỗi `AccessDeniedException` khi test.


#### Tạo IAM Execution Role cho Lambda

1. Truy cập dịch vụ **IAM** trên AWS Console.
2. Menu bên trái, chọn **Roles**, click **Create role**.
3. **Trusted entity type:** chọn *AWS service*. **Use case:** chọn *Lambda*. Click **Next**.
4. Tìm và tích chọn các Policy sau:
   - `AWSLambdaBasicExecutionRole` (ghi log vào CloudWatch)
   - `AmazonDynamoDBFullAccess` (đọc/ghi bảng SmartCV)
   - `AmazonS3FullAccess` (tạo Presigned URL)
   - `AmazonBedrockFullAccess` (gọi AI model)
   - `AmazonSESFullAccess` (gửi email)
5. Đặt tên Role là `SmartCV-Lambda-Role` và click **Create role**.

![Tạo IAM Role](/images/5-Workshop/5.5-Lambda/5.10.jpg)
![Tạo IAM Role](/images/5-Workshop/5.5-Lambda/5.30.png)
![Tạo IAM Role](/images/5-Workshop/5.5-Lambda/5.31.png)
![Tạo IAM Role](/images/5-Workshop/5.5-Lambda/5.32.png)
![Tạo IAM Role](/images/5-Workshop/5.5-Lambda/5.34.png)
![Tạo IAM Role](/images/5-Workshop/5.5-Lambda/5.35.png)
**Hình 5.5.1** — Tạo IAM Role `SmartCV-Lambda-Role` với 5 policy cần thiết.
#### Tạo Lambda Layer chứa thư viện dùng chung

Mở terminal tại thư mục gốc dự án SmartCV, chạy lệnh:

```bash
bash scripts/build_layer.sh
```

Lệnh này tạo ra file `shared_layer.zip`.

1. Truy cập dịch vụ **Lambda**, chọn **Layers** ở menu trái, click **Create layer**.
2. **Name:** `smartcv-dependencies`.
3. **Upload a .zip file:** upload `shared_layer.zip` vừa tạo.
4. **Compatible runtimes:** *Python 3.12*.
5. **Compatible architectures:** *arm64* và *x86_64*.
6. Click **Create** và ghi lại **Version ARN** của layer.

![Tạo Lambda Layer](/images/5-Workshop/5.5-Lambda/5.11.png)
![Tạo Lambda Layer](/images/5-Workshop/5.5-Lambda/5.12.png)
**Hình 5.5.2** — Tạo Layer `smartcv-dependencies` từ file `shared_layer.zip`.

#### Danh sách 7 hàm Lambda cần tạo

Hệ thống SmartCV gồm **7 hàm Lambda**, mỗi hàm xử lý một nghiệp vụ riêng:

1. `smartcv-applications`: thêm/sửa/xóa hồ sơ, lấy link upload CV.
2. `smartcv-insights`: phân tích thống kê và AI Chat với Bedrock.
3. `smartcv-settings`: cài đặt mục tiêu (Goal) và theo dõi Streak.
4. `smartcv-notes`: ghi chú Timeline.
5. `smartcv-digest`: gửi email báo cáo thống kê hàng tuần.
6. `smartcv-followup`: gửi email nhắc nhở follow-up ứng tuyển.
7. `smartcv-cognito-verify`: tự động xác minh email khi có user đăng ký mới.

#### Tạo từng hàm

Với **mỗi hàm** trong danh sách trên, lặp lại các bước sau:

1. Ở sidebar Lambda, chọn **Functions** → **Create function**.
2. Chọn *Author from scratch*.
3. **Function name:** nhập tên hàm (ví dụ `smartcv-applications`).
4. **Runtime:** *Python 3.12*.
5. **Architecture:** *arm64* (khuyên dùng) hoặc *x86_64*.
6. **Execution role:** chọn *Use an existing role* → `SmartCV-Lambda-Role`.
7. Click **Create function**.

Ngay sau khi tạo mỗi hàm, thiết lập tiếp các mục sau **ngay trên giao diện của hàm đó**:

**a. Gắn Layer vào Function**

Kéo xuống phần **Layers** → **Add a layer** → *Specify an ARN* → dán ARN của layer `smartcv-dependencies` → **Add**.

![Tạo Lambda Layer](/images/5-Workshop/5.5-Lambda/5.13.png)
![Tạo Lambda Layer](/images/5-Workshop/5.5-Lambda/5.14.png)
![Tạo Lambda Layer](/images/5-Workshop/5.5-Lambda/5.15.png)
![Tạo Lambda Layer](/images/5-Workshop/5.5-Lambda/5.16.png)
![Tạo Lambda Layer](/images/5-Workshop/5.5-Lambda/5.17.png)
![Tạo Lambda Layer](/images/5-Workshop/5.5-Lambda/5.18.png)
![Tạo Lambda Layer](/images/5-Workshop/5.5-Lambda/5.19.png)
**Hình 5.5.3** — Gắn Layer `smartcv-dependencies` vào từng hàm Lambda.

**b. Cấu hình Timeout và Memory**

{{% notice warning %}}
Lambda mặc định có Timeout chỉ 3 giây — không đủ thời gian để gọi Amazon Bedrock (thường mất vài giây). Nếu không tăng Timeout, bạn sẽ gặp lỗi `Task timed out after 3.00 seconds`.
{{% /notice %}}

Vào tab **Configuration** → **General configuration** → **Edit**:
- **Memory:** 256 MB (khuyến nghị, có thể tăng nếu cần).
- **Timeout:** 30 giây (bắt buộc cho `insights` và `digest` vì có gọi Bedrock; các hàm khác có thể để 10–15 giây).

**c. Thiết lập biến môi trường**

Vào **Configuration** → **Environment variables** → **Edit** → **Add environment variable**. Thêm các biến sau cho **tất cả các hàm Lambda**:

| Key | Value |
| --- | --- |
| `TABLE_NAME` | `smartcv` |
| `CORS_ORIGIN` | `*` |
| `RESUME_BUCKET` | `smartcv-resumes-YOUR_NAME` (bucket tạo ở mục 5.3) |
| `USER_POOL_ID` | `ap-southeast-1_xxxxxxxxx` (User Pool ID tạo ở mục 5.4) |
| `POWERTOOLS_SERVICE_NAME` | `SmartCV` |

Riêng đối với **`smartcv-insights`** và **`smartcv-digest`** (2 hàm có gọi AI), thêm thêm biến:

| Key | Value |
| --- | --- |
| `BEDROCK_MODEL_ID` | `amazon.nova-lite-v1:0` |

Riêng đối với **`smartcv-digest`** và **`smartcv-followup`** (2 hàm gửi email), thêm thêm biến:

| Key | Value |
| --- | --- |
| `SES_FROM_EMAIL` | `email_cua_ban@domain.com` (email đã verify ở mục 5.6) |

Nhấn **Save**.

![Thiết lập biến môi trường](/images/5-Workshop/5.5-Lambda/5.20.png)
![Thiết lập biến môi trường](/images/5-Workshop/5.5-Lambda/5.21.png)
![Thiết lập biến môi trường](/images/5-Workshop/5.5-Lambda/5.22.png)
**Hình 5.5.4** — Thiết lập biến môi trường (TABLE_NAME, RESUME_BUCKET, USER_POOL_ID, BEDROCK_MODEL_ID, SES_FROM_EMAIL...).

#### Upload mã nguồn cho từng Lambda

Mã nguồn các hàm Lambda đã được viết sẵn trong thư mục `lambdas/` của dự án. Với **mỗi hàm**, thực hiện:

1. Mở mã nguồn SmartCV trên máy, vào thư mục `lambdas/<tên-hàm>/` (ví dụ `lambdas/applications/`).
2. Nén toàn bộ file **bên trong** thư mục đó thành file zip (ví dụ `applications.zip`) — lưu ý: chọn các file bên trong để nén, không nén cả thư mục cha.
3. Quay lại AWS Console, vào trang quản lý hàm Lambda tương ứng, chọn tab **Code**.
4. Click **Upload from** → **.zip file**, chọn file zip vừa tạo, click **Save**.

Lặp lại thao tác này cho tất cả 7 hàm: `applications`, `settings`, `insights`, `notes`, `digest`, `followup`, `cognito-verify`.

![Upload code cho từng hàm](/images/5-Workshop/5.5-Lambda/5.23.png)
![Upload code cho từng hàm](/images/5-Workshop/5.5-Lambda/5.24.png)
![Upload code cho từng hàm](/images/5-Workshop/5.5-Lambda/5.25.png)
![Upload code cho từng hàm](/images/5-Workshop/5.5-Lambda/5.26.png)
![Upload code cho từng hàm](/images/5-Workshop/5.5-Lambda/5.27.png)
![Upload code cho từng hàm](/images/5-Workshop/5.5-Lambda/5.28.png)  
![Upload code cho từng hàm](/images/5-Workshop/5.5-Lambda/5.29.png)
**Hình 5.5.5** — Upload file .zip mã nguồn cho từng hàm Lambda (7 hàm).
