---
title: "Worklog Tuần 3"
date: 2026-07-07
weight: 3
chapter: false
pre: " <b> 1.3. </b> "
---


### Mục tiêu tuần 3:

* Tìm hiểu kiến trúc Hybrid DNS trên AWS.
* Hiểu cách tích hợp hệ thống DNS giữa môi trường On-premises và AWS bằng Amazon Route 53 Resolver.
* Thực hành triển khai hạ tầng bằng AWS CloudFormation.
* Hoàn thành Lab 10 và kiểm tra hoạt động của hệ thống Hybrid DNS.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --------- | ------------ | --------------- | -------------- |
| 1 | Tìm hiểu kiến trúc Hybrid DNS và Amazon Route 53 Resolver, bao gồm Inbound Endpoint, Outbound Endpoint và Resolver Rules. | 04/05/2026 | 04/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 2 | Triển khai hạ tầng mạng bằng AWS CloudFormation để phục vụ Lab 10. | 05/05/2026 | 05/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 3 | Tạo Key Pair, cấu hình Security Group và kết nối đến máy chủ EC2 Windows thông qua Remote Desktop (RDP). | 06/05/2026 | 06/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 4 | Cấu hình Route 53 Resolver gồm Outbound Endpoint, Inbound Endpoint và Resolver Rules để xây dựng hệ thống Hybrid DNS. | 07/05/2026 | 08/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 5 | Kiểm tra hoạt động của hệ thống bằng các lệnh **nslookup**, **ping** và dọn dẹp toàn bộ tài nguyên AWS sau khi hoàn thành Lab 10. | 09/05/2026 | 10/05/2026 | https://cloudjourney.awsstudygroup.com/ |

### Kết quả đạt được tuần 3:

* Hiểu được kiến trúc Hybrid DNS và vai trò của **Amazon Route 53 Resolver** trong việc kết nối hệ thống DNS giữa môi trường On-premises và AWS.

* Tạo thành công Key Pair và kết nối Remote Desktop đến máy chủ EC2 Windows.

* Triển khai hạ tầng AWS bằng **AWS CloudFormation**, bao gồm:

  * Amazon VPC.
  * Subnet.
  * Internet Gateway.
  * NAT Gateway.
  * Elastic Load Balancer.
  * Auto Scaling.

* Cấu hình Security Group với các quy tắc cần thiết:

  * ICMP.
  * RDP (Port 3389).

* Cấu hình thành công:

  * Route 53 Resolver Outbound Endpoint.
  * Route 53 Resolver Inbound Endpoint.
  * Resolver Rules.

* Kiểm tra thành công hệ thống Hybrid DNS bằng các lệnh **nslookup** và **ping**, xác nhận việc phân giải DNS hai chiều hoạt động chính xác.

* Dọn dẹp toàn bộ tài nguyên AWS sau khi hoàn thành Lab 10, bao gồm:

  * Route 53 Resolver.
  * AWS Directory Service.
  * CloudFormation Stack.

### Kế hoạch tuần tiếp theo:

* Thực hành **Lab 19** theo lộ trình của AWS Study Group.

* Tìm hiểu các dịch vụ và kiến trúc được giới thiệu trong Lab 19.

* Hoàn thành các bài thực hành và kiểm thử kết quả triển khai.