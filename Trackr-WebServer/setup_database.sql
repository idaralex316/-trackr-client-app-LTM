-- Tạo database nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TrackerServer')
BEGIN
    CREATE DATABASE TrackerServer;
END
GO

USE TrackerServer;
GO

-- Tạo bảng Admins
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Admins')
BEGIN
    CREATE TABLE Admins (
        AdID INT IDENTITY(1,1) PRIMARY KEY,
        AdName NVARCHAR(MAX),
        AdAccount NVARCHAR(MAX),
        AdPassword NVARCHAR(MAX)
    );
END
GO

-- Tạo bảng Customer
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Customer')
BEGIN
    CREATE TABLE Customer (
        CusID INT IDENTITY(1,1) PRIMARY KEY,
        CusName NVARCHAR(MAX),
        CusAddress NVARCHAR(MAX),
        CusPhone NVARCHAR(MAX),
        CusBirth DATETIME2,
        CusDateRegister DATETIME2,
        CusAccount NVARCHAR(MAX),
        CusPassword NVARCHAR(MAX)
    );
END
GO

-- Tạo bảng DeliveryMan
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DeliveryMan')
BEGIN
    CREATE TABLE DeliveryMan (
        ManID INT IDENTITY(1,1) PRIMARY KEY,
        ManName NVARCHAR(MAX),
        ManPhone NVARCHAR(MAX),
        ManAccount NVARCHAR(MAX),
        ManPassword NVARCHAR(MAX)
    );
END
GO

-- Tạo bảng Parcel
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Parcel')
BEGIN
    CREATE TABLE Parcel (
        ParID INT IDENTITY(1,1) PRIMARY KEY,
        ParImage NVARCHAR(MAX),
        ParDescription NVARCHAR(MAX),
        ParStatus NVARCHAR(MAX),
        ParDeliveryDate DATETIME2,
        ParLocation NVARCHAR(MAX),
        Realtime NVARCHAR(MAX),
        Note NVARCHAR(MAX),
        Price INT,
        CusID INT,
        ManID INT
    );
END
GO

-- Tạo bảng OTPs (từ migration sau)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'OTPs')
BEGIN
    CREATE TABLE OTPs (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Code NVARCHAR(MAX),
        TimeExpires DATETIME2
    );
END
GO

-- Tạo bảng Reviews (từ migration sau)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Reviews')
BEGIN
    CREATE TABLE Reviews (
        ReviewID INT IDENTITY(1,1) PRIMARY KEY,
        CusID INT,
        ManID INT,
        Rate INT,
        Description NVARCHAR(MAX)
    );
END
GO

-- Thêm Admin mặc định (password: admin123)
IF NOT EXISTS (SELECT * FROM Admins WHERE AdAccount = 'admin')
BEGIN
    INSERT INTO Admins (AdName, AdAccount, AdPassword) 
    VALUES (N'Administrator', 'admin', 'admin123');
END
GO

-- Thêm Delivery mặc định (password: delivery123)
IF NOT EXISTS (SELECT * FROM DeliveryMan WHERE ManAccount = 'delivery')
BEGIN
    INSERT INTO DeliveryMan (ManName, ManPhone, ManAccount, ManPassword) 
    VALUES (N'Nhân viên giao hàng', '0123456789', 'delivery', 'delivery123');
END
GO

-- Thêm Customer mặc định (password: customer123)
IF NOT EXISTS (SELECT * FROM Customer WHERE CusAccount = 'customer')
BEGIN
    INSERT INTO Customer (CusName, CusAddress, CusPhone, CusBirth, CusDateRegister, CusAccount, CusPassword) 
    VALUES (N'Khách hàng', N'TP.HCM', '0987654321', '2000-01-01', GETDATE(), 'customer', 'customer123');
END
GO

PRINT 'Database setup completed successfully!';
