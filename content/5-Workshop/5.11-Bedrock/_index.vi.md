---
title: "Amazon Bedrock"
date: 2024-01-01
weight: 11
chapter: false
pre: " <b> 5.11. </b> "
---

Amazon Bedrock là dịch vụ AI tạo sinh (Generative AI) được SmartCV dùng để phân tích nội dung CV/hồ sơ ứng tuyển và đưa ra gợi ý cải thiện, thông qua 2 hàm Lambda `insights` và `digest`. Model chính thức được nhóm chọn cho dự án là **Amazon Nova Lite**.

{{% notice note %}}
**Cập nhật quan trọng:** Giao diện Bedrock hiện tại **đã tự động kích hoạt (auto-enable)** các serverless foundation model — bạn **không cần** thực hiện thao tác "Request model access" thủ công như các phiên bản Console cũ trước đây.
{{% /notice %}}

#### Bước 1: Kiểm tra Model Access

1. Mở AWS Console, gõ **Bedrock** vào ô tìm kiếm và truy cập.
2. Ở sidebar bên trái, trong mục **Configure and learn**, chọn **Model access**.

**Hình AI-01.** Trang Model access mới của Amazon Bedrock cho biết các serverless foundation model đã được tự động kích hoạt, không cần request access thủ công như trước.

![Trang Model access](/images/5-Workshop/5.11-Bedrock/image5.png)
**Hình 5.11.1** — Trang Model access hiển thị các model đã tự động sẵn sàng sử dụng.

#### Bước 2: Chọn model trong Model Catalog

1. Vẫn ở sidebar, chọn **Model catalog**.
2. Gõ **Nova Lite** vào ô tìm kiếm và chọn model **Amazon Nova Lite** — đây là model AI chính thức được dùng cho dự án SmartCV.

**Hình AI-02.** Model Amazon Nova Lite trong Bedrock Model catalog, dùng làm model AI chính cho chức năng SmartCV Insights.

![Chọn Amazon Nova Lite trong Model catalog](/images/5-Workshop/5.11-Bedrock/image6.png)
**Hình 5.11.2** — Amazon Nova Lite trong Model catalog.

#### Bước 3: Thử nghiệm model trên Playground

1. Tại trang model Nova Lite, chọn **Open in playground** (hoặc vào mục **Playgrounds** ở sidebar).

![Mở Nova Lite trong Playground](/images/5-Workshop/5.11-Bedrock/image6.png)
**Hình 5.11.3** — Mở Amazon Nova Lite trong Playground để thử nghiệm.

2. Nếu được yêu cầu, cấp quyền (**Grant permission**) để tài khoản của bạn được sử dụng Playground.

![Cấp quyền sử dụng Playground](/images/5-Workshop/5.11-Bedrock/5.11.1.png)
**Hình 5.11.4** — Cấp quyền truy cập Playground.

3. Thử nhập một đoạn CV mẫu và một prompt phân tích để kiểm tra chất lượng phản hồi của model trước khi tích hợp vào code.

#### Bước 4: Tạo API Key để kết nối Bedrock với dự án

1. Trong Bedrock Console, tạo **Short-term API keys** để dùng cho việc gọi Bedrock từ code Lambda.

![Tạo Short-term API Key](/images/5-Workshop/5.11-Bedrock/image8.png)
**Hình 5.11.5** — Tạo Short-term API Key trong Bedrock Console.

2. Copy API Key vừa tạo — key này sẽ được dùng ở bước tiếp theo.

#### Bước 5: Gắn API Key vào code dự án

1. Mở mã nguồn SmartCV, vào thư mục `insights` và `digest` (2 Lambda có gọi Bedrock).
2. Trong file `handler.py` của **mỗi thư mục**, tìm đến đoạn khai báo client Bedrock.
3. Dán API Key vừa copy vào đúng vị trí khai báo client (theo hướng dẫn cụ thể trong comment của code).

{{% notice warning %}}
**Không commit API Key trực tiếp vào source code** khi đưa lên Git công khai. Cách an toàn hơn là lưu API Key vào biến môi trường của Lambda (mục [5.5](../5.5-lambda/) → Environment variables, ví dụ thêm biến `BEDROCK_API_KEY`) và đọc từ `os.environ` trong `handler.py`, thay vì hard-code trực tiếp trong file.
{{% /notice %}}

4. Sau khi cập nhật code, nén lại và upload file `.zip` mới cho 2 hàm `smartcv-insights` và `smartcv-digest` theo hướng dẫn ở mục [5.5](../5.5-lambda/).
5. Test lại Lambda để xác nhận gọi Bedrock thành công, không còn lỗi xác thực.
