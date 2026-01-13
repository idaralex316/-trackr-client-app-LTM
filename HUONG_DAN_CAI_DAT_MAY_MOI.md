# HƯỚNG DẪN CÀI ĐẶT VÀ CHẠY ỨNG DỤNG TRACKR TRÊN MÁY MỚI

> **Lưu ý**: Đây là hướng dẫn đầy đủ để cài đặt ứng dụng từ đầu trên máy tính mới hoàn toàn.

## 📋 YÊU CẦU HỆ THỐNG

### Hệ điều hành:
- Windows 10/11 (64-bit)
- RAM: Tối thiểu 4GB (Khuyến nghị 8GB)
- Ổ cứng trống: Tối thiểu 5GB

### Phần mềm cần cài đặt:

#### 1. **Git for Windows**
- Download: https://git-scm.com/download/win
- Chọn phiên bản 64-bit
- Cài đặt với tùy chọn mặc định

#### 2. **Visual Studio 2022** (Community Edition - Miễn phí)
- Download: https://visualstudio.microsoft.com/downloads/
- Trong quá trình cài đặt, chọn các workloads:
  - ✅ **.NET desktop development**
  - ✅ **ASP.NET and web development**
- Dung lượng: ~10-15GB

#### 3. **.NET SDK 8.0 hoặc 10.0**
- Download: https://dotnet.microsoft.com/download
- Chọn: **.NET SDK** (không phải Runtime)
- Sau khi cài, kiểm tra: `dotnet --version`

#### 4. **SQL Server 2022 Express** (Miễn phí)
- Download: https://www.microsoft.com/sql-server/sql-server-downloads
- Chọn: **Express Edition**
- Trong quá trình cài:
  - Authentication Mode: **Mixed Mode**
  - Tạo password cho tài khoản `sa` (ví dụ: `Admin@123`)
  - Instance Name: `SQLEXPRESS` hoặc tùy chỉnh

#### 5. **SQL Server Management Studio (SSMS)** - Tùy chọn nhưng khuyến nghị
- Download: https://aka.ms/ssmsfullsetup
- Dễ dàng quản lý database

---

## 🚀 BƯỚC 1: CÀI ĐẶT PHẦN MỀM

### 1.1. Cài đặt Git
```powershell
# Kiểm tra Git đã cài đặt chưa
git --version
```

### 1.2. Cài đặt .NET SDK
```powershell
# Kiểm tra .NET SDK
dotnet --version

# Nếu chưa có, download và cài từ link trên
# Khuyến nghị: .NET 8.0 LTS hoặc .NET 10.0
```

### 1.3. Cài đặt SQL Server
- Chọn **SQL Server Express** (miễn phí)
- Chọn **Mixed Mode Authentication**
- Nhớ password cho tài khoản `sa`
- Chọn instance name (ví dụ: `SQLEXPRESS` hoặc `LTMCK`)

### 1.4. Cài đặt Visual Studio 2022
- Chọn workload: **.NET desktop development**
- Chọn workload: **ASP.NET and web development**

---

## 🚀 BƯỚC 2: CLONE REPOSITORY

### 2.1. Tạo thư mục làm việc
Mở **PowerShell** hoặc **Command Prompt**:

```powershell
# Tạo thư mục (có thể thay đổi đường dẫn tùy ý)
mkdir "C:\Projects\Trackr"
cd "C:\Projects\Trackr"
```

> **Lưu ý**: Bạn có thể thay `C:\Projects\Trackr` bằng đường dẫn bất kỳ trên máy của bạn.

### 2.2. Clone Client Repository
```powershell
git clone https://github.com/thu4n/trackr-client-app.git
```

**Lưu ý**: Nếu gặp lỗi SSL, chạy:
```powershell
git config --global http.sslVerify false
```

### 2.3. Clone Server Repository
```powershell
git clone https://github.com/howtodie123/Trackr-WebServer.git
```

