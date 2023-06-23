CREATE TABLE LoaiSanPham (
    MaLoaiSP VARCHAR(10) PRIMARY KEY,
    TenLoaiSP NVARCHAR(100)
);

CREATE TABLE NguoiChiuTrachNhiem (
    MaNCTN INT PRIMARY KEY,
    TenNCTN NVARCHAR(100)
);

CREATE TABLE SanPham (
    MaSP VARCHAR(10) PRIMARY KEY,
    NgaySanXuat DATE,
    MaLoaiSP VARCHAR(10) REFERENCES LoaiSanPham(MaLoaiSP),
    MaNCTN INT REFERENCES NguoiChiuTrachNhiem(MaNCTN)
);

INSERT INTO LoaiSanPham (MaLoaiSP, TenLoaiSP)
VALUES ('Z37E', 'Máy tính sách tay Z37');

INSERT INTO NguoiChiuTrachNhiem (MaNCTN, TenNCTN)
VALUES (987688, 'Nguyễn Văn An');

INSERT INTO SanPham (MaSP, NgaySanXuat, MaLoaiSP, MaNCTN)
VALUES ('Z37 111111', '2009-12-12', 'Z37E', 987688);

SELECT * FROM LoaiSanPham;

SELECT * FROM SanPham;

SELECT * FROM NguoiChiuTrachNhiem;

SELECT * FROM LoaiSanPham ORDER BY TenLoaiSP ASC;

SELECT * FROM NguoiChiuTrachNhiem ORDER BY TenNCTN ASC;

SELECT * FROM SanPham WHERE MaLoaiSP = 'Z37E';

SELECT * FROM SanPham
WHERE MaNCTN = 987688
ORDER BY MaSP DESC;

SELECT MaLoaiSP, COUNT(*) AS SoSanPham
FROM SanPham
GROUP BY MaLoaiSP;

SELECT COUNT(*) / COUNT(DISTINCT MaLoaiSP) AS SoLoaiSanPhamTrungBinh
FROM SanPham;

SELECT *
FROM SanPham
INNER JOIN LoaiSanPham ON SanPham.MaLoaiSP = LoaiSanPham.MaLoaiSP;

SELECT *
FROM SanPham
INNER JOIN LoaiSanPham ON SanPham.MaLoaiSP = LoaiSanPham.MaLoaiSP
INNER JOIN NguoiChiuTrachNhiem ON SanPham.MaNCTN = NguoiChiuTrachNhiem.MaNCTN;

UPDATE SanPham
SET NgaySanXuat = GETDATE()
WHERE NgaySanXuat <= GETDATE();

EXEC sp_helpindex 'LoaiSanPham';
EXEC sp_helpindex 'NguoiChiuTrachNhiem';
EXEC sp_helpindex 'SanPham';

EXEC sp_fkeys 'LoaiSanPham';
EXEC sp_fkeys 'NguoiChiuTrachNhiem';
EXEC sp_fkeys 'SanPham';

ALTER TABLE SanPham
ADD PhienBan NVARCHAR(50);

CREATE INDEX idx_TenNCTN ON NguoiChiuTrachNhiem(TenNCTN);

CREATE VIEW View_SanPhamss AS
SELECT MaSP, NgaySanXuat, MaLoaiSP
FROM SanPham;

CREATE VIEW View_SanPham_NCTN AS
SELECT MaSP, NgaySanXuat, MaNCTN
FROM SanPham;

CREATE VIEW View_Top_SanPham AS
SELECT TOP 5 MaSP, MaLoaiSP, NgaySanXuat
FROM SanPham
ORDER BY NgaySanXuat DESC;

CREATE PROCEDURE SP_Them_LoaiSP
    @MaLoaiSP VARCHAR(10),
    @TenLoaiSP NVARCHAR(100)
AS
BEGIN
    INSERT INTO LoaiSanPham (MaLoaiSP, TenLoaiSP)
    VALUES (@MaLoaiSP, @TenLoaiSP);
END;

CREATE PROCEDURE SP_Them_NCTN
    @MaNCTN INT,
    @TenNCTN NVARCHAR(100)
AS
BEGIN
    INSERT INTO NguoiChiuTrachNhiem (MaNCTN, TenNCTN)
    VALUES (@MaNCTN, @TenNCTN);
END;

CREATE PROCEDURE SP_Them_SanPham
    @MaSP VARCHAR(10),
    @NgaySanXuat DATE,
    @MaLoaiSP VARCHAR(10),
    @MaNCTN INT
AS
BEGIN
    INSERT INTO SanPham (MaSP, NgaySanXuat, MaLoaiSP, MaNCTN)
    VALUES (@MaSP, @NgaySanXuat, @MaLoaiSP, @MaNCTN);
END;

CREATE PROCEDURE SP_Xoa_SanPham
    @MaSP VARCHAR(10)
AS
BEGIN
    DELETE FROM SanPham
    WHERE MaSP = @MaSP;
END;

CREATE PROCEDURE SP_Xoa_SanPham_TheoLoai
    @MaLoaiSP VARCHAR(10)
AS
BEGIN
    DELETE FROM SanPham
    WHERE MaLoaiSP = @MaLoaiSP;
END;
