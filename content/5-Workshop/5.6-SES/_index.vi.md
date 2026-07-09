---
title: "Amazon SES"
date: 2024-01-01
weight: 6
chapter: false
pre: " <b> 5.6. </b> "
---

Amazon SES được sử dụng để gửi email tự động cho người dùng, bao gồm email **Weekly Digest** (tổng hợp quá trình ứng tuyển) và **Follow-up Reminder** (nhắc nhở theo dõi hồ sơ).

1. Truy cập dịch vụ **Amazon SES** trên AWS Console.
2. Menu bên trái, dưới phần **Configuration**, chọn **Identities**.
3. Click **Create identity**.
4. Chọn loại identity là **Email address**.
5. Nhập địa chỉ email của bạn vào **Email address**.

![Tạo Identity trên SES](/images/5-Workshop/5.6-SES/ses1.png)
**Hình 5.6.1** — Tạo Identity (email address) trên Amazon SES.

AWS sẽ gửi một email xác nhận đến hòm thư của bạn với tiêu đề *"Amazon Web Services – Email Address Verification Request"*.

6. Mở hộp thư (kiểm tra cả hộp thư rác/spam), click vào đường link trong email để xác minh.

![Email xác nhận từ AWS SES](/images/5-Workshop/5.6-SES/ses2.png)
**Hình 5.6.2** — Email xác minh gửi từ AWS, cần click link để xác nhận.

7. Quay lại trang **Verified identities** trên SES Console, kiểm tra trạng thái (Identity status) của email đã chuyển sang màu xanh **Verified**.

![Xác minh thành công](/images/5-Workshop/5.6-SES/ses3.png)
**Hình 5.6.3** — Trạng thái Identity chuyển thành "Verified" (màu xanh).

#### Cập nhật email người gửi vào Lambda

Sau khi xác minh email, cập nhật email này vào biến môi trường của 2 hàm Lambda gửi mail (`smartcv-digest` và `smartcv-followup`):

1. Truy cập lại dịch vụ **Lambda**, mở hàm `smartcv-digest`.
2. Chuyển sang tab **Configuration** → **Environment identityvariables**.
3. Thêm/sửa biến `SES_FROM_EMAIL` = địa chỉ email đã verify.
4. Làm tương tự cho hàm `smartcv-followup`.

{{% notice note %}}
Vì Amazon SES ở chế độ Sandbox mặc định, bạn cần verify **cả email người gửi và người nhận** (nếu tài khoản AWS chưa được đưa ra khỏi Sandbox). Trong môi trường Production thật, cần gửi yêu cầu "Request production access" để bỏ giới hạn Sandbox.
{{% /notice %}}
