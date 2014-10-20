set-password-on-linux
=====================
```
Quản lý tài khoản người dùng là một trong những công việc quan trọng nhất của quản trị viên hệ thống. Đặc biệt, bảo mật mật khẩu cần được coi là mối quan tâm hàng đầu đối với bất kỳ hệ thống Linux an toàn. Trong hướng dẫn này, tôi sẽ mô tả làm thế nào để thiết lập chính sách mật khẩu trên Linux.
```
###Chuẩn bị
``
cài đặt module PAM để được hỗ trợ cracklib, có thể cung cấp thêm khả năng kiểm tra mật khẩu. Trên Debian, Ubuntu hay Linux Mint

apt-get install libpam-cracklib
Các mô-đun cracklib PAM được cài đặt mặc định trên CentOS, Fedora, hoặc RHEL. Vì vậy, không cần cài đặt thêm là cần thiết trên các hệ thống. 

Để thực thi chính sách mật khẩu, chúng ta cần phải sửa đổi một tập tin cấu hình PAM xác thực liên quan đến đặt tại /etc/pam.d. Chính sách thay đổi sẽ có hiệu lực ngay lập tức sau khi thay đổi. 
``
