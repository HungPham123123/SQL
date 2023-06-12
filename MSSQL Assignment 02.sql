CREATE TABLE DanhSachSanPhamTheoHang (
MaSoHang INT PRIMARY KEY IDENTITY,
TenHang NVARCHAR(50) NOT NULL,
DiaChi NVARCHAR(100) NOT NULL,
DienThoai NVARCHAR(20) NOT NULL
);

CREATE TABLE DanhSachSanPham (
STT INT PRIMARY KEY IDENTITY,
TenMatHang NVARCHAR(50) NOT NULL,
MoTaHang NVARCHAR(100) NOT NULL,
DonVi NVARCHAR (50),
Gia INT,
SoLuongHienCo INT
);


INSERT INTO DanhSachSanPhamTheoHang(TenHang, DiaChi, DienThoai)

VALUES ('Asus', 'USA', 983232);


INSERT INTO DanhSachSanPham (TenMatHang, MoTaHang, DonVi, Gia, SoLuongHienCo)

VALUES ('May Tinh T450', 'May Nhap Cu', 'Chiec', 1000, 10),
	   ('Dien Thoai Nokia5670', 'Dien Thoai Dang Hot', 'Chiec', 200, 200),
	   ('May In Samsung 450', 'May In Dang Loai Binh', 'Chiec', 100, 10);

-- 4. Viết các câu lênh truy vấn để

-- a)
SELECT * FROM DanhSachSanPhamTheoHang

-- b)
SELECT * FROM DanhSachSanPham


-- 5. Viết các câu lệnh truy vấn để

-- a)
SELECT * FROM DanhSachSanPhamTheoHang
ORDER BY TenHang DESC
		
-- b)
SELECT * FROM DanhSachSanPham
ORDER BY Gia DESC

-- c)
SELECT * FROM DanhSachSanPhamTheoHang WHERE TenHang = 'Asus';

-- d)
SELECT * FROM DanhSachSanPham WHERE SoLuongHienCo < 11

-- e)
SELECT * FROM DanhSachSanPham WHERE TenMatHang IN (SELECT TenMatHang FROM DanhSachSanPhamTheoHang WHERE TenHang = 'Asus');

-- 6. Viết các câu lệnh truy vấn để lấy

-- a)
SELECT COUNT (*) FROM DanhSachSanPhamTheoHang;

-- b)
SELECT COUNT(*) FROM DanhSachSanPham;

-- c)
SELECT TenHang, COUNT(*) AS 'TongSoLoaiSanPham'
FROM DanhSachSanPhamTheoHang
JOIN DanhSachSanPham ON DanhSachSanPhamTheoHang.TenHang = DanhSachSanPham.TenMatHang
GROUP BY TenHang;

-- d)
SELECT SUM(SoLuongHienCo) AS 'TongSoLuong' FROM DanhSachSanPham;

-- 7. Thay đổi những thay đổi sau trên cơ sở dữ liệu

-- a)
UPDATE DanhSachSanPham
SET Gia = ABS(Gia)
WHERE Gia < 0;

-- b)
UPDATE DanhSachSanPhamTheoHang
SET DienThoai = CONCAT('0', DienThoai)
WHERE DienThoai NOT LIKE '0%';

-- 8. Thực hiện các yêu cầu sau

-- a)
CREATE INDEX idx_TenMatHang ON DanhSachSanPham (TenMatHang);
CREATE INDEX idx_MoTaHang ON DanhSachSanPham (MoTaHang);



-- b)
CREATE VIEW View_SanPham AS
SELECT STT AS 'Mã sản phẩm', TenMatHang AS 'Tên sản phẩm', Gia AS 'Giá bán'
FROM DanhSachSanPham;

CREATE VIEW View_SanPham_Hang AS
SELECT STT AS 'Mã SP', TenMatHang AS 'Tên sản phẩm', TenHang AS 'Hãng sản xuất'
FROM DanhSachSanPham
JOIN DanhSachSanPhamTheoHang ON DanhSachSanPhamTheoHang.MaSoHang = DanhSachSanPham.STT;



-- c)
CREATE PROCEDURE SP_SanPham_TenHang
    @TenHang NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM DanhSachSanPham
    WHERE TenMatHang IN (SELECT TenMatHang FROM DanhSachSanPhamTheoHang WHERE TenHang = @TenHang);
END;

CREATE PROCEDURE SP_SanPham_Gia
    @GiaBan INT
AS
BEGIN
    SELECT *
    FROM DanhSachSanPham
    WHERE Gia >= @GiaBan;
END;

CREATE PROCEDURE SP_SanPham_HetHang
AS
BEGIN
    SELECT *
    FROM DanhSachSanPham
    WHERE SoLuongHienCo = 0;
END;



-- d)
CREATE TRIGGER TG_Xoa_Hang
ON DanhSachSanPhamTheoHang
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Cannot delete manufacturer', 16, 1);
    ROLLBACK TRANSACTION;
END;

CREATE TRIGGER TG_Xoa_SanPham
ON DanhSachSanPham
INSTEAD OF DELETE
AS
BEGIN
    DELETE FROM DanhSachSanPham
    WHERE STT IN (SELECT STT FROM deleted WHERE SoLuongHienCo = 0);
END;





