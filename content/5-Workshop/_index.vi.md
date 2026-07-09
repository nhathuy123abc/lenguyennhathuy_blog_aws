---
title: "Workshop"
date: 2024-01-01
weight: 5
chapter: false
pre: " <b> 5. </b> "
---

# Hệ thống theo dõi và tối ưu hóa hồ sơ xin việc ứng dụng trí tuệ nhân tạo (AI)

#### Tổng quan dự án

Chào mừng bạn đến với Workshop triển khai **SmartCV** – hệ thống theo dõi và tối ưu hóa quá trình ứng tuyển việc làm ứng dụng trí tuệ nhân tạo (AI), được xây dựng trên nền tảng **AWS Serverless Architecture**. Dự án hỗ trợ người dùng quản lý các hồ sơ ứng tuyển, theo dõi trạng thái tuyển dụng, lưu trữ Resume và Cover Letter, đồng thời sử dụng mô hình AI trên **Amazon Bedrock** để phân tích hồ sơ, đưa ra nhận xét và gợi ý cải thiện nhằm nâng cao cơ hội trúng tuyển.

Trong thực tế, hệ thống được triển khai bằng Infrastructure as Code (AWS CDK) để tự động hóa việc xây dựng hạ tầng. Tuy nhiên, trong Workshop này, toàn bộ các dịch vụ AWS sẽ được cấu hình theo phương pháp **Click-Ops** thông qua AWS Management Console, giúp người học hiểu rõ vai trò của từng dịch vụ và cách các thành phần trong kiến trúc Serverless kết nối với nhau.

{{% notice tip %}}
**Chọn Region ngay từ đầu:** Toàn bộ Workshop dùng cùng một Region — khuyến nghị **`ap-southeast-1` (Singapore)**. Trước khi bắt đầu, hãy chọn Region này ở góc phải trên cùng của AWS Console và giữ nguyên xuyên suốt cho mọi dịch vụ (DynamoDB, S3, Cognito, Lambda, API Gateway, EventBridge, Bedrock).

**Enable Bedrock Model Access trước:** Vì Lambda ở mục 5.5 sẽ gọi Amazon Bedrock, bạn nên hoàn thành bước "Enable Model Access" ở mục **5.10** *trước khi* làm mục 5.5, để tránh lỗi `AccessDeniedException` khi test Lambda.
{{% /notice %}}

Sau khi hoàn thành Workshop, người thực hiện sẽ đạt được:
* Hiểu được kiến trúc Cloud-Native và Serverless trên nền tảng AWS.
* Nắm được quy trình triển khai Amazon DynamoDB, Amazon S3, Amazon Cognito, AWS Lambda, Amazon API Gateway, Amazon EventBridge, Amazon SES, Amazon Bedrock và AWS Amplify.
* Xây dựng thành công hệ thống SmartCV: quản lý hồ sơ ứng tuyển, tải lên Resume, xác thực người dùng, gửi email nhắc nhở, theo dõi tiến độ ứng tuyển và phân tích hồ sơ bằng AI.
* Hiểu cách tích hợp React Frontend với Backend Serverless trên AWS.

#### Nội dung

1. [Giới thiệu Workshop](5.1-Introduction/)
2. [Amazon DynamoDB](5.2-DynamoDB/)
3. [Amazon S3](5.3-S3/)
4. [Amazon Cognito](5.4-Cognito/)
5. [AWS Lambda](5.5-Lambda/)
6. [Amazon SES](5.6-SES/)
7. [Amazon API Gateway](5.7-APIGateway/)
8. [Amazon EventBridge](5.8-EventBridge/)
9. [AWS Amplify](5.9-Amplify/)
10. [Amazon Route 53](5.10-Route53/)
11. [Amazon Bedrock](5.11-Bedrock/)
12. [AWS CloudWatch](5.12-CloudWatch/)
13. [Dọn dẹp tài nguyên](5.13-Cleanup/)
