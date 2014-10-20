set-password-on-linux
=====================

Quản lý tài khoản người dùng là một trong những công việc quan trọng nhất của quản trị viên hệ thống. Đặc biệt, bảo mật mật khẩu cần được coi là mối quan tâm hàng đầu đối với bất kỳ hệ thống Linux an toàn. Trong hướng dẫn này, tôi sẽ mô tả làm thế nào để thiết lập chính sách mật khẩu trên Linux.

### 1.Chuẩn bị
cài đặt module PAM để được hỗ trợ cracklib, có thể cung cấp thêm khả năng kiểm tra mật khẩu. Trên Debian, Ubuntu hay Linux Mint
Các mô-đun cracklib PAM được cài đặt mặc định trên CentOS, Fedora, hoặc RHEL. Vì vậy, không cần cài đặt thêm là cần thiết trên các hệ thống. 
Để thực thi chính sách mật khẩu, chúng ta cần phải sửa đổi một tập tin cấu hình PAM xác thực liên quan đến đặt tại /etc/pam.d. Chính sách thay đổi sẽ có hiệu lực ngay lập tức sau khi thay đổi. 
```
sudo apt-get install libpam-cracklib
```
### 2.Ngăn dùng lại mật khẩu cũ
Tìm đến dòng có cả 2 "password", "pam_unix.so và thêm "remember = 5" vào dòng này. Nó sẽ ngăn sử dụng 5 mật khẩu được sử dụng gần đây nhất (bằng cách lưu chúng vào file /etc/sercurity/opasswd

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
### 3.Set độ dài passwd ngắn nhất
Tìm sòng chứa cả 2 "password", "pam_unix.so" và thêm "minlen = 10".

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
### 4.Set độ phức tạp passwd
Tìm đến dòng có cả hai "password", "pam_unix.so" và thêm "ucredit=-1 lcredit=-2 dcredit=-1 ocredit=-1". Điều này có nghĩa là pasword của bạn buộc phải có ít nhất 1 một chữ hoa (ucredit), 2 chữ thường (lcredit), một chữ số (dcredit) và một biểu tượng (ocredit).

On Debian, Ubuntu or Linux Mint:
```
sudo vi /etc/pam.d/common-password
password   requisite    pam_cracklib.so retry=3 minlen=10 difok=3 ucredit=-1 lcredit=-2 dcredit=-1 ocredit=-1
```
On Fedora, CentOS or RHEL:
```
sudo vi /etc/pam.d/system-auth
password   requisite   pam_cracklib.so retry=3 difok=3 minlen=10 ucredit=-1 lcredit=-2 dcredit=-1 ocredit=-1
```
### 5.Set thời hạn cho password
Để thiết lập thời gian tối đa mật khẩu hiện tại là hợp lệ, chỉnh sửa các biến sau đây trong /etc/login.defs
Điều này sẽ buộc mọi người sử dụng để thay đổi mật khẩu của mình sáu tháng một lần, và gửi một thông điệp cảnh báo bảy ngày trước khi hết hạn mật khẩu. 
```
sudo vi /etc/login.defs

PASS_MAX_DAYS   150
PASS_MIN_DAYS   0
PASS_WARN_AGE   7
```
Nếu bạn muốn thiết lập mật khẩu hết hạn trên cơ sở mỗi người dùng, sử dụng lệnh chage thay thế. Để xem chính sách hết hạn mật khẩu cho một người dùng cụ thể:
```
sudo chage -l xmodulo

Last password change                                    : Dec 30, 2013
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : never
Minimum number of days between password change          : 0
Maximum number of days between password change          : 99999
Number of days of warning before password expires       : 7
```
Theo mặc định, mật khẩu của người dùng được thiết lập để không bao giờ hết hạn
Để thay đổi thời gian hết hạn mật khẩu cho người dùng xmodulo:
```
sudo chage -E 6/30/2014 -m 5 -M 90 -I 30 -W 14 xmodulo
```
Lệnh trên sẽ thiết lập mật khẩu hết hạn vào ngày 30/06/2014. Ngoài ra, số ngày tối thiểu/tối đa giữa các lần thay đổi mật khẩu được thiết lập để 5 và 90 tương ứng. Các tài khoản sẽ bị khóa 30 ngày sau khi mật khẩu hết hạn, và một tin nhắn cảnh báo sẽ được gửi ra 14 ngày trước khi hết hạn mật khẩu.

###Link tham khảo:
```
http://xmodulo.com/set-password-policy-linux.html
```