Sau khi clone xong, cấu trúc thư mục sẽ như sau:
```
C:\Projects\Trackr\
├── trackr-client-app/
└── Trackr-WebServer/ của bạn

**Cách 1: Dùng PowerShell**
```powershell
# Liệt kê các SQL Server instance
Get-Service | Where-Object {$_.Name -like 'MSSQL*'}
```

**Cách 2: Dùng SQL Server Configuration Manager**
- Tìm "SQL Server Configuration Manager" trong Start Menu
- Xem tên instance trong phần "SQL Server Services"

Tên instance thường là:
- `.\SQLEXPRESS` (nếu cài SQL Server Express)
- `localhost\SQLEXPRESS`
- `(localdb)\MSSQLLocalDB`

> **Ghi nhớ tên instance này**, bạn sẽ cần dùng ở các bước sau!

### 3.3. Tạo Database

**Bước 1: Di chuyển đến thư mục server**
```powershell
cd "C:\Projects\Trackr\Trackr-WebServer"
```

**Bước 2: Chạy script tạo database**
```powershell
# Thay .\SQLEXPRESS bằng instance name của bạn
sqlcmd -S ".\SQLEXPRESS" -E -C -i "setup_database.sql"
sqlcmd -S ".\SQLEXPRESS" -E -C -i "add_email_column.sql"
```

**Nếu gặp lỗi "sqlcmd không được nhận dạng":**
- Thêm SQL Server vào PATH, hoặc
- Sử dụng đường dẫn đầy đủ: `"C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\sqlcmd.exe"lcmd -L

# Hoặc kiểm tra trong SQL Server Configuration Manager
```
Thường là: `.\SQLEXPRESS` hoặc `.\LTMCK` hoặc `localhost\SQLEXPRESS`

### 3.3. Tạo Database
Có 2 cách:

**Cách 1: Sử dụng script SQL** (Khuyến nghị)
```powershell
cd "E:\Lập Trình Mạng\CKLTM\Trackr-WebServer"


**Bước 1: Mở file cấu hình**
```
C:\Projects\Trackr\Trackr-WebServer\TestTestServer\TestTestServer\appsettings.json
```

**Bước 2: Tìm dòng `ConnectionStrings` và sửa:**

```json
{
  "ConnectionStrings": {
    "ApiDatabase": "Data Source=.\SQLEXPRESS;Initial Catalog=TrackerServer;Integrated Security=True;TrustServerCertificate=true"
  }
}
```

**Quan trọng**: Thay `.\SQLEXPRESS` bằng **tên instance** của bạn (xác định ở Bước 3.2):
- Nếu instance là `SQLEXPRESS`: `.\SQLEXPRESS`
- Nếu instance tên khác (ví dụ `MYINSTANCE`): `.\MYINSTANCE`
- Nếu dùng LocalDB: `(localdb)\MSSQLLocalDBU HÌNH SERVER

### 4.1. Cập nhật Connection String
Mở file: `E:\Lập Trình Mạng\CKLTM\Trackr-WebServer\TestTestServer\TestTestServer\appsettings.json`

```json
{
  "ConnectionStrings": {
    "ApiDatabase": "Data Source=.\LTMCK;Initial Catalog=TrackerServer;Integrated Security=True;TrustServerCertificate=true"
  }
}
```
Kiểm tra .NET Version

```powershell
dotnet --version
```

Nếu kết quả là `8.x.x` hoặc `10.x.x` → OK, bỏ qua bước 4.3

Nếu không hiển thị hoặc lỗi → Cài lại .NET SDK

### 4.3. Cập nhật Target Framework (nếu cần)

Mở file: `C:\Projects\Trackr\Trackr-WebServer\TestTestServer\TestTestServer\TestTestServer.csproj`

Tìm dòng:
```xml
<TargetFramework>net10.0</TargetFramework>
```

**Nếu máy bạn chỉ có .NET 8.0**, đổi thành:
```xml
<TargetFramework>net8.0</TargetFramework>
```

**Nếu có .NET 10.0** → Không cần sửa

### 4.4. Tạo thư mục uploads

```powershell
cd "C:\Projects\Trackr\Trackr-WebServer\TestTestServer\TestTestServer"
mkdir wwwroot\uploads
```

### 4.5. Build và Test Server

```powershell
cd "C:\Projects\Trackr\Trackr-WebServer\TestTestServer\TestTestServer"


**Bước 1: Mở file**
```
C:\Projects\Trackr\trackr-client-app\trackr-client-app\trackr-client-app\Models\UserSession.cs
```

**Bước 2: Tìm dòng `apiUrl` và đảm bảo nó là:**
```csharp
public static readonly string apiUrl = "https://localhost:7111/api/";
```

