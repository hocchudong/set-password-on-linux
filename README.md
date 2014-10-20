set-password-on-linux
=====================
#####Quản lý tài khoản người dùng là một trong những công việc quan trọng nhất của quản trị viên hệ thống. Đặc biệt, bảo mật mật khẩu cần được coi là mối quan tâm hàng đầu đối với bất kỳ hệ thống Linux an toàn. Trong hướng dẫn này, tôi sẽ mô tả làm thế nào để thiết lập chính sách mật khẩu trên Linux.
###Chuẩn bị
#####cài đặt module PAM để được hỗ trợ cracklib, có thể cung cấp thêm khả năng kiểm tra mật khẩu:
```apt-get install libpam-cracklib
```
