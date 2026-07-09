---
title: "Giới thiệu Workshop"
date: 2024-01-01
weight: 1
chapter: false
pre: " <b> 5.1. </b> "
---

#### Bối cảnh

**Dự án nhóm đã thực hiện và deploy thành công tại:** [**https://smartcvknight.click/**](https://smartcvknight.click/)

Trong bối cảnh thị trường lao động ngày càng cạnh tranh, một ứng viên thường phải gửi hồ sơ đến nhiều doanh nghiệp cùng lúc để gia tăng cơ hội tìm được việc làm phù hợp. Tuy nhiên, việc quản lý quá trình ứng tuyển chủ yếu vẫn được thực hiện thủ công thông qua bảng tính hoặc ghi chú cá nhân, gây khó khăn trong việc theo dõi trạng thái hồ sơ, lịch phỏng vấn, thời gian gửi CV cũng như các mốc cần thực hiện như gửi email cảm ơn hoặc Follow-up sau phỏng vấn.

Bên cạnh đó, nhiều ứng viên chưa có đủ kinh nghiệm để đánh giá chất lượng hồ sơ xin việc của mình. Việc xác định điểm mạnh, điểm yếu của CV hoặc điều chỉnh nội dung theo từng vị trí tuyển dụng thường mất nhiều thời gian và phụ thuộc vào sự tư vấn của người có kinh nghiệm.

Xuất phát từ những nhu cầu trên, dự án **SmartCV** được xây dựng nhằm hỗ trợ người tìm việc quản lý toàn bộ quá trình ứng tuyển trên một nền tảng duy nhất, đồng thời tích hợp **Amazon Bedrock** để phân tích nội dung CV và đưa ra các gợi ý cải thiện dựa trên AI.

Để đáp ứng yêu cầu về khả năng mở rộng, tính sẵn sàng cao và tối ưu chi phí, hệ thống được triển khai theo mô hình **AWS Serverless Architecture**, tận dụng các dịch vụ mạnh mẽ từ hệ sinh thái AWS.

#### Kiến trúc tổng quan

Hệ thống SmartCV được xây dựng theo kiến trúc Serverless trên AWS, tích hợp các dịch vụ cốt lõi: Amplify Hosting và Route 53 cho Frontend, Cognito và API Gateway cho xác thực và quản lý API, EventBridge và Lambda cho xử lý logic, DynamoDB để lưu trữ dữ liệu, S3 để lưu trữ tệp tin, Bedrock cho các tác vụ AI, SES để gửi email, và CloudWatch để giám sát hệ thống.

![Kiến trúc tổng quan SmartCV](/images/5-Workshop/5.1-Introduction/5.1.jpg)
**Hình 5.1.1** — Kiến trúc tổng quan hệ thống SmartCV với đầy đủ các dịch vụ AWS Serverless: Amplify Hosting, Route 53, Cognito, API Gateway, EventBridge, Lambda, DynamoDB, S3, Bedrock (AI LLM), SES, và CloudWatch.

![Thông tin định danh tài khoản AWS và Region triển khai](/images/5-Workshop/5.1-Introduction/5.2.jpg)
**Hình 5.1.2** — Giao diện cấu hình tài khoản AWS (như 'HNTNhan') và Khu vực (Region) 'Asia Pacific (Singapore)' được lựa chọn làm vị trí trung tâm để triển khai toàn bộ các dịch vụ máy chủ của hệ thống trong workshop này.

{{% notice tip %}}
**Thống nhất Region ngay từ đầu:** Chọn Region **`Asia Pacific (Singapore)`** (hoặc `ap-southeast-1` như hiển thị trong console, xem Hình 5.1.2) ở góc phải trên cùng của AWS Console và giữ nguyên Region này cho **tất cả** dịch vụ trong Workshop (DynamoDB, S3, Cognito, Lambda, API Gateway, EventBridge, Bedrock). Việc lệch Region giữa các dịch vụ là nguyên nhân phổ biến nhất gây lỗi khi tích hợp.
{{% /notice %}}

#### Chuẩn bị môi trường

Trước khi bắt đầu, hãy chuẩn bị:
* Một tài khoản AWS còn hiệu lực, có quyền tạo tài nguyên (IAM, Lambda, DynamoDB, S3, Cognito, API Gateway, EventBridge, SES, Bedrock, Amplify).
* Đã cài **Node.js** (phiên bản 18+) trên máy để build mã nguồn Frontend và Lambda Layer.
* Đã tải mã nguồn dự án SmartCV về máy (thư mục gốc chứa `lambdas/`, `api/openapi.yml`, `scripts/build_layer.sh`, và Frontend React).
* **Quan trọng:** Hoàn thành bước "Enable Model Access" cho Amazon Bedrock ở mục [5.11](../5.11-bedrock/) **trước khi** cấu hình Lambda ở mục 5.5, để tránh lỗi quyền truy cập khi Lambda gọi Bedrock.