> Nếu dòng này đang là URL khác (Azure, v.v.), đổi về `https://localhost:7111/api/`

### 5.2. Trust SSL Certificate

Mở **PowerShell với quyền Administrator** và chạy:

```powershell
dotnet dev-certs https --trust
```

Click **"Yes"** khi có popup xác nhận.

### 5.3. Mở Client trong Visual Studio

**Bước 1: Mở Visual Studio 2022**

**Bước 2: Open a project or solution**

**Bước 3: Chọn file:**
```Đảm bảo Server đang chạy

Nếu bạn đã tắt server ở Bước 4.5, hãy chạy lại:

**Mở PowerShell/CMD mới**:
```powershell
cd "C:\Projects\Trackr\Trackr-WebServer\TestTestServer\TestTestServer"
dotnet run
```

**Giữ terminal này mở!** Server cần chạy liên tục khi dùng client.

### 6.2. Chạy Client Application

**Trong Visual Studio:**
1. Nhấn **F5** hoặc click nút **Start** (có icon ▶️)
2. Đợi ứng dụng khởi động (5-10 giây)
3. Cửa sổ đăng nhập sẽ hiện ra

### 6.3. Đăng nhập lần đầu

Hệ thống đã tạo sẵn 3 tài khoản mẫu:

#### 🔑 Administrator (Quản lý)
```
Email/Username: admin@trackr.com (hoặc admin)
Password: admin123
```
**Quyền hạn**: Quản lý toàn bộ đơn hàng, nhân viên, khách hàng

#### 🚚 Delivery (Nhân viên giao hàng)
```
Email/Username: delivery@trackr.com (hoặc delivery)
Password: delivery123
```
**Quyền hạn**: Cập nhật trạng thái đơn hàng

#### 👤 Customer (Khách hàng)
```
Email/Username: customer@trackr.com (hoặc customer)
Password: customer123
```
**Quyền hạn**: Xem đơn hàng của mình

> **Lưu ý**: Bạn có thể đăng nhập bằng **email** hoặc **username**!

### 6.4. Tạo tài khoản mới (Tùy chọn)

1. Click **"Đăng ký"** trên màn hình login
2. Điền thông tin đầy đủ
3. Chọn loại tài khoản
4. Đăng ký thành công
### 5.1. Cập nhật API URL
Mở file: `E:\Lập Trình Mạng\CKLTM\trackr-client-app\trackr-client-app\trackr-client-app\Models\UserSession.cs`

Đảm bảo dòng này trỏ đến localhost:
```csharp

**Nguyên nhân**: Connection string sai hoặc SQL Server không chạy

**Giải pháp:**

**Bước 1: Kiểm tra SQL Server đang chạy**
```powershell
Get-Service | Where-Object {$_.Name -like 'MSSQL*'} | Select Name, Status
```

Nếu Status không phải `Running`:
```powershell
# Thay SQLEXPRESS bằng tên instance của bạn
Start-Service MSSQL$SQLEXPRESS
```

**Bước 2: Test connection**
```powershell
# Thay .\SQLEXPRESS bằng instance của bạn
sqlcmd -S ".\SQLEXPRESS" -E -Q "SELECT @@VERSION"
```

Nếu thành công → hiển thị version SQL Server

**Bước 3: Kiểm tra connection string**
- Mở `appsettings.json`
- Đảm bảo `Data Source` đúng với instance name
- Ví dụ: `Data Source=.\SQLEXPRESS;...Build solution: **Ctrl+Shift+B**

---

## 🚀 BƯỚC 6: CHẠY ỨNG DỤNG

### 6.1. Chạy Server (Terminal 1)
```powershell
cd "E:\Lập Trình Mạng\CKLTM\Trackr-WebServer\TestTestServer\TestTestServer"
dotnet run
```
**Để terminal này chạy ở background!**

### 6.2. Chạy Client (Visual Studio) hoặc không kết nối được API

**Nguyên nhân**: Client không kết nối được server

**Giải pháp:**

**Bước 1: Kiểm tra server đang chạy**
```powershell
netstat -ano | findstr "7111"
```

Nếu không có kết quả → Server chưa chạy:
```powershell
cd "C:\Projects\Trackr\Trackr-WebServer\TestTestServer\TestTestServer"
dotnet run
```

**Bước 2: Kiểm tra API URL**
- Mở `UserSession.cs`
- Đảm bảo: `apiUrl = "https://localhost:7111/api/";`

**Bước 3: Trust SSL certificate**
```powershell
dotnet dev-certs https --clean
dotnet dev-certs https --trust
```

**Bước 4: Tắt Firewall/Antivirus tạm thời** (nếu vẫn lỗi)

**Bước 5: Build lại client** (Ctrl+Shift+B trong Visual Studio)word: `delivery123`

**Customer:**
- Email/Username: `customer@trackr.com` hoặc `customer`
- Password: `customer123`

---

## 🔧 KHẮC PHỤC SỰ CỐ THƯỜNG GẶP

### ❌ Lỗi: "Cannot connect to SQL Server"
**Nguyên nhân:** Connection string sai hoặc SQL Server không chạy

**Giải pháp:**
```powershell
# 1. Kiểm tra SQL Server đang chạy
Get-Service MSSQL*

