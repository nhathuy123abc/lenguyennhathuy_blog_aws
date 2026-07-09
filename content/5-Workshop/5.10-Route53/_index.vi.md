---
title: "Amazon Route 53"
date: 2024-01-01
weight: 10
chapter: false
pre: " <b> 5.10. </b> "
---

Amazon Route 53 dùng để gắn một **custom domain** (ví dụ `smartcv.com`) vào ứng dụng Frontend đang chạy trên AWS Amplify, thay vì dùng domain mặc định dạng `https://main.xxxxxxxxxx.amplifyapp.com` ở mục [5.9](../5.9-amplify/).

{{% notice note %}}
Mục này là **tuỳ chọn**. Nếu bạn không cần custom domain, có thể bỏ qua và dùng trực tiếp domain mặc định của Amplify.
{{% /notice %}}

#### Bước 1: Đăng ký domain trên Route 53

1. Truy cập dịch vụ **Amazon Route 53** trên AWS Console.
2. Ở menu bên trái, chọn **Domains** → **Registered domains** → **Register domain**.
3. Nhập tên domain bạn muốn (ví dụ `smartcv-yourname.com`), click **Check** để kiểm tra domain còn trống không.
4. Nếu domain khả dụng, thêm vào giỏ hàng (**Add to cart**), sau đó điền thông tin liên hệ (Contact information) và hoàn tất thanh toán.

![Đăng ký domain trên Route 53](/images/5-Workshop/5.10-Route53/image1.png)
**Hình 5.10.1** — Đăng ký domain mới trên Amazon Route 53.


Sau khi đăng ký thành công, Route 53 sẽ tự động tạo một **Hosted Zone** tương ứng với domain đó.

#### Bước 2: Thiết lập Hosted Zone và Record

1. Ở menu bên trái, chọn **Hosted zones**.
2. Click vào Hosted Zone tương ứng với domain của bạn (ví dụ `smartcv-yourname.com`).
3. Bạn sẽ thấy 2 record mặc định loại **NS** (Name Server) và **SOA** — không cần chỉnh sửa 2 record này.

![Danh sách record trong Hosted Zone](/images/5-Workshop/5.10-Route53/image2.png)
**Hình 5.10.2** — Hosted Zone với các record NS/SOA mặc định.

4. Việc tạo record trỏ về Amplify (loại **CNAME** hoặc **A - Alias**) sẽ được **AWS Amplify tự động thêm vào** ở bước tiếp theo (Bước 3) khi bạn gắn custom domain — bạn không cần tạo tay ở đây trừ khi Amplify yêu cầu xác minh domain bằng một record CNAME riêng.

#### Bước 3: Gắn Custom Domain vào AWS Amplify

1. Truy cập dịch vụ **AWS Amplify**, chọn app `smartcv-frontend` (đã tạo ở mục [5.9](../5.9-amplify/)).
2. Menu bên trái, chọn **App settings** → **Domain management**.
3. Click **Add domain**.
4. Chọn domain đã đăng ký ở Bước 1 (nếu domain đó đăng ký cùng tài khoản AWS, Amplify sẽ tự liệt kê).
5. Xác nhận nhánh (branch) muốn gắn domain (ví dụ `main`), click **Save**.
6. Amplify sẽ tự động tạo các record CNAME/A cần thiết trong Hosted Zone ở Route 53 (nếu domain cùng tài khoản AWS) và cấp **SSL certificate** miễn phí qua AWS Certificate Manager.

![Gắn Custom Domain trong Amplify](/images/5-Workshop/5.10-Route53/image3.png)
**Hình 5.10.3** — Gắn custom domain vào Amplify App.

7. Quá trình xác minh SSL và trỏ DNS có thể mất từ vài phút đến vài giờ. Theo dõi trạng thái ở cột **Domain status**.

#### Bước 4: Kiểm tra domain đã hoạt động

1. Sau khi trạng thái chuyển thành **Available**, mở lại **AWS Amplify Console**, vào app `smartcv-frontend`.
2. Kiểm tra domain vừa gắn hiển thị trạng thái **Deployed** với dấu tích màu xanh.
3. Mở domain vừa gắn trên trình duyệt để xác nhận SmartCV Frontend tải lên đúng qua domain riêng của bạn.

{{% notice note %}}
Nếu domain không lên sau nhiều giờ, kiểm tra lại: (1) Hosted Zone có đúng Name Server (NS) khớp với domain registrar không; (2) record CNAME xác minh SSL đã được Amplify thêm vào Hosted Zone chưa; (3) Domain status trên Amplify đang ở bước nào (Pending verification / In progress / Available).
{{% /notice %}}
