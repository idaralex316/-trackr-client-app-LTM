-- Thêm cột Email vào các bảng
USE TrackerServer;
GO

-- Thêm Email cho Customer
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Customer' AND COLUMN_NAME = 'CusEmail')
BEGIN
    ALTER TABLE Customer ADD CusEmail NVARCHAR(MAX);
END
GO

-- Thêm Email cho DeliveryMan
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'DeliveryMan' AND COLUMN_NAME = 'ManEmail')
BEGIN
    ALTER TABLE DeliveryMan ADD ManEmail NVARCHAR(MAX);
END
GO

-- Thêm Email cho Admins
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Admins' AND COLUMN_NAME = 'AdEmail')
BEGIN
    ALTER TABLE Admins ADD AdEmail NVARCHAR(MAX);
END
GO

-- Cập nhật email cho các tài khoản mặc định
UPDATE Admins SET AdEmail = 'admin@trackr.com' WHERE AdAccount = 'admin';
UPDATE DeliveryMan SET ManEmail = 'delivery@trackr.com' WHERE ManAccount = 'delivery';
UPDATE Customer SET CusEmail = 'customer@trackr.com' WHERE CusAccount = 'customer';
GO

PRINT 'Đã thêm cột Email thành công!';