# 2. Khởi động nếu cần
Start-Service MSSQL$LTMCK

# 3. Test connection
sqlcmd -S ".\LTMCK" -E -Q "SELECT @@VERSION"


**Nguyên nhân**: Database chưa được tạo

**Giải pháp: Chạy lại script tạo database**
```powershell
cd "C:\Projects\Trackr\Trackr-WebServer"
sqlcmd -S ".\SQLEXPRESS" -E -C -i "setup_database.sql"
sqlcmd -S ".\SQLEXPRESS" -E -C -i "add_email_column.sql"
```

> Nhớ thay `.\SQLEXPRESS` bằng instance của bạn!

### ❌ Lỗi: "Login failed" hoặc tài khoản không đúng

**Nguyên nhân**: Database chưa có tài khoản mặc định

**Giải pháp:**

**Cách 1: Kiểm tra database có dữ liệu không**
```powershell
sqlcmd -S ".\SQLEXPRESS" -E -C -d TrackerServer -Q "SELECT * FROM Admins"
```

Nếu trả về "0 rows affected" → Chạy lại `setup_database.sql`

**Cách 2: Dùng SSMS**
1. Mở SQL Server Management Studio
2. Connect đến instance
3. Chạy query:
```sql
USE TrackerServer;
SELECT * FROM Admins;
SELECT * FROM Customer;
SELECT * FROM DeliveryMan;
```

Nếu bảng trống → Import lại dữ liệu mẫu │   ├── TestTestServer.sln
    │   └── TestTestServer/
    │       ├── appsettings.json         # ⚙️ CẤU HÌNH SQL CONNECTION
    │       ├── wwwroot/
    │       │   └── uploads/             # Nơi lưu ảnh đơn hàng
    │       ├── Controllers/
    │       ├── Models/
    │       └── Program.cs
    ├── setup_database.sql               # Script tạo database
    ├── add_email_column.sql             # Script thêm email
    └── README.md
```

**File quan trọng cần cấu hình:**
1. `appsettings.json` → SQL Server connection string
2. `UserSession.cs` → API URL"E:\Lập Trình Mạng\CKLTM\Trackr-WebServer"
sqlcmd -S ".\LTMCK" -E -C -i "setup_database.sql"
sqlcmd -S ".\LTMCK" -E -C -i "add_email_column.sql"
```

### ❌ Lỗi: "Login failed"
**Nguyên nhân:** Tài khoản chưa có trong database

**Giải pháp:**
```sql
-- Mở SSMS và chạy:
USE TrackerServer;
SELECT * FROM Admins;
SELECT * FROM Customer;
SELECT * FROM DeliveryMan;

-- Nếu không có data, chạy lại setup_database.sql
```

---

## 📁 CẤU TRÚC THƯ MỤC SAU KHI SETUP

