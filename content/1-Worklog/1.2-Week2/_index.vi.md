---
title: "Worklog Tuần 2"
date: 2026-07-07
weight: 2
chapter: false
pre: " <b> 1.2. </b> "
---


### Mục tiêu tuần 2:

* Tìm hiểu kiến trúc mạng trên AWS và dịch vụ Amazon VPC.
* Hiểu cách xây dựng hạ tầng mạng an toàn, có khả năng mở rộng trên AWS.
* Thực hành triển khai các thành phần mạng và dịch vụ cân bằng tải.
* Hoàn thành các nội dung trong Lab 03.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --------- | ------------ | --------------- | -------------- |
| 1 | Tìm hiểu và thực hành xây dựng kiến trúc mạng trên AWS, thiết lập VPC cùng các Public Subnet và Private Subnet trên nhiều Availability Zones. | 27/04/2026 | 27/04/2026 | https://cloudjourney.awsstudygroup.com/ |
| 2 | Nghiên cứu và cấu hình Security Group, Network ACL nhằm kiểm soát lưu lượng truy cập và tăng cường bảo mật hệ thống. | 28/04/2026 | 28/04/2026 | https://cloudjourney.awsstudygroup.com/ |
| 3 | Thiết lập Internet Gateway, NAT Gateway, Route Table và tìm hiểu VPC Endpoint để phục vụ kết nối mạng. | 29/04/2026 | 29/04/2026 | https://cloudjourney.awsstudygroup.com/ |
| 4 | Tìm hiểu VPC Peering, Transit Gateway và các phương thức kết nối hệ thống On-premises với AWS thông qua VPN và Direct Connect. | 30/04/2026 | 30/04/2026 | https://cloudjourney.awsstudygroup.com/ |
| 5 | Thực hành Elastic Load Balancer (ALB, NLB, GWLB) và hoàn thiện Lab 03 về hạ tầng mạng AWS. | 01/05/2026 | 01/05/2026 | https://cloudjourney.awsstudygroup.com/ |

### Kết quả đạt được tuần 2:

* Thiết lập thành công hệ thống mạng cơ bản trên AWS gồm:

  * 01 Amazon VPC.
  * Các Public Subnet và Private Subnet phân bố trên nhiều Availability Zones.

* Hoàn thành cấu hình các thành phần bảo mật:

  * Security Group cho EC2.
  * Network ACL cho các Subnet.

* Triển khai và cấu hình thành công:

  * Internet Gateway.
  * NAT Gateway.
  * Route Table.

* Hiểu rõ cơ chế định tuyến trong Amazon VPC và mối liên kết giữa các thành phần mạng.

* Nắm được nguyên lý hoạt động của:

  * VPC Peering.
  * Transit Gateway.
  * AWS VPN.
  * AWS Direct Connect.
  * VPC Endpoint.

* Thực hành dịch vụ Elastic Load Balancer, bao gồm:

  * Application Load Balancer (ALB).
  * Network Load Balancer (NLB).
  * Gateway Load Balancer (GWLB).

* Hiểu được vai trò của Load Balancer trong việc phân phối lưu lượng truy cập, nâng cao khả năng mở rộng và tính sẵn sàng của hệ thống.

### Kế hoạch tuần tiếp theo:

* Triển khai các máy chủ EC2 bên trong kiến trúc VPC đã xây dựng.

* Cấu hình NAT Gateway để các máy chủ trong Private Subnet có thể truy cập Internet một cách an toàn.

* Thiết lập EC2 Instance Connect Endpoint để quản lý và kết nối máy chủ.

* Kiểm thử toàn bộ kiến trúc mạng của Lab 04 nhằm đảm bảo các thành phần hoạt động đúng theo thiết kế.