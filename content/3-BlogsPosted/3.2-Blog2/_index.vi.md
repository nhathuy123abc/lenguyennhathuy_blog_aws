---
title: "Blog 2"
date: 2026-06-25
weight: 2
chapter: false
pre: " <b> 3.2. </b> "
---

# Xây dựng Hybrid Multi-Tenant Architecture (Kiến trúc đa người thuê lai) cho Stateful Services trên AWS

Xin chào các anh chị, em vừa đọc một bài khá hay trên AWS Blog về cách xây dựng Hybrid Multi-Tenant Architecture cho các stateful services trên AWS. Đây là một bài toán rất thực tế đối với các hệ thống SaaS hoặc nền tảng phục vụ nhiều khách hàng cùng lúc, nhưng vẫn cần đảm bảo hiệu năng, cô lập tài nguyên và tối ưu chi phí vận hành.

### 1. Bài toán đặt ra
Trong bài blog, hệ thống được nhắc đến là một nền tảng ad-serving (máy chủ quảng cáo) quy mô lớn, xử lý hàng triệu request mỗi giây. Trước đây, kiến trúc sử dụng mô hình cellular architecture, tức là mỗi tenant hoặc khách hàng lớn sẽ có một AWS account riêng, VPC riêng, Application Load Balancer riêng và ECS riêng. Cách này giúp cô lập tốt, nhưng lại tạo ra nhiều vấn đề khi hệ thống mở rộng.

Các vấn đề chính gồm:
* **Khó mở rộng:** Mỗi tenant mới cần tạo thêm nhiều tài nguyên hạ tầng.
* **Tốn chi phí:** CPU trung bình chỉ khoảng 3%, memory khoảng 19%, nghĩa là phần lớn tài nguyên bị nhàn rỗi.
* **Onboarding lâu:** Việc đưa một khách hàng mới vào hệ thống có thể mất khoảng 52 ngày.
* **Noisy neighbor:** Với stateful service, dữ liệu được giữ trong memory. Nếu nhiều tenant dùng chung tài nguyên, tenant có dữ liệu lớn có thể ảnh hưởng đến tenant khác.

Điểm khó nằm ở chỗ đây không phải hệ thống stateless thông thường. Ứng dụng cần load và giữ dữ liệu trong bộ nhớ cho từng tenant để phục vụ request nhanh hơn, thay vì truy vấn database liên tục mỗi lần có request. Vì vậy, nếu chia sẻ compute không hợp lý, bộ nhớ của tenant này có thể làm ảnh hưởng đến tenant khác.

![Tối ưu hóa tài nguyên trên nhiều chiều](/images/3-BlogsPosted/blog2-diagram2.png)

### 2. Giải pháp AWS đề xuất
AWS đưa ra mô hình hybrid multi-tenant architecture, kết hợp giữa chia sẻ hạ tầng và cô lập tài nguyên ở cấp cluster.
Thay vì tạo một AWS account riêng cho từng tenant, kiến trúc này tổ chức hệ thống theo 3 lớp:
1. **Tier:** Nhóm các tenant có đặc điểm tải tương tự nhau, ví dụ High TPS, Standard TPS hoặc Low TPS.
2. **Cell:** Một AWS account dùng làm đơn vị mở rộng ngang ở cấp account.
3. **Infra Group:** Một cụm hạ tầng gồm VPC, Application Load Balancer, ECS clusters, IAM roles và monitoring stack.

Trong mỗi infra group, mỗi tenant vẫn có ECS cluster riêng, giúp đảm bảo cô lập compute và memory. Tuy nhiên, các phần dùng chung như VPC endpoint, IAM role hoặc kết nối downstream service được cấu hình sẵn ở cấp tier, giúp giảm đáng kể công sức triển khai.

![Kiến trúc Hybrid Multi-Tenant trên AWS](/images/3-BlogsPosted/blog2-diagram1.png)

### 3. Các dịch vụ AWS được sử dụng
* Amazon Route 53
* Application Load Balancer
* Amazon ECS
* Amazon VPC
* IAM Roles
* Amazon CloudWatch

### 4. Điểm đáng chú ý nhất
Điểm đáng chú ý nhất của kiến trúc này là cách AWS giải quyết bài toán cân bằng giữa isolation và operational efficiency.
Nếu cô lập quá mạnh, ví dụ mỗi tenant một AWS account, hệ thống sẽ an toàn nhưng vận hành nặng, tốn chi phí và onboarding chậm. Nếu chia sẻ quá nhiều, hệ thống tiết kiệm hơn nhưng dễ gặp lỗi noisy neighbor, đặc biệt với stateful services.

