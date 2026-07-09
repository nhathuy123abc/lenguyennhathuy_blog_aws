---
title: "AWS CloudWatch"
date: 2024-01-01
weight: 12
chapter: false
pre: " <b> 5.12. </b> "
---

Amazon CloudWatch dùng để giám sát log và theo dõi luồng xử lý (tracing) của các hàm Lambda trong SmartCV. Mục này hướng dẫn cách chuẩn hóa log và bật tracing cho dự án.

#### Chuẩn hóa Log bằng AWS Lambda Powertools

Thay vì log dạng text tự do (khó lọc/tìm kiếm), SmartCV sử dụng thư viện **AWS Lambda Powertools** để chuẩn hóa log sang định dạng **JSON**, giúp việc lọc và tìm kiếm trên CloudWatch hiệu quả hơn nhiều.

1. Trong code Lambda, khai báo đối tượng **Logger** với tên service là `"SmartCV"` để phân loại và nhận diện log của dự án:

```python
from aws_lambda_powertools import Logger

logger = Logger(service="SmartCV")
```

2. Gắn decorator `@logger.inject_lambda_context` vào `lambda_handler` để tự động ghi log các thông tin ngữ cảnh như Request ID, thời gian và môi trường thực thi:

```python
@logger.inject_lambda_context
def lambda_handler(event, context):
    logger.info("Processing request", extra={"event": event})
    ...
```

![Ví dụ log JSON có cấu trúc trên CloudWatch](/images/5-Workshop/5.12-CloudWatch/image9.png)
**Hình 5.12.1** — Log JSON có cấu trúc hiển thị trên CloudWatch Logs Insights.

#### Cấu hình Log Retention và Tracing trong CDK

Trong file định nghĩa hạ tầng CDK cho Lambda, cấu hình thêm hai thuộc tính:

```typescript
const smartcvFunction = new lambda.Function(this, 'SmartCVFunction', {
  // ... các thuộc tính khác
  logRetention: logs.RetentionDays.ONE_MONTH, // 30 ngày, tối ưu chi phí lưu trữ
  tracing: lambda.Tracing.ACTIVE,             // Bật AWS X-Ray
});
```

- **`logRetention: 30 ngày`**: tự động xóa log cũ hơn 30 ngày, tránh phát sinh chi phí lưu trữ log không cần thiết theo thời gian.
- **`Tracing.ACTIVE`**: tích hợp **AWS X-Ray**, cho phép theo dõi chi tiết luồng đi của một request qua nhiều dịch vụ (API Gateway → Lambda → DynamoDB/Bedrock), hữu ích khi cần debug hiệu năng hoặc lỗi.

![Cấu hình logRetention và Tracing trong CDK](/images/5-Workshop/5.12-CloudWatch/image10.png)
**Hình 5.12.2** — Cấu hình `logRetention` và `tracing` trong CDK.

#### Xem Trace trên AWS X-Ray

1. Truy cập dịch vụ **CloudWatch** → **X-Ray traces** (hoặc mở trực tiếp dịch vụ **X-Ray**).
2. Chọn một trace cụ thể để xem chi tiết thời gian xử lý qua từng dịch vụ (Service Map).

![Service Map trên AWS X-Ray](/images/5-Workshop/5.12-CloudWatch/image11.png)
**Hình 5.12.3** — Service Map trên AWS X-Ray hiển thị luồng request qua API Gateway, Lambda và các dịch vụ downstream.

{{% notice note %}}
Log Group trên CloudWatch được tạo tự động theo tên `/aws/lambda/<tên-function>` và **không tự xóa** khi bạn xóa Lambda function. Khi dọn dẹp tài nguyên ở mục [5.13](../5.13-cleanup/), nhớ xóa thêm các Log Group này để tránh phát sinh chi phí lưu trữ log kéo dài.
{{% /notice %}}