```
E:\Lập Trình Mạng\CKLTM\
│
├── trackr-client-app/                    # Client Desktop App
│   ├── trackr-client-app/
│   │   ├── trackr-client-app.sln        # Visual Studio Solution
│   │   └── trackr-client-app/
│   │       ├── Models/
│   │       │   └── UserSession.cs       # CẤU HÌNH API URL
│   │       ├── Views/
│   │       ├── LoginForm.cs
│   │       └── ...
│   └── README.md
│
├── Trackr-WebServer/                     # Server Backend
│   ├── TestTestServer/
│   │   ├── TestTestServer.sln           # Visual Studio Solution
│   │   └── TestTestServer/
│   │       ├── appsettings.json         # CẤU HÌNH CONNECTION STRING
│   │       ├── Controllers/
│   │       ├── Models/
│   │       └── ...
│   ├── setup_database.sql               # Script tạo database
│   ├── add_email_column.sql             # Script thêm email
│   └── README.md
│
├── HUONG_DAN_SU_DUNG.md                 # Hướng dẫn sử dụng thường ngày
└── HUONG_DAN_CAI_DAT_MAY_MOI.md         # File này
```

---

## ✅ CHECKLIST TRƯỚC KHI CHẠY

- [ ] Đã cài đặt Git
- [ ] Đã cài đặt .NET SDK (8.0 hoặc 10.0)
- [ ] Đã cài đặt Visual Studio 2022
- [ ] Đã cài đặt SQL Server (Express/Developer)
- [ ] SQL Server đang chạy
- [ ] Đã clone cả 2 repository (client và server)
- [📝 NOTES QUAN TRỌNG

### Thứ tự khởi động:
1. **SQL Server** (tự động khởi động với Windows)
2. **Server Backend** (`dotnet run`)
3. **Client App** (F5 trong Visual Studio)

### Khi sử dụng hàng ngày:
- Server cần chạy **trước** khi mở client
- **Giữ terminal server mở** suốt quá trình dùng client
- Đóng client trước, sau đó mới tắt server (Ctrl+C)

### File cấu hình quan trọng:
| File | Mục đích | Cần sửa khi |
|------|----------|-------------|
| `appsettings.json` | SQL connection | Đổi SQL instance |
| `UserSession.cs` | API URL | Đổi server address |

### Tính năng chính:
- ✅ Đăng nhập bằng email hoặc username
- ✅ Upload ảnh đơn hàng (lưu local)
- ✅ Quản lý đơn hàng real-time
- ✅ 3 loại user: Admin, Delivery, Customer

---

## 🎉 HOÀN TẤT CÀI ĐẶT!

Sau khi làm theo tất cả các bước trên, bạn đã có:
- ✅ Môi trường phát triển hoàn chỉnh
- ✅ Database với dữ liệu mẫu
- ✅ Server backend đang chạy
- ✅ Client desktop app sẵn sàng

### Bước tiếp theo:
1. Khám phá các tính năng của ứng dụng
2. Tạo đơn hàng thử nghiệm
3. Test với các loại user khác nhau
4. Tùy chỉnh theo nhu cầu

### Cần hỗ trợ?
- Đọc file `HUONG_DAN_SU_DUNG.md` cho hướng dẫn chi tiết
- Kiểm tra phần "Khắc phục sự cố" ở trên
- Xem log trong terminal/Output window

**Chúc bạn thành công!** 🚀

---

*Tài liệu này được tạo cho môn Lập Trình Mạng - UIT*
dotnet --list-sdks
dotnet --list-runtimes

# SQL Server
sqlcmd -?
```

### Xem log chi tiết khi chạy server:
```powershell
cd "E:\Lập Trình Mạng\CKLTM\Trackr-WebServer\TestTestServer\TestTestServer"
dotnet run --verbosity detailed
```

### Xem database đã tạo chưa:
```powershell
sqlcmd -S ".\LTMCK" -E -C -Q "SELECT name FROM sys.databases"
```

### Xem các bảng trong database:
```powershell
sqlcmd -S ".\LTMCK" -E -C -d TrackerServer -Q "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES"
```

---

## 🎓 GHI CHÚ QUAN TRỌNG

1. **Luôn chạy Server trước, Client sau**
2. **Server phải chạy ở background** trong khi dùng client
3. **Đảm bảo SQL Server instance đang chạy** trước khi start server
4. **Connection string** phải match với instance name của SQL Server
5. **API URL** trong client phải trỏ đúng địa chỉ server đang chạy
6. **Có thể đăng nhập bằng email hoặc username**

---

## 🎉 HOÀN TẤT!

Sau khi hoàn thành tất cả các bước trên, bạn đã có thể:
- ✅ Chạy server backend
- ✅ Chạy client desktop app
- ✅ Đăng nhập và sử dụng ứng dụng

Chúc bạn thành công! 🚀
