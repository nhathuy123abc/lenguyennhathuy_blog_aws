---
title: "Worklog Tuần 4"
date: 2026-07-07
weight: 4
chapter: false
pre: " <b> 1.4. </b> "
---


### Mục tiêu tuần 4:

* Tìm hiểu các kiến trúc mạng nâng cao trên AWS.
* Hiểu cơ chế kết nối giữa nhiều VPC thông qua VPC Peering và AWS Transit Gateway.
* Thực hành triển khai hạ tầng bằng Infrastructure as Code với AWS CloudFormation và Application Composer.
* Giám sát và xử lý sự cố mạng bằng Reachability Analyzer.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --------- | ------------ | --------------- | -------------- |
| 1 | Tối ưu kết nối VPC Peering bằng cách cấu hình Route Table và Cross-Peer DNS để tăng tính bảo mật và hiệu quả kết nối giữa các VPC. | 11/05/2026 | 11/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 2 | Tìm hiểu kiến trúc AWS Transit Gateway và triển khai mô hình mạng trung tâm cho nhiều VPC. | 12/05/2026 | 12/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 3 | Thực hành Infrastructure as Code bằng AWS CloudFormation kết hợp với Application Composer để tự động triển khai VPC, Subnet, EC2 và Security Group. | 13/05/2026 | 13/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 4 | Thực hành giám sát và xử lý sự cố mạng bằng Reachability Analyzer, kiểm tra ENI, Security Group, Network ACL và Transit Gateway. | 14/05/2026 | 14/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 5 | Kiểm thử kết nối mạng, thực hiện dọn dẹp tài nguyên AWS và hoàn thành các bài Lab về hạ tầng mạng. | 15/05/2026 | 17/05/2026 | https://cloudjourney.awsstudygroup.com/ |

### Kết quả đạt được tuần 4:

* Cấu hình thành công **VPC Peering** và kiểm tra kết nối giữa các VPC thông qua địa chỉ Private IP.

* Hoàn thành triển khai và cấu hình **AWS Transit Gateway**, bao gồm:

  * Transit Gateway Attachments.
  * Route Table Association.
  * Route Propagation.
  * Định tuyến cho 4 VPC.

* Thiết lập **Bastion Host** để truy cập SSH vào các máy chủ EC2 nằm trong Private Subnet mà không cần kết nối Internet trực tiếp.

* Thực hành triển khai hạ tầng bằng:

  * AWS CloudFormation.
  * AWS Application Composer.

* Sử dụng **Reachability Analyzer** để phân tích và xử lý sự cố liên quan đến:

  * Elastic Network Interface (ENI).
  * Security Group.
  * Network ACL.
  * AWS Transit Gateway.

* Hoàn thành việc dọn dẹp tài nguyên AWS nhằm tối ưu chi phí, bao gồm:

  * Xóa VPC Peering.
  * Terminate các EC2 Instance.
  * Xóa CloudFormation Stack.

* Ôn tập và thực hành lại các Lab liên quan đến:

  * Amazon Route 53 Resolver.
  * AWS Directory Service.
  * AWS CloudFormation Stack.

### Kế hoạch tuần tiếp theo:

* Tìm hiểu dịch vụ máy chủ ảo Amazon EC2 và các loại Instance Type phù hợp với từng nhu cầu sử dụng.

* Nghiên cứu sự khác biệt giữa **Amazon EBS** và **Instance Store**.

* Thực hành triển khai EC2 với các loại lưu trữ khác nhau.

* Đánh giá và lựa chọn giải pháp lưu trữ phù hợp nhằm tối ưu hiệu năng và chi phí cho hệ thống.