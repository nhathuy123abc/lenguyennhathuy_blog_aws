---
title: "Blog 3"
date: 2026-06-25
weight: 3
chapter: false
pre: " <b> 3.3. </b> "
---

# Xây dựng hệ thống xử lý tin nhắn dựa trên mức độ ưu tiên với Amazon MQ và AWS App Runner

Chào các anh chị và các bạn trong nhóm FCAJ.
Trong quá trình tìm hiểu về thiết kế kiến trúc hệ thống xử lý bất đồng bộ trên AWS, em có đọc được một tài liệu kiến trúc rất chi tiết và thiết thực. Em xin phép tổng hợp và phân tích lại các điểm kỹ thuật trọng tâm của kiến trúc này để mọi người cùng tham khảo và thảo luận.

### 1. Bài toán xử lý tin nhắn trong hệ thống quy mô lớn
Các tổ chức hiện nay luôn cần một hệ thống xử lý tin nhắn có khả năng ưu tiên các hoạt động kinh doanh quan trọng, trong khi vẫn phải xử lý hiệu quả các tác vụ thường nhật. Đặc biệt, khi hệ thống phải xử lý các tác vụ yêu cầu phản hồi nhanh chóng như đơn đặt hàng gấp từ khách hàng quan trọng hoặc các cảnh báo hệ thống quan trọng, việc ưu tiên các tin nhắn khẩn cấp là bắt buộc. Thách thức đặt ra là phải định tuyến tin nhắn dựa trên mức độ ưu tiên để tôn trọng các yêu cầu nghiệp vụ, đồng thời cung cấp phản hồi theo thời gian thực cho người dùng.

### 2. Tổng quan giải pháp kiến trúc
Để giải quyết bài toán này mà không làm tăng sự phức tạp trong khâu vận hành, AWS đề xuất một giải pháp sử dụng các dịch vụ được quản lý hoàn toàn. Kiến trúc này cho phép các nhóm tập trung vào logic nghiệp vụ thay vì quản lý cơ sở hạ tầng, bao gồm ba thành phần cốt lõi:
* **Amazon MQ:** Đóng vai trò là dịch vụ môi giới tin nhắn dành cho Apache ActiveMQ. Dịch vụ này cung cấp khả năng xếp hàng tin nhắn theo thứ tự ưu tiên, hỗ trợ giao thức JMS cho các ứng dụng doanh nghiệp và đảm bảo tính khả dụng cao thông qua tự động chuyển đổi dự phòng.
* **AWS App Runner:** Dịch vụ ứng dụng container được quản lý hoàn toàn, chịu trách nhiệm tính toán phi máy chủ. Nó cung cấp khả năng tự động mở rộng quy mô dựa trên lưu lượng truy cập và tự động xây dựng, triển khai các ứng dụng container.
* **Amazon DynamoDB:** Cơ sở dữ liệu NoSQL cung cấp hiệu năng chỉ trong vài mili giây dùng để lưu trữ dữ liệu trạng thái.

![Sơ đồ minh họa kiến trúc](/images/3-BlogsPosted/blog3-diagram1.png)

### 3. Cơ chế định tuyến và phân luồng độ trễ
Hệ thống triển khai định tuyến thông minh dựa trên ba cấp độ ưu tiên tin nhắn JMS để đảm bảo các tin nhắn quan trọng được xử lý ngay lập tức:
* **Đường dẫn ưu tiên cao:** Các tin nhắn thuộc nhóm này sẽ bỏ qua mọi khoảng độ trễ và được xếp vào hàng đợi ngay lập tức với mức ưu tiên JMS là 9.
* **Đường dẫn ưu tiên tiêu chuẩn:** Các thông báo sẽ phải trải qua một khoảng thời gian độ trễ đã được cấu hình trước khi được xếp vào hàng đợi với mức ưu tiên JMS là 4.
* **Đường dẫn ưu tiên thấp:** Các thông báo này chỉ được xử lý sau tất cả các thông báo có ưu tiên cao hơn, tương ứng với mức ưu tiên JMS là 0.

Kiến trúc này triển khai xử lý độ trễ có thể cấu hình ở cấp độ ứng dụng. Quá trình xử lý trễ bất đồng bộ quản lý nhóm luồng để xử lý đồng thời và xử lý lỗi khéo léo với cơ chế thử lại hai lớp nhằm đạt độ tin cậy tối đa.

![Luồng xử lý tin nhắn ưu tiên tiêu chuẩn](/images/3-BlogsPosted/blog3-diagram2.png)

