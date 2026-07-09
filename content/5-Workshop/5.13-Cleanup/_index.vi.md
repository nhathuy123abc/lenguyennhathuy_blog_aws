---
title: "Dọn dẹp tài nguyên"
date: 2024-01-01
weight: 13
chapter: false
pre: " <b> 5.13. </b> "
---

Sau khi hoàn thành Workshop, hãy xóa toàn bộ tài nguyên AWS đã tạo để tránh phát sinh chi phí ngoài ý muốn.

#### 5.13.1. Làm rỗng và xóa S3 Bucket

1. Truy cập **Amazon S3**.
2. Chọn bucket `smartcv-resumes-YOUR_NAME`.
3. Nhấn **Empty** và xác nhận xóa toàn bộ object.
4. Quay lại danh sách Bucket, chọn bucket và nhấn **Delete**.
5. Nhập tên bucket để xác nhận.

![S3](/images/5-Workshop/5.13-Cleanup/S3.jpg)

#### 5.13.2. Xóa AWS Amplify App

1. Truy cập **AWS Amplify**.
2. Chọn ứng dụng `smartcv-frontend`.
3. Chọn **Actions** → **Delete app**.
4. Nhập `delete` để xác nhận, nhấn **Delete**.

![Amplify](/images/5-Workshop/5.13-Cleanup/Amplify.jpg)

#### 5.13.3. Xóa Amazon Cognito User Pool

1. Truy cập **Amazon Cognito**.
2. Chọn User Pool `smartcv-users`.
3. Chọn **Delete**, nhập tên User Pool để xác nhận.

![Cognito](/images/5-Workshop/5.13-Cleanup/Cognito.jpg)

#### 5.13.4. Xóa DynamoDB Table

1. Truy cập **Amazon DynamoDB** → **Tables**.
2. Chọn bảng `smartcv`, nhấn **Delete**.
3. Nhập `delete` để xác nhận.

![DynamoDB](/images/5-Workshop/5.13-Cleanup/DatabaseClear.jpg)

#### 5.13.5. Xóa Lambda Functions

1. Truy cập **AWS Lambda**.
2. Chọn từng function: `smartcv-applications`, `smartcv-insights`, `smartcv-settings`, `smartcv-notes`, `smartcv-digest`, `smartcv-followup`, `smartcv-cognito-verify`.
3. Chọn **Actions** → **Delete** cho từng hàm.
![Lambda](/images/5-Workshop/5.13-Cleanup/LambdaClear.jpg)

#### 5.13.6. Xóa API Gateway

1. Truy cập **API Gateway**.
2. Chọn API `SmartCV API`.
3. Chọn **Delete**, xác nhận xóa.

![API Gateway](/images/5-Workshop/5.13-Cleanup/APIClear.jpg)

#### 5.13.7. Xóa IAM Role

1. Truy cập **IAM** → **Roles**.
2. Tìm `SmartCV-Lambda-Role`.
3. Nhấn **Delete**.

![IAM Role](/images/5-Workshop/5.13-Cleanup/IAMClean.jpg)

#### 5.13.8. Xóa Amazon SES Identity (tuỳ chọn)

Nếu không còn dùng email đã verify cho mục đích khác:
1. Truy cập **Amazon SES** → **Identities**.
2. Chọn email đã verify, nhấn **Delete**.
![SES](/images/5-Workshop/5.13-Cleanup/SESClear.jpg)
{{% notice note %}}
Bước Enable Model Access cho **Amazon Bedrock** (mục 5.10) **không** phát sinh chi phí khi không sử dụng, nên không cần "xóa" — bạn có thể để nguyên hoặc tắt quyền truy cập model trong **Model access** nếu muốn.
{{% /notice %}}

Chúc mừng bạn đã hoàn thành Workshop triển khai SmartCV trên AWS Serverless Architecture!
