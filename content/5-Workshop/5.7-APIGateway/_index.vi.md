---
title: "Amazon API Gateway"
date: 2024-01-01
weight: 7
chapter: false
pre: " <b> 5.7. </b> "
---

API Gateway là cổng giao tiếp giữa Frontend React và Backend Lambda. Frontend gọi API qua Gateway, Gateway chuyển request đến đúng Lambda để xử lý.

Tạo thủ công từng Resource và Method trên Console sẽ mất nhiều thời gian, dự án đã chuẩn bị sẵn file OpenAPI để import hàng loạt.

#### Import API từ file OpenAPI

1. Mở file `api/openapi.yml` trong mã nguồn SmartCV bằng trình soạn thảo (VSCode, Notepad...).
2. Truy cập dịch vụ **API Gateway** trên AWS Console.
3. Tìm phần **REST API**, chọn **Import**.
4. Dán toàn bộ nội dung file `openapi.yml` vào khung soạn thảo.
5. Ở mục **Endpoint Type**, chọn *Regional*.
6. Bấm **Import**.

![Import OpenAPI](/images/5-Workshop/5.7-APIGateway/image40.png)
![Import OpenAPI](/images/5-Workshop/5.7-APIGateway/image41.png)
**Hình 5.7.1** — Import file `openapi.yml` để tạo REST API.

API Gateway sẽ tự động tạo API tên `SmartCV API` với đầy đủ resources và methods.

![API đã tạo](/images/5-Workshop/5.7-APIGateway/image42.png)
**Hình 5.7.2** — API `SmartCV API` được tạo tự động với đầy đủ resources/methods.

#### Cấu hình Cognito Authorizer

1. Menu bên trái của `SmartCV API`, chọn **Authorizers**.
2. Sẽ thấy Authorizer tên `cognitoAuth` đã được tạo sẵn. Click vào, chọn **Edit**.
3. **Cognito User Pool:** chọn `smartcv-users` (User pool tạo ở mục 5.4).
4. Click **Save**.

![Cấu hình Authorizer](/images/5-Workshop/5.7-APIGateway/image43.png)
**Hình 5.7.3** — Gắn Cognito Authorizer `cognitoAuth` với User pool `smartcv-users`.

#### Bật CORS cho API Gateway

{{% notice warning %}}
Nếu Frontend (Amplify) và API Gateway ở domain khác nhau (luôn đúng với kiến trúc này), **thiếu CORS sẽ khiến mọi request từ browser bị chặn** với lỗi `blocked by CORS policy`, dù Lambda và IAM đều đúng.
{{% /notice %}}

1. Ở menu **Resources**, chọn resource gốc (ví dụ `/applications`).
2. Chọn **Actions** (hoặc nút **Enable CORS** nếu có sẵn trên UI mới).
3. **Access-Control-Allow-Origin:** nhập `*` (hoặc domain Amplify thật khi lên production).
4. **Access-Control-Allow-Headers:** giữ mặc định (`Content-Type,Authorization,X-Amz-Date,...`).
5. **Access-Control-Allow-Methods:** tích chọn các method đang dùng (GET, POST, PUT, DELETE, OPTIONS).
6. Click **Save**, sau đó lặp lại cho **tất cả** các resource khác: `/insights`, `/settings`, `/notes`, `/resumes`.

![Bật CORS](/images/5-Workshop/5.7-APIGateway/image44.png)
**Hình 5.7.4** — Bật CORS cho từng resource (applications, insights, settings, notes, resumes).

#### Tích hợp các Method với Lambda (Lambda Proxy Integration)

Thực hiện cho **từng Method** (GET, POST, PUT, DELETE) của mỗi Resource:

1. Menu **Resources**, click vào một Method (ví dụ `GET` của `/applications`).
2. Click **Edit integration** (hoặc *Integration Request* → *Edit*).
3. **Integration type:** *Lambda function*.
4. **Use Lambda Proxy integration:** bắt buộc **Bật (Checked)**.
5. **Lambda function:** gõ tên hàm tương ứng (ví dụ `/applications` → `smartcv-applications`).
6. Click **Save** và chấp nhận cấp quyền (Grant permission).

Lặp lại cho tất cả Resource: `/insights` → `smartcv-insights`, `/settings` → `smartcv-settings`, `/notes` → `smartcv-notes`, `/resumes` → `smartcv-applications`.

![Tích hợp Lambda Proxy](/images/5-Workshop/5.7-APIGateway/image45.png)
**Hình 5.7.5** — Tích hợp Method với Lambda function tương ứng (Lambda Proxy Integration).

#### Triển khai API (Deploy API)

1. Click **Deploy API** (góc phải trên cùng).
2. **Deployment stage:** chọn *[New Stage]*.
3. **Stage name:** nhập `v1` (**quan trọng**, phải khớp với khai báo `/v1` trong file OpenAPI).
4. Click **Deploy**.
5. Sau khi deploy thành công, bạn sẽ thấy **Invoke URL** (ví dụ: `https://xxxxxx.execute-api.ap-southeast-1.amazonaws.com/v1`). Copy URL này — đây là Backend URL dành cho Frontend.

![Deploy thành công, nhận Invoke URL](/images/5-Workshop/5.7-APIGateway/image46.png)
**Hình 5.7.6** — Deploy API lên stage `v1`, nhận Invoke URL cho Frontend.
