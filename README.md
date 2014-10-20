set-password-on-linux
=====================
```
Quản lý tài khoản người dùng là một trong những công việc quan trọng nhất của quản trị viên hệ thống. Đặc biệt, bảo mật mật khẩu cần được coi là mối quan tâm hàng đầu đối với bất kỳ hệ thống Linux an toàn. Trong hướng dẫn này, tôi sẽ mô tả làm thế nào để thiết lập chính sách mật khẩu trên Linux.
```
###Chuẩn bị
cài đặt module PAM để được hỗ trợ cracklib, có thể cung cấp thêm khả năng kiểm tra mật khẩu. Trên Debian, Ubuntu hay Linux Mint
Các mô-đun cracklib PAM được cài đặt mặc định trên CentOS, Fedora, hoặc RHEL. Vì vậy, không cần cài đặt thêm là cần thiết trên các hệ thống. 
Để thực thi chính sách mật khẩu, chúng ta cần phải sửa đổi một tập tin cấu hình PAM xác thực liên quan đến đặt tại /etc/pam.d. Chính sách thay đổi sẽ có hiệu lực ngay lập tức sau khi thay đổi. 
```
sudo apt-get install libpam-cracklib
```
###Ngăn dùng lại mật khẩu cũ
Tìm đến dòng có cả 2 "password", "pam_unix.so và thêm "remember = 5" vào dòng này. Nó sẽ ngăn sử dụng 5 mật khẩu được sử dụng gần đây nhất (bằng cách lưu chúng vào file /etc/sercurity/opasswd).
On Debian, Ubuntu or Linux Mint:
```
sudo vi /etc/pam.d/common-password
password     [success=1 default=ignore]    pam_unix.so obscure sha512 remember=5
```
On Fedora, CentOS or RHEL:
```
sudo vi /etc/pam.d/system-auth
password   sufficient   pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5
```
###Set độ dài passwd ngắn nhất
Tìm sòng chứa cả 2 "password", "pam_unix.so" và thêm "minlen = 10"
On Debian, Ubuntu or Linux Mint:
```
sudo vi /etc/pam.d/common-password
password   requisite    pam_cracklib.so retry=3 minlen=10 difok=3
```
On Fedora, CentOS or RHEL:
```
sudo vi /etc/pam.d/system-auth
password   requisite   pam_cracklib.so retry=3 difok=3 minlen=10
```
