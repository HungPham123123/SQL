CREATE TABLE DonDatHang (
    MaSoDonHang INT PRIMARY KEY,
    NguoiDatHang NVARCHAR(50),
    DiaChi NVARCHAR(100),
    DienThoai NVARCHAR(20),
    NgayDatHang DATE
);

CREATE TABLE DanhSachMatHang (
    STT INT,
    TenHang NVARCHAR(50),
    MoTa NVARCHAR(100),
    DonVi NVARCHAR(20),
    Gia INT,
    SoLuong INT,
    ThanhTien INT,
    MaSoDonHang INT,
    FOREIGN KEY (MaSoDonHang) REFERENCES DonDatHang(MaSoDonHang)
);


INSERT INTO DonDatHang (MaSoDonHang, NguoiDatHang, DiaChi, DienThoai, NgayDatHang)
VALUES (123, N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '987654321', '2009-09-18');

INSERT INTO DanhSachMatHang (STT, TenHang, MoTa, DonVi, Gia, SoLuong, ThanhTien, MaSoDonHang)
VALUES (1, N'Máy Tính T450', N'Máy nhập mới', N'Chiếc', 1000, 1, 1000, 123);

INSERT INTO DanhSachMatHang (STT, TenHang, MoTa, DonVi, Gia, SoLuong, ThanhTien, MaSoDonHang)
VALUES (2, N'Điện Thoại Nokia5670', N'Điện thoại đang hot', N'Chiếc', 200, 2, 400, 123);

INSERT INTO DanhSachMatHang (STT, TenHang, MoTa, DonVi, Gia, SoLuong, ThanhTien, MaSoDonHang)
VALUES (3, N'Máy In Samsung 450', N'Máy in đang ế', N'Chiếc', 100, 1, 100, 123);



SELECT NguoiDatHang
FROM DonDatHang;

SELECT TenHang
FROM DanhSachMatHang;

SELECT *
FROM DonDatHang;

SELECT NguoiDatHang
FROM DonDatHang
ORDER BY NguoiDatHang ASC;

SELECT TenHang
FROM DanhSachMatHang
ORDER BY Gia DESC;

SELECT TenHang
FROM DanhSachMatHang
WHERE MaSoDonHang IN (
    SELECT MaSoDonHang
    FROM DonDatHang
    WHERE NguoiDatHang = N'Nguyễn Văn An'
);

SELECT COUNT(DISTINCT NguoiDatHang) AS SoKhachHang
FROM DonDatHang;

SELECT COUNT(*) AS SoMatHang
FROM DanhSachMatHang;

SELECT MaSoDonHang, SUM(ThanhTien) AS TongTien
FROM DanhSachMatHang
GROUP BY MaSoDonHang;

UPDATE DanhSachMatHang
SET Gia = ABS(Gia)
WHERE Gia < 0;

UPDATE DonDatHang
SET NgayDatHang = GETDATE()
WHERE NgayDatHang > GETDATE();

UPDATE DonDatHang
SET NgayDatHang = GETDATE()
WHERE NgayDatHang > GETDATE();