Mô hình hybrid giải quyết bằng cách:
* Chia sẻ hạ tầng ở cấp tier và infra group.
* Cô lập tenant ở cấp ECS cluster.
* Dùng ALB listener rules để route request đúng tenant.
* Dùng Route 53 weighted routing để mở rộng hoặc migrate traffic mà không cần thay đổi phía client.
* Dùng AWS PrivateLink để tái sử dụng kết nối private đến downstream services.

Kết quả trong bài blog cho thấy thời gian onboarding tenant giảm từ 52 ngày xuống còn 7 ngày, tương đương giảm khoảng 86%. Các bước setup hạ tầng và effort kỹ thuật cũng giảm khoảng 80%.

### 5. Kiến trúc truy vấn dữ liệu
Khi người dùng gửi request vào hệ thống, request sẽ được định tuyến đến đúng môi trường xử lý của từng tenant.

Luồng xử lý:
1. Client gửi request đến hệ thống.
2. Amazon Route 53 tiếp nhận và phân phối traffic.
3. Route 53 sử dụng weighted routing để chuyển traffic đến Application Load Balancer phù hợp.
4. Application Load Balancer kiểm tra tenant identifier.
5. Tenant identifier có thể nằm trong path như `/tenant-a/*` hoặc trong HTTP header.
6. ALB chuyển request đến tenant-specific listener rule.
7. Listener rule định tuyến request đến đúng target group của tenant.
8. Request được chuyển vào ECS Cluster riêng của tenant đó.
9. Ứng dụng trong ECS sử dụng biến môi trường như `TENANT_ID` để xác định tenant đang được phục vụ.
10. Ứng dụng chỉ load dữ liệu cấu hình và state tương ứng với tenant đó.
11. Dữ liệu tenant được lấy từ remote cache hoặc downstream service.
12. Kết nối đến downstream service được thực hiện riêng tư thông qua AWS PrivateLink.
13. Downstream services xử lý dữ liệu và trả kết quả về ứng dụng.
14. Ứng dụng trả response về lại cho client.

Ngoài ra, hệ thống có thể giám sát lỗi theo từng tenant bằng Amazon CloudWatch Logs Insights. Ví dụ, đội vận hành có thể truy vấn số lượng lỗi theo `tenant_id` để nhanh chóng xác định tenant nào đang gặp sự cố. Đây là điểm quan trọng trong kiến trúc multi-tenant vì nó giúp cô lập vấn đề, giảm ảnh hưởng giữa các tenant và hỗ trợ xử lý sự cố nhanh hơn.

### 6. Lợi ích chính
Kiến trúc này mang lại một số lợi ích rõ ràng:
* **Onboarding tenant nhanh hơn:** Tenant mới chủ yếu chỉ cần thay đổi cấu hình.
* **Cô lập tốt hơn:** Mỗi tenant có ECS cluster riêng, giảm rủi ro noisy neighbor.
* **Tối ưu tài nguyên:** Không cần tạo AWS account riêng cho từng tenant.
* **Mở rộng linh hoạt:** Có thể thêm infra group hoặc cell khi hệ thống đạt giới hạn.
* **Không ảnh hưởng client:** Route 53 giúp thay đổi phân phối traffic phía sau mà client không cần cập nhật DNS riêng.
* **Kết nối an toàn:** PrivateLink giúp kết nối private đến downstream services.

### 7. Kết luận
Bài blog này cho thấy một hướng thiết kế rất đáng học khi xây dựng hệ thống SaaS multi-tenant hoặc các nền tảng cần phục vụ nhiều khách hàng lớn trên AWS.
Thay vì chọn giữa hai hướng cực đoan là “mỗi tenant một hạ tầng riêng” hoặc “tất cả tenant dùng chung toàn bộ tài nguyên”, AWS đề xuất một mô hình trung gian: chia sẻ những phần có thể chia sẻ, nhưng vẫn cô lập những phần dễ gây ảnh hưởng hiệu năng như compute và memory.

Với các hệ thống stateful services, đặc biệt là hệ thống cần giữ dữ liệu trong memory để xử lý request nhanh, kiến trúc này là một gợi ý rất thực tế. Nó giúp giảm thời gian triển khai tenant mới, tối ưu chi phí vận hành và vẫn giữ được mức độ cô lập cần thiết cho từng khách hàng.

**Nguồn tham khảo:**
* AWS Architecture Blog: [Building Hybrid Multi-Tenant Architecture for Stateful Services on AWS](https://aws.amazon.com/blogs/architecture/building-hybrid-multi-tenant-architecture-for-stateful-services-on-aws/)
* Facebook: [AWS Study Group FCJ](https://www.facebook.com/groups/awsstudygroupfcj/permalink/2194925764605717?locale=vi_VN)

*(Đây là 1 bài blog mình đọc được và thấy trên aws blog, đây là những gì mình đã tóm tắt sau khi mình đọc xong có gì sai sót mong mọi người bỏ qua .)*