*Luồng xử lý tin nhắn ưu tiên tiêu chuẩn xử lý các tin nhắn có độ trễ có thể cấu hình bằng cách sử dụng khả năng xử lý bất đồng bộ của JMS. Tin nhắn sẽ chờ trong khoảng thời gian trễ được chỉ định trước khi vào hàng đợi Amazon MQ, nơi chúng được xử lý.*

### 4. Khả năng phản hồi theo thời gian thực
Giải pháp cung cấp cập nhật trạng thái theo thời gian thực để người dùng có thể nắm rõ tình trạng yêu cầu của mình. Hệ thống sử dụng Amazon DynamoDB Streams để thu thập dữ liệu thay đổi (CDC) trong cơ sở dữ liệu. Từ đó, luồng dữ liệu kích hoạt AWS Lambda gửi các bản cập nhật đến giao diện người dùng React thông qua kết nối WebSocket của Amazon API Gateway.

### 5. Tiêu chuẩn bảo mật và xử lý sự cố
Tài liệu của AWS cũng nhấn mạnh việc áp dụng các biện pháp bảo mật toàn diện cho môi trường sản xuất:
* **Cách ly mạng:** Hệ thống cấu hình đám mây riêng ảo (VPC) với các mạng con riêng tư cho Amazon MQ, giúp cách ly máy chủ môi giới tin nhắn khỏi truy cập internet trực tiếp. Các nhóm bảo mật được cấu hình với quy tắc truy cập tối thiểu, ví dụ như chỉ cho phép cổng 61617 đối với các kết nối SSL ActiveMQ từ AWS App Runner.
* **Phân quyền và Mã hóa:** AWS khuyến nghị triển khai các chính sách IAM quyền hạn tối thiểu để đảm bảo App Runner chỉ truy cập vào các bảng DynamoDB và hàng đợi Amazon MQ cụ thể. Ngoài ra, dữ liệu phải được kích hoạt mã hóa khi lưu trữ bằng AWS Key Management Service (AWS KMS) và mã hóa khi truyền tải bằng kết nối SSL/TLS.

Trong quá trình vận hành, nếu xảy ra tình trạng các tin nhắn không được xử lý theo đúng thứ tự ưu tiên, kỹ sư hệ thống cần kiểm tra xem mức độ ưu tiên của JMS đã được cấu hình chính xác qua tham số `message.set` hay chưa. Đồng thời, cần xác nhận chế độ `CLIENT_ACKNOWLEDGE` đã được thiết lập đúng cách và kiểm tra cài đặt đồng thời của người tiêu dùng trong hàng đợi.

Việc áp dụng kiến trúc này kết hợp phương pháp cơ sở hạ tầng dưới dạng mã (IaC) hỗ trợ triển khai đồng nhất trên nhiều môi trường khác nhau, từ phát triển đến sản xuất.

### Tóm tắt
Giải pháp này minh họa cách xây dựng một hệ thống xử lý tin nhắn dựa trên mức độ ưu tiên sẵn sàng cho môi trường sản xuất bằng cách sử dụng các dịch vụ được quản lý của AWS. Bằng cách kết hợp hàng đợi ưu tiên Amazon MQ với luồng dữ liệu thời gian thực DynamoDB và điện toán phi máy chủ App Runner, tạo ra một kiến trúc mạnh mẽ có khả năng xử lý tin nhắn một cách thông minh dựa trên các ưu tiên kinh doanh. Việc triển khai độ trễ ở cấp độ ứng dụng với cơ chế bỏ qua ưu tiên đảm bảo các tin nhắn quan trọng nhận được sự chú ý ngay lập tức, và cơ chế thử lại hai lớp cung cấp độ tin cậy tối đa. Cập nhật WebSocket thời gian thực giúp người dùng nắm được trạng thái xử lý, tạo ra một hệ thống phản hồi nhanh và minh bạch.

**Nguồn tham khảo:**
* AWS Architecture Blog: [Build a priority-based messaging system with Amazon MQ and AWS App Runner](https://aws.amazon.com/blogs/architecture/build-priority-based-messaging-system-amazonmq-apprunner/)
* GitHub minh họa: [Amazon MQ Polling Mechanism Sample](https://github.com/aws-samples/sample-amazonmq-polling-mechanism)
* Facebook: [AWS Study Group FCJ](https://www.facebook.com/groups/awsstudygroupfcj/permalink/2194921531272807?locale=vi_VN)

*(Đây là 1 bài blog mình đọc được và thấy trên aws blog, đây là những gì mình đã tóm tắt sau khi mình đọc xong có gì sai sót mong mọi người bỏ qua .)*