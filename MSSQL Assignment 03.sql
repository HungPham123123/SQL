CREATE TABLE ThongTinKhachHang (
    MaKhachHang INT PRIMARY KEY IDENTITY,
    TenKhachHang NVARCHAR(100) NOT NULL,
    SoCMTND NVARCHAR(20) NOT NULL,
    DiaChi NVARCHAR(100) NOT NULL
);

CREATE TABLE ThueBao (
    MaThueBao INT PRIMARY KEY IDENTITY,
    MaKhachHang INT NOT NULL,
    SoDienThoai NVARCHAR(20) NOT NULL,
    LoaiThueBao NVARCHAR(50) NOT NULL,
    NgayDangKy DATE NOT NULL
);

INSERT INTO ThongTinKhachHang (TenKhachHang, SoCMTND, DiaChi)
VALUES ('Nguyễn Nguyệt Nga', '123456789', 'Hà Nội');

INSERT INTO ThueBao (MaKhachHang, SoDienThoai, LoaiThueBao, NgayDangKy)
VALUES (1, '123456789', 'Trả trước', '2002-12-12');


-- 4. Viết các câu lênh truy vấn để
SELECT * FROM ThongTinKhachHang

SELECT * FROM ThueBao

-- 5. Viết các câu lệnh truy vấn để lấy

SELECT SoDienThoai FROM ThueBao WHERE SoDienThoai = 0123456789
	
SELECT * FROM ThongTinKhachHang WHERE SoCMTND = 123456789

SELECT SoDienThoai FROM ThueBao, ThongTinKhachHang WHERE SoCMTND = 123456789

SELECT * FROM ThueBao WHERE NgayDangKy = '12-12-09'

SELECT * FROM ThueBao WHERE MaKhachHang IN (SELECT MaKhachHang FROM ThongTinKhachHang WHERE DiaChi = 'Hà Nội');

SELECT COUNT (*) AS TongKhachHang FROM ThongTinKhachHang

SELECT COUNT (*) AS TongThueBao FROM ThueBao

SELECT COUNT (*) AS TongThueBao FROM ThueBao WHERE NgayDangKy = '12-12-09'

SELECT * FROM ThueBao AS T
INNER JOIN ThongTinKhachHang AS K ON T.MaKhachHang = K.MaKhachHang;


ALTER TABLE ThueBao
ALTER COLUMN NgayDangKy DATE NOT NULL;

ALTER TABLE ThueBao
ADD CONSTRAINT CHK_NgayDangKy CHECK (NgayDangKy <= GETDATE());

ALTER TABLE ThueBao
ADD CONSTRAINT CHK_SoDienThoai CHECK (SoDienThoai LIKE '09%');

ALTER TABLE ThueBao
ADD SoDiemThuong INT;

CREATE INDEX IDX_TenKhachHang
ON ThongTinKhachHang (TenKhachHang);



CREATE VIEW View_KhachHangs AS
SELECT MaKhachHang, TenKhachHang, DiaChi
FROM ThongTinKhachHang;

CREATE VIEW View_KhachHang_ThueBao AS
SELECT K.MaKhachHang, K.TenKhachHang, T.SoDienThoai
FROM ThueBao AS T
INNER JOIN ThongTinKhachHang AS K ON T.MaKhachHang = K.MaKhachHang;



CREATE PROCEDURE SP_TimKH_ThueBao
    @SoDienThoai NVARCHAR(20)
AS
BEGIN
    SELECT *
    FROM ThongTinKhachHang AS K
    INNER JOIN ThueBao AS T ON K.MaKhachHang = T.MaKhachHang
    WHERE T.SoDienThoai = @SoDienThoai;
END;

CREATE PROCEDURE SP_TimTB_KhachHang
    @TenKhachHang NVARCHAR(100)
AS
BEGIN
    SELECT T.SoDienThoai
    FROM ThueBao AS T
    INNER JOIN ThongTinKhachHang AS K ON T.MaKhachHang = K.MaKhachHang
    WHERE K.TenKhachHang = @TenKhachHang;
END;

CREATE PROCEDURE SP_ThemTB
    @MaKhachHang INT,
    @SoDienThoai NVARCHAR(20),
    @LoaiThueBao NVARCHAR(50),
    @NgayDangKy DATE
AS
BEGIN
    INSERT INTO ThueBao (MaKhachHang, SoDienThoai, LoaiThueBao, NgayDangKy)
    VALUES (@MaKhachHang, @SoDienThoai, @LoaiThueBao, @NgayDangKy);
END;

CREATE PROCEDURE SP_HuyTB_MaKH
    @MaKhachHang INT
AS
BEGIN
    DELETE FROM ThueBao
    WHERE MaKhachHang = @MaKhachHang;
END;

