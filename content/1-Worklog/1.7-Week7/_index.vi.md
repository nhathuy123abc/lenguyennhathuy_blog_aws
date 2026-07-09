---
title: "Worklog Tuần 7"
date: 2026-07-07
weight: 7
chapter: false
pre: " <b> 1.7. </b> "
---


### Mục tiêu tuần 7:

* Nghiên cứu chuyên sâu về Amazon S3 và các giải pháp lưu trữ trên AWS.
* Tìm hiểu hệ sinh thái sao lưu và Hybrid Cloud.
* Thực hành các tính năng nâng cao của Amazon S3 phục vụ bảo mật và quản lý dữ liệu.
* Làm quen với dịch vụ Amazon FSx for Windows File Server.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --------- | ------------ | --------------- | -------------- |
| 1 | Tìm hiểu Amazon S3, bao gồm Storage Classes, Access Point, Object Key, tối ưu hiệu năng, S3 Glacier, Static Website Hosting và cấu hình CORS. | 01/06/2026 | 01/06/2026 | https://cloudjourney.awsstudygroup.com/ |
| 2 | Nghiên cứu AWS Snow Family, AWS Storage Gateway và AWS Backup phục vụ lưu trữ Hybrid Cloud và sao lưu tập trung. | 02/06/2026 | 02/06/2026 | https://cloudjourney.awsstudygroup.com/ |
| 3 | Thực hành tạo Amazon S3 Bucket, cấu hình Access Point, Gateway Endpoint, Versioning, Object Lock, Glacier và Static Website Hosting có bật CORS. | 03/06/2026 | 04/06/2026 | https://cloudjourney.awsstudygroup.com/ |
| 4 | Triển khai AWS Backup, cấu hình AWS Storage Gateway và khởi tạo Amazon FSx for Windows File Server. | 05/06/2026 | 05/06/2026 | https://cloudjourney.awsstudygroup.com/ |
| 5 | Kiểm thử các dịch vụ đã triển khai, tổng kết kiến thức về Hybrid Storage và hoàn thành các bài Lab của Module 04. | 06/06/2026 | 07/06/2026 | https://cloudjourney.awsstudygroup.com/ |

### Kết quả đạt được tuần 7:

* Triển khai thành công môi trường lưu trữ **Amazon S3**, bao gồm:

  * Tạo S3 Bucket.
  * Cấu hình S3 Access Point.
  * Thiết lập S3 Gateway Endpoint để EC2 trong VPC truy cập S3 mà không cần Internet.
  * Triển khai Static Website Hosting và cấu hình CORS.

* Hoàn thành cấu hình các tính năng bảo vệ dữ liệu trên Amazon S3:

  * S3 Versioning.
  * S3 Object Lock.
  * Chuyển dữ liệu ít truy cập sang S3 Glacier để lưu trữ dài hạn.

* Triển khai và vận hành thành công:

  * AWS Backup phục vụ sao lưu định kỳ.
  * AWS Storage Gateway kết nối môi trường lưu trữ Hybrid Cloud.

* Khởi tạo thành công dịch vụ **Amazon FSx for Windows File Server** ở mức cơ bản và làm quen với quy trình triển khai.

* Nắm vững các giải pháp tối ưu lưu trữ, bảo vệ dữ liệu và truy cập an toàn trên nền tảng AWS.

### Kế hoạch tuần tiếp theo:

* Triển khai hệ thống **Amazon FSx for Windows File Server** với cấu hình SSD Multi-AZ.

* Tạo và cấu hình các thư mục chia sẻ (File Shares) trên hệ thống FSx.

* Kiểm thử hiệu năng đọc/ghi và đánh giá thông lượng của hệ thống lưu trữ.

* Tiếp tục nghiên cứu các giải pháp lưu trữ doanh nghiệp trên AWS.