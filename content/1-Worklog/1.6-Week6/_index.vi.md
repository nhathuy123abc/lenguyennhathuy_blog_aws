---
title: "Worklog Tuần 6"
date: 2026-07-07
weight: 6
chapter: false
pre: " <b> 1.6. </b> "
---


### Mục tiêu tuần 6:

* Tìm hiểu dịch vụ AWS Backup và triển khai giải pháp sao lưu dữ liệu tự động.
* Nghiên cứu AWS Storage Gateway để kết nối hệ thống lưu trữ cục bộ với AWS.
* Triển khai website tĩnh trên Amazon S3 kết hợp Amazon CloudFront.
* Tăng cường bảo vệ dữ liệu bằng Versioning và Cross-Region Replication.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --------- | ------------ | --------------- | -------------- |
| 1 | Cấu hình AWS Backup, tạo Backup Plan, thiết lập lịch sao lưu tự động và lựa chọn tài nguyên cần bảo vệ. | 25/05/2026 | 25/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 2 | Kiểm thử quy trình Backup và Restore, tích hợp Amazon SNS để gửi email thông báo trạng thái sao lưu. | 26/05/2026 | 26/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 3 | Triển khai AWS Storage Gateway (File Gateway), tạo S3 Bucket, khởi tạo EC2 Gateway và cấu hình chia sẻ tệp bằng giao thức SMB. | 27/05/2026 | 28/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 4 | Tạo Amazon S3 Bucket, triển khai Static Website Hosting, tải dữ liệu lên và cấu hình Amazon CloudFront để phân phối nội dung. | 29/05/2026 | 29/05/2026 | https://cloudjourney.awsstudygroup.com/ |
| 5 | Kích hoạt Versioning, cấu hình Cross-Region Replication (CRR), kiểm thử khả năng bảo vệ dữ liệu và dọn dẹp tài nguyên AWS sau khi hoàn thành Lab. | 30/05/2026 | 31/05/2026 | https://cloudjourney.awsstudygroup.com/ |

### Kết quả đạt được tuần 6:

* Triển khai thành công hệ thống sao lưu tự động bằng **AWS Backup**, bao gồm:

  * Tạo Backup Plan.
  * Thiết lập lịch sao lưu định kỳ.
  * Kiểm thử thành công quy trình Backup và Restore.

* Tích hợp **Amazon SNS** với AWS Backup để gửi email thông báo tự động khi quá trình sao lưu hoàn thành hoặc xảy ra lỗi.

* Hoàn thành triển khai **AWS Storage Gateway (File Gateway)**, bao gồm:

  * Tạo Amazon S3 Bucket lưu trữ dữ liệu.
  * Triển khai EC2 làm Gateway.
  * Cấu hình File Share bằng giao thức SMB.
  * Thiết lập quyền Guest Access cho người dùng.

* Triển khai thành công **Static Website Hosting** trên **Amazon S3**, bao gồm:

  * Tải lên các tệp HTML và hình ảnh.
  * Cấu hình Website Hosting.
  * Kiểm thử truy cập website.

* Kết nối **Amazon CloudFront** với Amazon S3 nhằm:

  * Tăng tốc độ truy cập website.
  * Hạn chế truy cập trực tiếp vào S3 để nâng cao tính bảo mật.

* Kích hoạt các tính năng bảo vệ dữ liệu:

  * Amazon S3 Versioning chống ghi đè hoặc xóa nhầm dữ liệu.
  * Cross-Region Replication (CRR) để sao lưu dữ liệu sang vùng AWS khác phục vụ Disaster Recovery.

### Kế hoạch tuần tiếp theo:

* Tiếp tục tăng cường bảo mật bằng cách chỉ cho phép truy cập Amazon S3 thông qua Amazon CloudFront.

* Kiểm thử hiệu năng phân phối nội dung của CloudFront tại nhiều khu vực khác nhau.

* Hoàn thiện cấu hình Versioning và Cross-Region Replication nhằm tối ưu khả năng bảo vệ và dự phòng dữ liệu.