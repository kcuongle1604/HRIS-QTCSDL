use NhanSu
-----------------------------------TẠO BẢNG------------------------------
USE master;  
GO  
IF DB_ID (N'NhanSu') IS NOT NULL  
DROP DATABASE NhanSu;  
GO  
CREATE DATABASE NhanSu
go
use NhanSu
go

--1. Tạo bảng Chức vụ
CREATE TABLE ChucVu
(	
	MaChucVu CHAR(6) PRIMARY KEY NOT NULL,
	TenChucVu NVARCHAR(30) NOT NULL,
	HeSoLuong NUMERIC(4,2) NOT NULL,
	PhuCap NUMERIC(15,3) NOT NULL
)
go
--2. Tạo bảng Phòng ban
CREATE TABLE PhongBan
(	
	MaPhongBan CHAR(6) PRIMARY KEY NOT NULL,
	TenPhongBan NVARCHAR(30) NOT NULL,
	SDT CHAR(10) UNIQUE NOT NULL
)
go
--3. Tạo bảng Nhân viên
CREATE TABLE NhanVien
(	
	MaNhanVien CHAR(6) PRIMARY KEY NOT NULL, 
	Ho NVARCHAR(50) NOT NULL,
	Ten NVARCHAR(50) NOT NULL,
	MatKhau VARCHAR(50) NOT NULL,
	NgaySinh DATE NOT NULL,
	GioiTinh BIT NOT NULL,
	SDT CHAR(10) NOT NULL,
	DiaChi NVARCHAR(50) NOT NULL,
	Email VARCHAR(50) UNIQUE NOT NULL,
	LuongCoBan NUMERIC(15,3) NOT NULL,
	NgayNhanViec DATE NOT NULL,
	TrangThaiLamViec BIT NOT NULL,
	STK VARCHAR(50) UNIQUE NOT NULL,
	MaChucVu CHAR(6) NOT NULL,
	MaPhongBan CHAR(6) NOT NULL,
	CONSTRAINT FK_MaChucVu FOREIGN KEY (MaChucVu) REFERENCES ChucVu(MaChucVu),
	CONSTRAINT FK_MaPhongBan FOREIGN KEY (MaPhongBan) REFERENCES PhongBan(MaPhongBan)
)

--4. Tạo bảng Bằng cấp
CREATE TABLE BANGCAP 
(
	MaBangCap CHAR(6) PRIMARY KEY NOT NULL,
	TenBangCap NVARCHAR(100) NOT NULL,
	TrinhDo NVARCHAR(20) NOT NULL,
	DonViCap NVARCHAR(100) NOT NULL,
	MaNhanVien CHAR(6) NOT NULL,
	CONSTRAINT FK_MaNhanVienBC FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
)
go
--5. Tạo bảng Kỹ năng
CREATE TABLE KYNANG 
(
	MaKyNang CHAR(6) PRIMARY KEY NOT NULL,
	TenKyNang NVARCHAR(20) NOT NULL,
	TrinhDo NVARCHAR(20) NOT NULL,
	MaNhanVien CHAR(6) NOT NULL,
	CONSTRAINT FK_MaNhanVienKN FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
)
go
--6. Tạo bảng Chứng chỉ
CREATE TABLE CHUNGCHI 
(
	MaChungChi CHAR(6) PRIMARY KEY NOT NULL,
	TenChungChi NVARCHAR(20) NOT NULL,
	HanSDChungChi DATE NOT NULL, 
	MaNhanVien CHAR(6) NOT NULL,
	CONSTRAINT FK_MaNhanVienCC FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
)
go
--7. Tạo bảng Đánh giá năng lực
Create table DanhGiaNangLuc
(
	MaDanhGia CHAR(6) primary key not null,
	Ngay Date not null,
	NoiDung NVarchar(200) not null,
	KetQua INT not null,			--0: tốt, 1: khá, 2: chưa đạt
	MaNhanVien CHAR(6) NOT NULL,
	CONSTRAINT FK_MaNhanVienDGNL FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
)
go
--8. Tạo bảng Công việc
Create table CongViec
(
	MaCongViec CHAR(6) primary key not null,
	TenCongViec nvarchar(50) not null,
	MoTa nvarchar(100),
	ƯuTien INT not null,			--0: nghiêm trọng, 1: cao, 2: trung bình, 3: thấp
	NgayBatDau Date not null,
	NgayKetThuc Date not null,
	TrangThaiCV bit not null		--0: chưa hoàn thành, 1: đã hoàn thành
)
go
--8. Tạo bảng Công việc_ Báo cáo
Create table CongViec_BaoCao
(
	MaBaoCao char(8) not null primary key,
	MaNhanVien CHAR(6) not null,
	MaCongViec CHAR(6) not null,
	NoiDung Nvarchar(200) not null,
	ThoiGianLap datetime not null,
	CONSTRAINT FK_MaNhanVienCV FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
	Constraint FK_MaCongViec Foreign key (MaCongViec) references CongViec(MaCongViec)
)
go 
--10. Tạo bảng Lương
CREATE TABLE BangLuong 
(
    MaLuong CHAR(7) PRIMARY KEY NOT NULL,
    Thang INT NOT NULL,
    Nam INT NOT NULL,
    Thuong NUMERIC(10,3) NULL,
    MaNhanVien CHAR(6) NOT NULL,
    CONSTRAINT FK_MaNhanVienLuong FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
)
go
--11. Tạo bảng Lỗi phạt
CREATE TABLE LoiPhat 
(
    MaLoi CHAR(6) PRIMARY KEY NOT NULL,      
    TenLoi NVARCHAR(20) NOT NULL,              
    TienPhat NUMERIC(12,3) NOT NULL,                
    MaLuong CHAR(7) NOT NULL,                   
    CONSTRAINT FK_MaLuong FOREIGN KEY (MaLuong) REFERENCES BangLuong(MaLuong) 
)
go
--12. Tạo bảng Chấm công
CREATE TABLE ChamCong 
(  
    MaCong CHAR(11) PRIMARY KEY NOT NULL,  
    NgayCong DATE NOT NULL,  
    GioVao TIME NOT NULL,  
    GioRa TIME NOT NULL,  
    LoaiCong BIT NOT NULL,  
    MaNhanVien CHAR(6) NOT NULL  
    CONSTRAINT FK_NhanVienCong FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien) -- Khóa ngoại tham chiếu đến bảng NhanVien  
)
go
--13. Tạo bảng Nghỉ phép
CREATE TABLE NghiPhep 
(  
    MaNghi CHAR(6) PRIMARY KEY NOT NULL,  
    NgayNghi DATE NOT NULL,            
    LoaiNghi BIT NOT NULL,             -- Loại nghỉ: 1 nghỉ phép, 0 nghỉ không phép  
    MaNhanVien CHAR(6) NOT NULL,  
    CONSTRAINT FK_NhanVienNghi FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien) -- Khóa ngoại tham chiếu đến bảng NhanVien  
)
go

----------------------------DUMP DATA------------------------------

--Dump data Phong Ban
go
CREATE proc sp_InsertRandom_PhongBan
as
begin
	declare @i int =1;
	while @i <=1000
	begin
		insert into PhongBan (MaPhongBan, TenPhongBan, SDT)
		values (
				'PB' + right('0000' + cast(@i as varchar),4),
				N'Phòng ban ' + cast (@i as nvarchar),
				CASE FLOOR(RAND() * 5)
                     WHEN 0 THEN '09' + RIGHT(CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)), 8)
                     WHEN 1 THEN '08' + RIGHT(CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)), 8)
                     WHEN 2 THEN '07' + RIGHT(CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)), 8)
                     WHEN 3 THEN '05' + RIGHT(CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)), 8)
                     ELSE '03' + RIGHT(CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)), 8)
                END
				);
				set @i=@i+1
	end
end
go
exec sp_InsertRandom_PhongBan
select * from PhongBan

--Dump data Chức vụ
GO
CREATE PROC sp_InsertRandom_ChucVu
AS
BEGIN
    DECLARE @i INT = 1;

    WHILE @i <= 1000
    BEGIN
        INSERT INTO ChucVu (MaChucVu, TenChucVu, HeSoLuong, PhuCap)
        VALUES (
				'CV' + RIGHT('0000' + cast(@i as varchar), 4),
				N'Chức vụ ' + CAST(@i as NVARCHAR),
				ROUND(RAND() * 4 + 1, 2),
				ROUND(RAND() * 900000 + 100000, 3)
				);
        SET @i = @i + 1;
    END
END;

EXEC sp_InsertRandom_ChucVu
SELECT * FROM ChucVu
--Dump data Nhân viên
go
create proc sp_InsertRandom_NhanVien
as
begin
	declare @i int = 1001;
	declare @MaChucVu char(6), @MaPhongBan char(6)
	while @i <= 10
	begin
		set @MaChucVu = (SELECT TOP 1 MaChucVu 
						FROM ChucVu 
						ORDER BY NEWID())
		set @MaPhongBan = (SELECT TOP 1 MaPhongBan 
							FROM PhongBan 
							ORDER BY NEWID())
		insert into NhanVien(MaNhanVien, Ho, Ten, MatKhau, NgaySinh, GioiTinh, SDT, DiaChi, Email, LuongCoBan, NgayNhanViec, TrangThaiLamViec, STK, MaChucVu, MaPhongBan)
		values (
				'NV' + RIGHT('0000' + CONVERT(VARCHAR, @i), 4),
				N'Họ ' + cast(@i as nvarchar),
				N'Tên ' + cast(@i as nvarchar),
				'MK' + RIGHT('000' + CONVERT(VARCHAR, @i), 4),
				DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 7300), '1980-01-01'),
				FLOOR(RAND() * 2) ,
				CASE floor(rand()*5)
					WHEN 0 THEN '09' + RIGHT(CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)), 8)
					WHEN 1 THEN '08' + RIGHT(CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)), 8)
					WHEN 2 THEN '07' + RIGHT(CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)), 8)
					WHEN 3 THEN '05' + RIGHT(CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)), 8)
					ELSE '03' + RIGHT(CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)), 8)
				END,
				N'Địa chỉ ' + cast (@i as nvarchar),
				'NV' + RIGHT('0000' + CONVERT(VARCHAR, @i), 4) +'@gmail.com',
				ROUND(RAND() * 20000000 + 5000000, 3),
				DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 1460), '2020-01-01'),
				FLOOR(RAND() * 2),
				'STK' + RIGHT(CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(50)), 10),
				@MaChucVu,
				@MaPhongBan
				)
		SET @i = @i + 1;
	end
end

EXEC sp_InsertRandom_NhanVien
SELECT * FROM NhanVien


--dump Bang cap
go
CREATE PROCEDURE sp_InsertRandomBangCap 
AS
BEGIN
    DECLARE @i INT = 1
    DECLARE @MaBangCap CHAR(6)
    DECLARE @TenBangCap NVARCHAR(100)
    DECLARE @TrinhDo NVARCHAR(30)
    DECLARE @DonViCap NVARCHAR(100)
    DECLARE @MaNhanVien CHAR(6)

    WHILE @i <= 1000
    BEGIN
        SET @MaBangCap = 'B' + RIGHT(REPLICATE('0', 5) + CAST(@i AS VARCHAR(5)), 5);

        SET @TenBangCap = N'Tên ' + CAST(@i AS NVARCHAR(10));

        SET @TrinhDo = N'Trình độ '+CAST(@i AS NVARCHAR(10));

        SET @DonViCap = N'Đơn vị ' + CAST(@i AS NVARCHAR(10));
		
        SET @MaNhanVien = (SELECT TOP 1 MaNhanVien FROM NhanVien ORDER BY NEWID())

        INSERT INTO BANGCAP (MaBangCap, TenBangCap, TrinhDo, DonViCap, MaNhanVien)
        VALUES (@MaBangCap, @TenBangCap, @TrinhDo, @DonViCap, @MaNhanVien);

        SET @i = @i + 1;
    END
END
go
exec sp_InsertRandomBangCap 
select * from BangCap

----Bảng Kỹ năng-----
go
CREATE PROC sp_InsertRandomKyNang
AS
BEGIN
    DECLARE @count INT = 1;
    DECLARE @MaKyNang CHAR(6);
    DECLARE @TenKyNang NVARCHAR(100);
    DECLARE @TrinhDo NVARCHAR(30);
    DECLARE @MaNhanVien CHAR(6);

    WHILE @count <= 1000
    BEGIN
       
        SET @MaKyNang = 'K' + RIGHT(REPLICATE('0', 5) + CAST(@count AS VARCHAR(5)), 5);

        SET @TenKyNang = N'Kỹ Năng ' + CAST(@count AS NVARCHAR(10));

        SET @TrinhDo = N'Trình độ ' + CAST(@count AS NVARCHAR(10));

        SET @MaNhanVien = (SELECT TOP 1 MaNhanVien FROM NhanVien ORDER BY NEWID())

        INSERT INTO KYNANG (MaKyNang, TenKyNang, TrinhDo, MaNhanVien)
        VALUES (@MaKyNang, @TenKyNang, @TrinhDo, @MaNhanVien);


        SET @count = @count + 1;
    END
END
go
exec sp_InsertRandomKyNang
select * from KyNang


--Bảng Chứng chỉ----
go
create PROC sp_InsertRandomChungChi
AS
BEGIN
    DECLARE @i INT = 1
    DECLARE @MaChungChi CHAR(6);
    DECLARE @TenChungChi NVARCHAR(50)
    DECLARE @HanSDChungChi DATE
    DECLARE @MaNhanVien CHAR(6)

    WHILE @i <= 1000
    BEGIN
      
        SET @MaChungChi = 'C' + RIGHT(REPLICATE('0', 5) + CAST(@i AS VARCHAR(5)), 5);

        SET @TenChungChi = N'Chứng chỉ ' + CAST(@i AS NVARCHAR(10));

        SET @HanSDChungChi =  DATEADD(YEAR, CAST(RAND() * 5 + 1 AS INT), GETDATE())

        SET @MaNhanVien = (SELECT TOP 1 MaNhanVien FROM NhanVien ORDER BY NEWID())

        INSERT INTO CHUNGCHI (MaChungChi, TenChungChi, HanSDChungChi, MaNhanVien)
        VALUES (@MaChungChi, @TenChungChi, @HanSDChungChi, @MaNhanVien);

		IF @@ROWCOUNT <= 0
        BEGIN
            PRINT N'Không thành công'
            RETURN
        END
    

        SET @i = @i + 1
    END
END
go

exec sp_InsertRandomChungChi
select * from ChungChi
------------------------------CongViec-------------------------------------------------------------------------
go
CREATE proc sp_InsertRandom_CongViec
as
Begin
    Declare @i int = 1,@MaCongViec char(6),@TenCongViec nvarchar(50),
			@MoTa nvarchar(100),@ƯuTien int,@NgayBatDau date,
			@NgayKetThuc date,@TrangThaiCV bit
    While @i <= 1000
    Begin
        Set @MaCongViec = 'C' + right('00000' + cast(@i as varchar(5)), 5)
        Set @TenCongViec = CONCAT(N'Công việc',@i )
        Set @MoTa = CONCAT(N'Mô tả cho công việc ', @i)
        Set @ƯuTien = Floor(Rand() * 4) --0: nghiêm trọng, 1: cao, 2: trung bình, 3: thấp
        Set @NgayBatDau = DATEADD(DAY, FLOOR(RAND() * 365), CAST(FLOOR(RAND() * 5 + 2019) AS VARCHAR) + '-01-01')
        Set @NgayKetThuc = Dateadd(Day, Floor(Rand() * 100) + 1, @NgayBatDau)
        Set @TrangThaiCV = Floor(Rand() * 2) --0: chưa hoàn thành, 1: đã hoàn thành

        Insert into CongViec (MaCongViec, TenCongViec, MoTa, ƯuTien, NgayBatDau, NgayKetThuc, TrangThaiCV)
        Values (@MaCongViec, @TenCongViec, @MoTa, @ƯuTien, @NgayBatDau, @NgayKetThuc, @TrangThaiCV)

        set @i = @i + 1
    end
end
go
Exec sp_InsertRandom_CongViec
Select*from CongViec
----------------------------------DanhGiaNangLuc-------------------------------------------------------------------
go
CREATE proc sp_InsertRandom_Danhgianangluc
as
begin
    Declare @i int = 1,
            @MaDanhGia char(6),
            @Ngay Date,
            @NoiDung nvarchar(200),
            @KetQua int,
            @MaNhanVien Char(6)

    While @i <= 1000
    Begin
        Set @MaDanhGia = 'DG' + RIGHT('0000' + Cast(@i as Varchar(4)), 4)
		Set @Ngay = DATEADD(DAY, FLOOR(RAND() * 365), CAST(FLOOR(RAND() * 5 + 2019) AS VARCHAR) + '-01-01')
        SET @NoiDung = CONCAT(N'Nội dung đánh giá cho nhân viên ', @i)
        SET @KetQua = Floor(Rand() * 3); -- 0: tốt, 1: khá, 2: chưa đạt
        Select top 1 @MaNhanVien = MaNhanVien 
        FROM NhanVien
        Order by Newid()
        Insert into DanhGiaNangLuc (MaDanhGia, Ngay, NoiDung, KetQua, MaNhanVien)
        Values (@MaDanhGia, @Ngay, @NoiDung, @KetQua, @MaNhanVien);

        Set @i = @i + 1;
    End
End
go
Exec sp_InsertRandom_Danhgianangluc
Select *from DanhGiaNangLuc

------------------------------CongViec_BaoCao------------------------------------------------------------------
go
CREATE Proc sp_InsertRandomCongViec_BaoCao
as
begin
    Declare @i int = 1, @MaBaoCao char(8),
            @MaNhanVien char(6),
            @MaCongViec char(6),
            @NoiDung nvarchar(200),
            @ThoiGianLap Datetime,
			@NgayBatDau Date,
            @NgayKetThuc Date,
			@Songayngaunhien int,
			@Gio int,@Phut int,@Giay int

    While @i <= 1000
    Begin
        Set @MaBaoCao = 'BCA' + right('00000' + cast(@i as nvarchar(5)), 5)
        Select top 1 @MaNhanVien = MaNhanVien 
        From NhanVien
        Order by newid()
        Select top 1	@MaCongViec = MaCongViec, 
						@NgayBatDau = NgayBatDau, 
						@NgayKetThuc = NgayKetThuc
        From CongViec
        Order by newid()

        Set @NoiDung = CONCAT(N'Nội dung báo cáo cho công việc ', @i)
		Set @NgayKetThuc = Dateadd(Day, -1, @NgayKetThuc)
		Set @Songayngaunhien = Floor(Rand() * (Datediff(Day, @NgayBatDau, @NgayKetThuc) + 1))
		Set @ThoiGianLap = Dateadd(Day, @Songayngaunhien, @NgayBatDau)
		Set @Gio=Floor(Rand()*24)
		Set @Phut=Floor(Rand()*60)
		Set @Giay=Floor(Rand()*60)
		Set @ThoiGianLap = Dateadd(Second, @Giay, Dateadd(Minute, @Phut, Dateadd(Hour, @Gio, @ThoiGianLap)))

        Insert into CongViec_BaoCao (MaBaoCao, MaNhanVien, MaCongViec, NoiDung, ThoiGianLap)
        Values (@MaBaoCao, @MaNhanVien, @MaCongViec, @NoiDung, @ThoiGianLap)

        Set @i = @i + 1;
    end
end
go
Exec sp_InsertRandomCongViec_BaoCao
Select*from CongViec_BaoCao

-- Dump Data Vào bảng chấm công
go
CREATE PROC sp_InsertRandom_ChamCong
AS
BEGIN
 --nếu nhân viên nghỉ ngày đó trong bảng nghỉ phép mà bên này vẫn hiện đi làm thì sao?
	DECLARE @i int = 1
	WHILE @i <= 1000
	BEGIN
		INSERT INTO ChamCong (MaCong, NgayCong, GioVao, GioRa, LoaiCong, MaNhanVien)
		VALUES(
				'MC' + RIGHT('000000000' + CAST(@i AS VARCHAR(9)), 9),
				DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, CAST(GETDATE() AS DATE)),
				-- Tạo GioVao ngẫu nhiên từ 6:00 đến 10:00
				CAST(
					CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 4 + 6) AS VARCHAR(2)) + ':' +
					RIGHT('00' + CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 60) AS VARCHAR(2)), 2) + ':00'
				AS TIME),

				-- Tạo GioRa ngẫu nhiên từ 16:00 đến 21:00 
				CAST(
					CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 5 + 16) AS VARCHAR(2)) + ':' +
					RIGHT('00' + CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 60) AS VARCHAR(2)), 2) + ':00'
				AS TIME),
				-- Tạo LoaiCong ngẫu nhiên 0 hoặc 1
				FLOOR(RAND() * 2),
				-- Chọn MaNhanVien ngẫu nhiên từ bảng NhanVien
				(
					SELECT TOP 1 MaNhanVien 
					FROM NhanVien 
					ORDER BY NEWID()
				)
			)
		SET @i = @i +1
	END
END
go
EXEC sp_InsertRandom_ChamCong
SELECT * FROM ChamCong

--2. Dump Data vào bảng Nghỉ Phép
go
create PROC sp_InsertRandom_NghiPhep
AS
BEGIN
	DECLARE @i int = 1
	WHILE @i <= 1000
	BEGIN
		INSERT INTO NghiPhep (MaNghi, NgayNghi, LoaiNghi, MaNhanVien)
		VALUES(
				-- Tạo MaNghi duy nhất bằng cách tăng từ @MaxNumber
				'MN' + RIGHT('0000' + CAST(@i AS VARCHAR(4)), 4),

				-- Tạo NgayNghi ngẫu nhiên trong vòng 365 ngày trước
				DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, CAST(GETDATE() AS DATE)),

				-- Tạo LoaiNghi ngẫu nhiên 0 hoặc 1
				FLOOR(RAND() * 2),

				-- Chọn MaNhanVien ngẫu nhiên từ bảng NhanVien
				(
					SELECT TOP 1 MaNhanVien 
					FROM NhanVien 
					ORDER BY NEWID()
				)
			)
		SET @i = @i +1
    END
END
GO
drop proc sp_InsertRandom_NghiPhep
delete from NghiPhep
EXEC sp_InsertRandom_NghiPhep
select * from NghiPhep

--- DUMP BẢNG LƯƠNG ---
go
create PROC sp_InsertRandom_Luong
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @MaLuong VARCHAR(7);
    DECLARE @Thang INT;
    DECLARE @Nam INT;
    DECLARE @Thuong NUMERIC(10, 3);
    DECLARE @MaNhanVien CHAR(6);

    WHILE @i <= 1000
    BEGIN 
        SET @MaLuong = RIGHT('000000' + CAST(@i AS VARCHAR(7)), 7); 
        SET @Thang = (@i % 12) + 1; 
        SET @Nam = FLOOR(RAND() * 5) + 2019;  
        SET @Thuong = ROUND(RAND() * (1000000 - 100000) + 1000, 3)

        SET @MaNhanVien = (SELECT TOP 1 MaNhanVien FROM NhanVien ORDER BY NEWID());

        INSERT INTO Luong (MaLuong, Thang, Nam, Thuong, MaNhanVien)
        VALUES (@MaLuong, @Thang, @Nam, @Thuong, @MaNhanVien);

        SET @i = @i + 1; 
    END
END;


Exec sp_InsertRandom_Luong
Select *from Luong


delete from Luong
delete from LoiPhat

--- DUMP BẢNG LỖI PHẠT ---
  
go
create PROC sp_InsertRandomLoiPhat
AS
BEGIN
    DECLARE @i INT = 1;

    WHILE @i <= 1000
    BEGIN
        INSERT INTO LoiPhat (MaLoi, TenLoi, TienPhat, MaLuong)
        VALUES (
            'L' + RIGHT(CONCAT('0000', @i), 5),  
            CONCAT(N'Lỗi ', @i),  
            ROUND(RAND() * (1000000 - 100000) + 1000, 3),  
			(
			SELECT TOP 1 MaLuong
			FROM Luong 
			ORDER BY NEWID()
			)
        );
        SET @i = @i + 1;
    END;
END;

exec sp_InsertRandomLoiPhat
select * from LoiPhat


-------------------------MODULE----------------------

/*1. Khi thực hiện xóa thông tin nhân viên khỏi bảng NhanVien. 
Hãy đổi trạng thái làm việc của Nhân viên thành 0 (đã nghỉ việc) thay vì xóa.*/
go
Create trigger t_UptTrangThaiLamViec
On NhanVien
Instead of delete
As
Begin
	Declare @MaNhanVien  CHAR(6)

	Select @MaNhanVien = MaNhanVien from deleted

	Update NhanVien
	Set TrangThaiLamViec = '0'
	Where MaNhanVien = @MaNhanVien
End
	
--test
delete from NhanVien
where MaNhanVien='NV0001'

select * from NhanVien

/*2. Khi thêm mới dữ liệu bảng CongViec_BaoCao, hãy kiểm tra tính hợp lệ của cột ThoiGianLap. 
	Nếu ThoiGianLap không nằm trong NgayBatDau và NgayKetThuc của CongViec 
	thì Thông báo lỗi ThoiGianLap không hợp lệ và hủy bỏ toàn bộ thao tác.*/
go
create trigger t_CheckThoiGianLapBC
ON CongViec_BaoCao
After Insert
As
Begin
	Declare @ThoiGianLap DateTime,@MaCongViec Char(6)
	Select @ThoiGianLap=cast(ThoiGianLap as date), @MaCongViec=MaCongViec
	from inserted
	Declare @NgayBatDau Date,@NgayKetthuc Date 
	Select @NgayBatDau=NgayBatDau, @NgayKetthuc=NgayKetThuc
	from CongViec
	Where MaCongViec=@MaCongViec

	If  not (@ThoiGianLap between @NgayBatDau and @NgayKetThuc)
	Begin
		Print N'Thời gian lập không hợp lệ'
		Rollback
	End
End

--test
insert into CongViec_BaoCao values ('BCA01001','NV0001','C00069',N'Nội dung báo cáo cho công việc 11','2019-07-01 10:00')

select * from CongViec_BaoCao
select * from CongViec
where MaCongViec='C00069'
/*3. In ra danh sách nhân viên có ngày công trùng với ngày nghỉ phép, 
	với các cột sau: Mã nhân viên, tên nhân viên, ngày công, ngày nghỉ phép, loại nghỉ. */
go
create proc sp_CongTrungNghi
As
Begin
	Select	NhanVien.MaNhanVien,
			NhanVien.Ten,
			ChamCong.NgayCong, 
			Chamcong.MaCong,
			NghiPhep.MaNghi, 
			NghiPhep.NgayNghi,
			NghiPhep.LoaiNghi
	From NhanVien	Join ChamCong on NhanVien.MaNhanVien=ChamCong.MaNhanVien
					join NghiPhep on NhanVien.MaNhanVien=NghiPhep.MaNhanVien
	Where ChamCong.NgayCong=NghiPhep.NgayNghi
End
--test
exec sp_CongTrungNghi

/*5. Trả về danh sách nhân viên còn làm việc của một Phòng Ban nếu biết mã phòng ban.*/
go
create proc sp_DSNhanVienmotphongban (@MaPhongBan Char(6))
As
Begin 
	Declare @DanhSachNhanVien table (MaNhanVien char(6),
									Ho NVARCHAR(50),
									Ten NVARCHAR(50), 
									LuongCoBan NUMERIC(15,3), 
									TrangThaiLamViec BIT,
									MaPhongBan Char(6))
	insert into @DanhSachNhanVien

	Select MaNhanVien, Ho, Ten, LuongCoBan, TrangThaiLamViec, MaPhongBan
    From NhanVien
    Where NhanVien.MaPhongBan = @MaPhongBan and TrangThaiLamViec = 1
	Select * from @DanhSachNhanVien
End
--test
EXEC sp_DSNhanVienmotphongban 'PB0696'

/*6. Trả về danh sách nhân viên còn làm việc có cùng chức vụ*/
go
CREATE PROC sp_DsNhanVien_CungChucvu
(
    @MaChucVu char(6)
)
AS
BEGIN
        -- Lấy danh sách nhân viên có cùng chức vụ
        SELECT MaChucVu,MaNhanVien, Ho, Ten, NgaySinh, GioiTinh, SDT, DiaChi, Email, LuongCoBan, NgayNhanViec, TrangThaiLamViec, STK, MaPhongBan
        FROM NhanVien
        WHERE MaChucVu = @MaChucVu and TrangThaiLamViec = 1
END
GO
--test
exec sp_DsNhanVien_CungChucvu 'CV0002'
select * from ChucVu join NhanVien on ChucVu.MaChucVu= NhanVien.MaChucVu

/*6. Thêm một nhân viên mới vào bảng NhanVien nếu biết các thông tin về 
	Họ, Tên, Ngày sinh, Giới tính, SĐT, Địa chỉ, Email, Lương cơ bản, Ngày nhận viện, 
	Trạng thái làm việc, Số tài khoản, Mã Chức Vụ, Mã Phòng Ban. Công việc cần làm bao gồm:
	a.	Kiểm tra Họ, Tên, Số điện thoại đã có trong bảng Nhân viên chưa. 
	Nếu rồi thì thông báo “Đã tồn tại nhân viên” và ngừng xử lý.
	b. Kiểm tra Mã chức vụ có tồn tại trong bảng Chức vụ không. 
	Nếu không hãy đưa ra thông báo “Mã chức vụ không tồn tại” và ngừng xử lý.
	c. Kiểm tra Mã phòng ban có tồn tại trong bảng Phòng ban không. 
	Nếu không hãy đưa ra thông báo “Mã phòng ban không tồn tại” và ngừng xử lý.
	d.	Kiểm tra Email nhập phải đúng định dạng. 
	Nếu không hãy đưa ra thông báo “Email sai định dạng” và ngừng xử lý.
	e.	Tính Mã nhân viên mới. Mã nhân viên tiếp theo được tính như sau: 
	MAX(mã nhân viên đang có) + 1. Hãy đảm bảo số lượng ký tự luôn đúng với quy định về mã nhân viên.
	f.	Thêm mới bản ghi vào bảng NhanVien
*/
go
create PROC spInsertNhanVien  @Ho NVARCHAR(50),
							 @Ten NVARCHAR(50),
							 @NgaySinh DATE, 
							 @GioiTinh BIT,
							 @SDT CHAR(10),
							 @DiaChi NVARCHAR(50),
							 @Email VARCHAR(50),
							 @LuongCoBan NUMERIC,
							 @NgayNhanViec DATE, 
							 @TrangThaiLamViec BIT,
							 @STK VARCHAR(50),
							 @MaChucVu CHAR(6),
							 @MaPhongBan CHAR(6),
							 @ret BIT output
AS
BEGIN
	DECLARE @newCust_id CHAR(6)
--	a. Kiểm tra Họ, Tên, Số điện thoại đã có trong bảng Nhân viên chưa. Nếu rồi thì thông báo “Đã tồn tại nhân viên” và ngừng xử lý.
	IF (SELECT count(*)
		FROM NhanVien 
		WHERE Ho = @Ho AND Ten = @Ten AND SDT = @SDT ) >= 1
	BEGIN 
		PRINT N'Đã tồn tại nhân viên'
		SET @ret = 0
		RETURN 
	END 

--	b. Kiểm tra Mã chức vụ có tồn tại trong bảng Chức vụ không. 
--	Nếu không hãy đưa ra thông báo “Mã chức vụ không tồn tại” và ngừng xử lý.
	IF @MaChucVu NOT IN (SELECT MaChucVu from ChucVu)
	BEGIN
		PRINT N'Mã chức vụ không tồn tại'
		SET @ret = 0
		RETURN
	END

--	c. Kiểm tra Mã phòng ban có tồn tại trong bảng Phòng Ban không.
--	Nếu không hãy đưa ra thông báo "Mã phòng ban không tồn tại" và ngừng xử lý
	if @MaPhongBan not in (SELECT MaPhongBan FROM PhongBan)
	BEGIN
		PRINT N' Mã phòng ban không tồn tại'
		SET @ret = 0
		RETURN
	END 

--	d. Kiểm tra Email nhập phải đúng định dạng. Nếu không hãy đưa ra thông báo “Email sai định dạng” và ngừng xử lý.
    IF @Email NOT LIKE '[a-zA-Z0-9]%[^.-_@]@gmail.com'
       OR @Email LIKE '%[^a-zA-Z0-9._-]@gmail.com'
       OR @Email LIKE '%.@%'
       OR @Email LIKE '%@_.%'
       OR @Email LIKE '%..%'
    BEGIN
        PRINT N'Email sai định dạng'
		SET @ret = 0
        RETURN 
    END

--	e. Tính Mã nhân viên mới. Mã nhân viên tiếp theo được tính như sau: 
--	MAX(mã nhân viên đang có) + 1. Hãy đảm bảo số lượng ký tự luôn đúng với quy định về mã nhân viên.
	DECLARE @maxCust_id CHAR(6)
	
	SELECT @maxCust_id = CAST(SUBSTRING(MAX(MaNhanVien), 3, 4) AS INT) FROM NhanVien

	SET @newCust_id = 'NV' + RIGHT('0000' + CAST(@maxCust_id + 1 AS CHAR(4)), 4)

--	f. Thêm mới bản ghi vào bảng NhanVien
	insert into NhanVien(MaNhanVien,Ho,Ten,NgaySinh,GioiTinh,SDT,DiaChi,Email,LuongCoBan,NgayNhanViec,TrangThaiLamViec,STK,MaChucVu,MaPhongBan)
	values (@newCust_id, @Ho, @Ten,@NgaySinh,@GioiTinh,@SDT,@DiaChi,@Email,@LuongCoBan,@NgayNhanViec,@TrangThaiLamViec,@STK, @MaChucVu, @MaPhongBan)

	if @@ROWCOUNT < 1
	begin
		print N'Insert không thành công'
		set @ret = 0
		return
	end
	else
	begin
		print N'Insert thành công'
		set @ret = 0
		return
	end
END
--test
declare @a bit
exec spInsertNhanVien 'Ten 10001', 'Ho10001', '1980-11-11',0,'0858453051','Địa chỉ 1','NV1001@gmail.com','7415103.047','2023-11-15',1,'STK2120041431','CV0190','PB0369',@a	--TH1: insert thanh cong
print @a
exec spInsertNhanVien 'Ten 10001', 'Ho10001', '1980-11-11',0,'0858453051','Địa chỉ 1','NV1001@gmail.com','7415103.047','2023-11-15',1,'STK2120041431','CV0190','PB0369',@a	--TH2: Ho, ten, sdt da ton tai
exec spInsertNhanVien 'Ten 10002', 'Ho10001', '1980-11-11',0,'0858453051','Địa chỉ 1','NV1001@gmail.com','7415103.047','2023-11-15',1,'STK2120041431','CV1001','PB0369',@a	--TH3: ma chuc vu khong ton tai
exec spInsertNhanVien 'Ten 10002', 'Ho10001', '1980-11-11',0,'0858453051','Địa chỉ 1','NV1001@gmail.com','7415103.047','2023-11-15',1,'STK2120041431','CV0190','PB1001',@a	--TH4: Ma phong ban khong ton tai
exec spInsertNhanVien 'Ten 10002', 'Ho10001', '1980-11-11',0,'0858453051','Địa chỉ 1','NV1001@@gmail.com','7415103.047','2023-11-15',1,'STK2120041431','CV0190','PB0369',@a--TH5: sai dinh dang email

/*7. Thêm mới dữ liệu trong Bảng ChamCong nếu biết các thông tin sau:
	mã công, ngày công, giờ vào, giờ ra, loại công, mã nhân viên. 
	Hãy thực hiện các công việc sau:
	a.	Tính mã chấm công mới với công thức MAX(mã chấm công đang có) + 1. Hãy đảm bảo số lượng ký tự luôn đúng với quy định về mã chấm công.
	b.	Kiểm tra ngày công nhập có lớn hơn ngày hiện tại không. Nếu có thì thông báo ‘Ngày công không hợp lệ’ và ngừng xử lí
	c.	Kiểm tra Mã nhân viên được nhập có tồn tại trong bảng NhanVien không. Nếu không hãy thông báo “Không tồn tại mã nhân viên” và hủy thao tác đã thực hiện.
	d.	Kiểm tra TrangThaiLamViec của Nhân viên. Nếu TrangThaiLamViec = 0 thì đưa ra thông báo ‘Nhân viên đã nghỉ việc’ và hủy thao tác đã thực hiện. 
	e.	Kiểm tra nếu GioRa nhỏ hơn GioVao thì đưa ra thông báo “Thời gian không hợp lệ” và hủy toàn bộ thao tác.
	f.	Thêm mới bảng ghi vào Bảng công với dữ liệu đã nhập
*/
go
create proc pr_Insert_ChamCong (@NgayCong date,
								@GioVao time,
								@GioRa time,
								@LoaiCong bit,
								@MaNhanVien char(6),
								@retval bit out)
as
begin
--Khai bao bien					
	declare @TrangThaiLamViec BIT,
			@TienPhat numeric

--Tính mã chấm công mới
	declare @ofc_CongID varchar(12)
	declare @max_CongID int
	set @max_CongID= (select right(max(MaCong),9) from ChamCong) + 1
	set @ofc_CongID='MC' + RIGHT('0000000000'+cast(@max_CongID as varchar(12)),9)

--Kiểm tra Ngày Công nhập vào có lớn hơn ngày hiện tại không
	if @NgayCong >= getdate()
	begin
		print N'Ngày công bị lỗi'
		set @retval = 0
		return
	end

--Kiem tra ma nhan vien co ton tai khong
	if @MaNhanVien not in (	select MaNhanVien from NhanVien)
	begin
		print N'Mã nhân viên không tồn tại'
		set @retval = 0
		return
	end

--Kiem tra trang thai lam viec cua nhan vien
	select @TrangThaiLamViec = TrangThaiLamViec from NhanVien 
	where MaNhanVien = @MaNhanVien

	if @TrangThaiLamViec = 0
	begin
		print N'Nhân viên đã nghỉ việc'
		set @retval = 0
		return
	end

--Kiểm tra nếu GioRa nhỏ hơn GioVao thì đưa ra thông báo “Thời gian không hợp lệ” và hủy toàn bộ thao tác.
	if @GioRa < @GioVao
	begin
		print N'Thời gian không hợp lệ'
		set @retval=0
		return
	end
--Thêm mới bảng ghi vào Bảng công với dữ liệu đã có
	insert into ChamCong(MaCong,NgayCong,GioVao,GioRa,LoaiCong,MaNhanVien)
	values (@ofc_CongID, @NgayCong, @GioVao, @GioRa,@LoaiCong, @MaNhanVien)

	if @@ROWCOUNT >=1
	begin
		print N'Insert thành công'
		set @retval = 1
	end
	else
	begin
		print N'Insert không thành công'
		set @retval = 0
	end
end
--test
declare @a bit
select * from NhanVien
exec pr_Insert_ChamCong '2024/10/14','08:00:00','09:00:00',1,'NV0000',@a --TH1: mã nhân viên không tồn tại
exec pr_Insert_ChamCong '2024/12/14','08:00:00','09:00:00',1,'NV0000',@a --TH2: Ngày công nhập lớn hơn ngày hiện tại
exec pr_Insert_ChamCong '2024/10/14','09:00:00','08:00:00',1,'NV0002',@a --TH3: giờ ra thấp hơn so với giờ vào 
exec pr_Insert_ChamCong '2024/10/14','08:00:00','09:00:00',1,'NV0001',@a --TH4: nhân viên đã nghỉ việc
exec pr_Insert_ChamCong '2024/10/14','08:00:00','21:00:00',1,'NV0002',@a --TH5: insert thành công
select * from NhanVien
select * from ChamCong
insert into ChamCong values('MC100000001','2024-07-11','08:00:00','21:00:00',0,'NV0002')

/*8. Thêm mới một bản ghi vào bảng CongViec nếu biết: 
	Tên Công việc, Mô tả, Ưu tiên,TrangthaiCV, Ngày bắt đầu, Ngày kết thúc.
	Hãy thực hiện những việc sau bao gồm những công việc sau:
	a. Kiểm tra Ngày bắt đầu và ngày kết thúc có hợp lệ không? 
	Nếu không, ngừng xử lý (Hợp lệ nếu Ngày bắt đầu không được lớn hơn hoặc bằng Ngày kết thúc và Ngày bắt đầu và Ngày kết thúc không nên là ngày đã qua )
	b. Tính mã công việc mới. mã công việc mới bằng MAX(mã công việc cũ) + 1
	c. Thêm mới bản ghi vào bảng CongViec với dữ liệu đã có.
*/
go
create Proc sp_ThemCongViec (@TenCongViec nvarchar(50),
							@MoTa nvarchar(100),
							@ƯuTien int,
							@NgayBatDau Date,
							@NgayKetThuc Date,
							@ref Bit Output)
As
Begin
    Declare @MacvMoi Char(6), @Macvmax Char(6), @Macvtt Int

    -- a. Kiểm tra Ngày bắt đầu và ngày kết thúc có hợp lệ không?
	If @NgayKetThuc < @NgayBatDau
	Begin
		Print N'Ngày không hợp lệ'
		Set @ref = 0
		Return
	End
    -- b. Tính mã công việc mới. Mã công việc mới bằng MAX(mã công việc cũ) + 1
    Select Top 1 @Macvmax = MaCongViec
    From CongViec
    Order by MaCongViec Desc
		-- Lấy phần số từ MaCongViec, loại bỏ ký tự 'C' và tăng thêm 1
    Set @Macvtt = Isnull(Cast(Right(@Macvmax, 5) as int), 0) + 1
		-- Tạo mã công việc mới với định dạng C00001, C00002, ...
    Set @MacvMoi = 'C' + Format(@Macvtt, '00000')

    -- c. Thêm mới bản ghi vào bảng CongViec với dữ liệu đã có.
    Insert Into CongViec (MaCongViec, TenCongViec, MoTa, ƯuTien, NgayBatDau, NgayKetThuc, TrangThaiCV)
    Values (@MacvMoi, @TenCongViec, @MoTa, @ƯuTien, @NgayBatDau, @NgayKetThuc, 0)

    IF @@ROWCOUNT <= 0
    Begin
        Print N'Insert thất bại'
        Set @ref = 0
        Return
    End
    Else
	Begin
		Set @ref = 1 	---Insert thành công
	End
End
--test
Declare @a Bit
Exec sp_ThemCongViec 'Cong viec 10102','Mo ta dhasjk',3,'2021-06-16','2021-08-15', @a out		--TH1: insert thành công
Exec sp_ThemCongViec 'Cong viec 10102','Mo ta dhasjk',3,'2021-08-16','2021-08-15', @a out		--TH2: thời gian không hợp lệ
Print @a
Select * From CongViec

/*9. Tính tổng số ngày công đạt chuẩn của nhân viên trong bảng ChamCong với tham số đầu vào là tháng,năm. 
	Ngày công đạt chuẩn là ngày công có đủ Giờ vào và giờ ra và tổng giờ làm việc từ 3 giờ. 
	In ra danh sách Tổng số ngày công với các cột: Mã nhân viên, tên nhân viên, tổng số ngày công*/
go
create function fn_TongNgayCongDatChuan (	@MaNV varchar(20),
											@Thang int,
											@Nam int)
returns int
as
begin
	declare @TongNgayCong int
    select @TongNgayCong = count(*)
    from ChamCong join NhanVien on NhanVien.MaNhanVien = ChamCong.MaNhanVien
    where month(NgayCong) = @Thang
        and year(NgayCong) = @Nam
        and GioVao is not null
        and GioRa is not null
        and DATEDIFF(HOUR, GioVao, GioRa) >= 3
		and Nhanvien.MaNhanVien=@MaNV
	return @TongNgayCong
end;
--test
select * from Chamcong
select dbo.fn_TongNgayCongDatChuan('NV0009','7','2024')

/*10. Tính tổng số ngày công tăng ca của nhân viên nếu biết MaNhanVien, tháng, năm. 
	Ngày công tăng cả là ngày công đạt chuẩn và có giờ ra từ 19:00 trở đi*/
go
CREATE FUNCTION fn_TinhTongNgayTangCa ( @MaNhanVien CHAR(6),
									  @Thang int,
									  @Nam int)
RETURNS INT
AS
BEGIN
    DECLARE @SoNgayTangCa INT

    SELECT @SoNgayTangCa = COUNT(DISTINCT NgayCong) 
    FROM ChamCong 
    WHERE   MaNhanVien = @MaNhanVien AND
			MONTH(NgayCong) = @Thang AND
			YEAR(NgayCong) = @Nam AND
			DATEDIFF(HOUR, GioVao, GioRa) >= 3 AND
			GioRa > '19:00:00'

    RETURN @SoNgayTangCa
END

--test
select dbo.fn_TinhTongNgayTangCa ('NV0009','7','2024')
SELECT * from ChamCong

/*12. Tính lương tăng ca của nhân viên với công thức sau:
		Lương tăng ca = 350.000 * SoNgayTangCa
*/
go
CREATE function fn_TinhLuongTangCa( @MaNhanVien char(6),
									@Thang INT,
									@Nam INT)
returns numeric(10,3)
AS
BEGIN
	declare @LuongTangCa numeric(10,3)
	Set @LuongTangCa = 0
	Select @LuongTangCa= dbo.fn_TinhTongNgayTangCa(@MaNhanVien, @Thang, @Nam) * 350000
    FROM ChamCong
    WHERE 
        MONTH(NgayCong) = @Thang 
        AND YEAR(NgayCong) = @Nam
    	and MaNhanVien = @MaNhanVien 
	return @LuongTangCa
END
--test
select dbo.fn_TinhLuongTangCa ('NV0281','09','2024')
insert into ChamCong values ('MC000010001','2024-09-01','08:38:00','20:30:00',1,'NV0281')
select * from ChamCong
/*13. Thực hiện in ra kết quả các công việc chưa hoàn thành của nhân viên nếu biết mã nhân viên.
	a.	Kiểm tra xem mã nhân viên có tồn tại trong bảng NhanVien không. 
		Nếu mã nhân viên không tồn tại, in ra thông báo “Không tồn tại” và dừng thực hiện thủ tục.
	b.	Nếu mã hợp lệ, Đếm số công việc chưa hoàn thành từ bảng CongViec. 
		Nếu không có công việc nào, in thông báo “ Không có công việc nào ” và 
		ngược lại nếu có công việc chưa hoàn thành in ra danh sách công việc chưa hoàn thành.
*/
go
create Proc sp_CongViecChuaHthanh (@MaNhanVien Char(6))
As
Begin
	Declare @SoCongViecChuaHoanThanh int
    --a.Kiểm tra xem mã nhân viên có tồn tại trong bảng NhanVien không. Nếu mã nhân viên không tồn tại, in ra thông báo
	---“Không tồn tại” và dừng thực hiện thủ tục.
    If @MaNhanVien not in (Select MaNhanVien from NhanVien)
    Begin
        Print N'Mã nhân viên không tồn tại.'
        Return
    End
	---b.Nếu mã hợp lệ, Đếm số công việc chưa hoàn thành từ bảng CongViec. Nếu không có công việc nào, in thông báo
	---“ Không có công việc nào ” và ngược lại nếu có công việc chưa hoàn thành in ra danh sách công việc chưa hoàn thành
    Select @SoCongViecChuaHoanThanh = Count(*)
    From CongViec
    Where TrangThaiCV = 0 and MaCongViec in (Select MaCongViec	From CongViec_BaoCao 
											Where MaNhanVien = @MaNhanVien)

    If @SoCongViecChuaHoanThanh = 0
    Begin
        Print N'Nhân viên đã hoàn thành tất cả công việc'
    End
    Else
    Begin
        Select MaCongViec,TenCongViec,MoTa,ƯuTien,NgayBatDau,NgayKetThuc,TrangThaiCV
        From CongViec
        Where TrangThaiCV = 0 and MaCongViec in (Select MaCongViec	From CongViec_BaoCao 
																	Where MaNhanVien = @MaNhanVien)
    End
End
--test
Exec sp_CongViecChuaHthanh 'NV0001'

/*14. Tính tổng số ngày nghỉ của nhân viên khi biết mã nhân viên, tháng, năm.*/	
GO
CREATE FUNCTION fn_TinhSoNgayNghi
(
    @MaNhanVien CHAR(6),
    @Thang INT,
    @Nam INT
)
RETURNS INT
AS
BEGIN
    DECLARE @TongSoNgayNghi INT;
    SELECT @TongSoNgayNghi = ISNULL(COUNT(NgayNghi), 0)
    FROM NghiPhep
    WHERE MaNhanVien = @MaNhanVien
        AND MONTH(NgayNghi) = @Thang
        AND YEAR(NgayNghi) = @Nam;
    RETURN @TongSoNgayNghi;
END;
GO
--test
SELECT dbo.fn_TinhSoNgayNghi('NV0974', 2, 2024) AS SoNgayNghi
select * from NghiPhep

/*15. Tính tiền khấu trừ của nhân viên trong 1 tháng bất kì*/
go
CREATE FUNCTION fn_TinhKhauTru ( @MaNhanVien CHAR(6),
								@Thang INT,
								@Nam INT)
returns numeric(10,3)
AS
BEGIN
	DECLARE @KhauTru NUMERIC(10,3)
    SET @KhauTru = (
        SELECT SUM(LoiPhat.TienPhat)
        FROM LoiPhat JOIN Luong ON LoiPhat.MaLuong = Luong.MaLuong
        WHERE Luong.Thang = @Thang 
				AND Luong.Nam = @Nam 
				AND Luong.MaNhanVien = @MaNhanVien
    );
    IF @KhauTru IS NULL 
    BEGIN
        SET @KhauTru = 0;
    END
	RETURN @KhauTru
END
GO
--test
select dbo.fn_TinhKhauTru('NV0055','3','2021')
select * from LoiPhat join Luong on LoiPhat.MaLuong=Luong.MaLuong

/*16. Thực hiện tính lương thực nhận cho tất cả nhân viên với công thức sau:
Lương thực nhận = (LuongCoBan * HeSoLuong) * (TongNgayCong / (SoNgayTrongThang - 1)) + LươngTangCa+ PhuCap - KhauTru
*/
go
alter function fn_TinhLuongTN (@MaNhanVien nvarchar(100), @Thang int, @Nam int)
returns numeric(15,3)
as
begin
	declare @LuongThucNhan numeric(15,3)
	select @LuongThucNhan = (LuongCoBan * HeSoLuong) * (dbo.fn_TongNgayCongDatChuan(@MaNhanVien,@Thang,@Nam))/(DAY(EOMONTH(DATEFROMPARTS(@Nam, @Thang, 1))) -1) 
			+  dbo.fn_TinhLuongTangCa(@MaNhanVien,@Thang,@Nam) + Thuong + PhuCap - dbo.fn_TinhKhauTru(@MaNhanVien,@Thang,@Nam)
	from ChucVu join NhanVien on NhanVien.MaChucVu=ChucVu.MaChucVu
						join Luong on NhanVien.MaNhanVien = Luong.MaNhanVien
			where Thang = @Thang and Nam = @Nam and NhanVien.MaNhanVien=@MaNhanVien
	return @LuongThucNhan

end
go
--test
select dbo.fn_TinhLuongTN ('NV0003','09','2020') as LuongThucNhan
	
select * from NhanVien join Luong on NhanVien.MaNhanVien=Luong.MaNhanVien
where NhanVien.MaNhanVien= 'NV0003'

select * from NhanVien join ChucVu on NhanVien.MaChucVu=ChucVu.MaChucVu
where NhanVien.MaNhanVien= 'NV0003'
select * from ChamCong
/*17. Trả về thông tin Lương của nhân viên nếu biết mã nhân viên và thời gian cần trả về 
	(với định dạng thời gian là “mm-yyyy” hoặc “mm/yyyy”). 
	Thông tin lương bao gồm Lương cơ bản, Hệ số lương, phụ cấp, Thưởng, Lương tăng ca, 
	Lương thực nhận khi biết Mã Nhân viên.
	*/
go
create proc Sp_2_ThongTinLuong (@MaNV varchar(20), @Thang int, @Nam int )
as
begin
	declare @Luongcoban decimal,
			@Tongngaycong int,
			@HeSoLuong float,
			@PhuCap float,
			@Thuong decimal,
			@LuongTangCa decimal,
			@LuongThucNhan decimal

	select @Luongcoban=LuongCoBan from NhanVien 
	where MaNhanVien=@MaNV

	set @Tongngaycong=dbo.fn_TongNgayCongDatChuan(@MaNV,@Thang,@Nam)

	select @HeSoLuong=HeSoLuong, @PhuCap=PhuCap from ChucVu join NhanVien on ChucVu.MaChucVu=NhanVien.MaChucVu 
	where MaNhanVien=@MaNV

	select @Thuong=Thuong from Luong 
	where MaNhanVien=@MaNV and Thang=@Thang and Nam=@Nam

	set @LuongTangCa=dbo.fn_TinhLuongTangCa(@MaNV,@Thang,@Nam)

	set @LuongThucNhan=dbo.fn_TinhLuongTN(@MaNV,@Thang,@Nam)

	SELECT	@Luongcoban AS LuongCoBan,
			@Tongngaycong as TongNgayCong,
			@HeSoLuong AS HeSoLuong,
			@PhuCap AS PhuCap,
			@Thuong AS Thuong,
			@LuongTangCa AS LuongTangCa,
			@LuongThucNhan AS LuongThucNhan;
end
--test
EXEC Sp_2_ThongTinLuong 'NV0003',09,2020

/*11. Hãy thực hiện in ra danh sách Nhân viên bao gồm: số ngày công đạt chuẩn, 
	tổng số ngày công tăng ca, tổng số ngày nghỉ nếu biết Tháng, Năm 
	(Ngày công đạt chuẩn là Ngày công có tổng số Giờ công >= 3 giờ, 
	Ngày công tăng ca là ngày công đạt chuẩn và có giờ ra lớn hơn 19h)*/
go
create proc ThongKeThongTinNhanVien (@Thang int,@Nam int)
As
Begin
    Select 
        NhanVien.MaNhanVien,
		@Thang as Thang,
		@Nam as Nam,
        Count(Distinct case
            When Datediff(Hour, ChamCong.GioVao, ChamCong.GioRa) >= 3 Then ChamCong.NgayCong 
            End) as TongNgayCongDatChuan,
        Count(Distinct Case 
            When Datediff(Hour, ChamCong.GioVao, ChamCong.GioRa) >= 3 AND ChamCong.GioRa >= '19:00:00' Then ChamCong.NgayCong 
            End) as TongNgayCongTangCa,
        Count(Distinct NghiPhep.NgayNghi) as TongSoNgayNghi
    From NhanVien
    Left join ChamCong on NhanVien.MaNhanVien = ChamCong.MaNhanVien 
        And Month(ChamCong.NgayCong) = @Thang 
        And Year(ChamCong.NgayCong) = @Nam
		Left join NghiPhep on NhanVien.MaNhanVien = NghiPhep.MaNhanVien 
        And Month(NghiPhep.NgayNghi) = @Thang 
        And Year(NghiPhep.NgayNghi) = @Nam
    Where (NghiPhep.LoaiNghi IN (0, 1) or NghiPhep.LoaiNghi is null) 
    Group by NhanVien.MaNhanVien
End
Exec ThongKeThongTinNhanVien @Thang = 07, @Nam = 2024


----------------------------ALWAYS ENCRYPTED------------------------------
Alter table dbo.NhanVien
    Add EncryptedMatKhau varbinary(Max),
        EncryptedSTK varbinary(Max)
Go
--Tạo thủ tục mã hóa dữ liệu
Create proc MaHoaDuLieuNhanVien
As
Begin
    Begin try
        -- Tạo Master Key nếu chưa có
        If not exists  (Select * From sys.symmetric_keys Where name = '##MS_DatabaseMasterKey##')
        Begin
            Create Master Key EnCryption By Password = 'abc@123'
        End

        -- Tạo Certificate nếu chưa có
        If not exists  (Select * From sys.certificates Where name = 'Certificate_test')
        Begin
           Create Certificate Certificate_test With Subject = 'Protect my data'
        End

        -- Tạo Symmetric Key nếu chưa có
        If Not exists (Select * From sys.symmetric_keys Where name = 'SymKey_test')
		Begin
			Create Symmetric Key SymKey_test 
				With Algorithm = AES_256 
				ENCRYPTION BY CERTIFICATE Certificate_test
		End

        -- Mở Symmetric Key
        OPEN SYMMETRIC KEY SymKey_test
            DECRYPTION BY CERTIFICATE Certificate_test

        -- Mã hóa dữ liệu và lưu vào cột mới
        Update dbo.NhanVien
        Set EncryptedMatKhau = EncryptByKey(Key_GUID('SymKey_test'), CAST(MatKhau As nvarchar(Max))),
            EncryptedSTK = EncryptByKey(Key_GUID('SymKey_test'), CAST(STK As nvarchar(Max)))

        -- Đóng Symmetric Key
        CLOSE SYMMETRIC KEY SymKey_test

        -- Xóa các ràng buộc liên quan đến cột cũ
        Declare @sql Nvarchar(Max)

        -- Xóa Default Constraints liên quan đến các cột cũ
        Select @sql = STRING_AGG('ALTER TABLE NhanVien DROP CONSTRAINT ' + name, '; ')
        From sys.default_constraints
        Where parent_object_id = OBJECT_ID('NhanVien') 
              AND parent_column_id IN (
					COLUMNPROPERTY(object_id('NhanVien'), 'MatKhau', 'ColumnId'),
					COLUMNPROPERTY(object_id('NhanVien'), 'STK', 'ColumnId'))
        If @sql is not null Exec(@sql)

        -- Xóa các UNIQUE Constraints liên quan đến các cột cũ
        Select @sql = STRING_AGG('ALTER TABLE NhanVien DROP CONSTRAINT ' + name, '; ')
        From sys.objects
        Where type = 'UQ' AND parent_object_id = OBJECT_ID('NhanVien')
        If @sql is not null Exec(@sql)

        -- Xóa cột cũ
        If EXISTS (Select * From sys.columns Where name IN ('MatKhau','STK') AND object_id = OBJECT_ID('NhanVien'))
        Begin
            Alter Table dbo.NhanVien 
            Drop Column MatKhau,STK
        End

        Print N'Dữ liệu đã được mã hóa và các cột cũ đã bị xóa thành công.';
    End try
    Begin catch
        Print 'Lỗi: ' + ERROR_MESSAGE();
    End Catch
End
Go
Exec MaHoaDuLieuNhanVien
Select * From NhanVien
go
--Tạo thủ tục giải mã dữ liệu
Create proc GiaiMaDuLieuNhanVien
as
Begin
    -- Kiểm tra và mở khóa đối xứng
    If not exists (Select * From sys.symmetric_keys Where name = 'SymKey_test')
    Begin
        Print 'Khóa đối xứng không tồn tại. Vui lòng kiểm tra lại.'
        Return
    End

    -- Mở khóa đối xứng
    OPEN SYMMETRIC KEY SymKey_test
        DECRYPTION BY CERTIFICATE Certificate_test

    -- Giải mã dữ liệu
    Select
        MaNhanVien, Ho, Ten, 
		EncryptedMatKhau AS [Du lieu ma hoa MatKhau],
        CONVERT(nvarchar, DecryptByKey(EncryptedMatKhau)) AS [Giai ma MatKhau],
        EncryptedSTK AS [Du lieu ma hoa STK],
        CONVERT(nvarchar, DecryptByKey(EncryptedSTK)) AS [Giai ma STK]
    From NhanVien

    -- Đóng khóa đối xứng sau khi sử dụng
    CLOSE SYMMETRIC KEY SymKey_test

    Print 'Giải mã dữ liệu thành công.'
End
Go
Exec GiaiMaDuLieuNhanVien

--Thủ tục mã hóa khi thêm dữ liệu vào bảng nhân viên

CREATE OR ALTER PROCEDURE spInsertNhanVienWithEncryptionnn
    @LName NVARCHAR(20), 
    @FName NVARCHAR(20), 
    @MaChucVu CHAR(6),
    @MaPhongBan CHAR(6), 
	@GioiTinh Bit,
	@SDT char(10),
	@DiaChi NVARCHAR(50),
    @Email VARCHAR(20), 
    @MatKhau VARCHAR(6), 
    @STK VARCHAR(50),
    @NgaySinh DATE, 
    @NgayNhanViec DATE, 
	@LuongCoBan NUMERIC(15,3),
    @TrangThaiLamViec BIT, 
    @ret BIT OUTPUT
AS
BEGIN
    BEGIN TRY
        -- a. Kiểm tra Họ, Tên, Số điện thoại đã có trong bảng Nhân viên chưa. Nếu rồi thì thông báo “Đã tồn tại nhân viên” và ngừng xử lý.
        IF (SELECT count(*)FROM NhanVien 
		WHERE Ho = @LName AND Ten = @FName AND SDT = @SDT ) >= 1
		BEGIN 
			PRINT N'Đã tồn tại nhân viên'
			SET @ret = 0
			RETURN 
		END 

        -- b. Kiểm tra Mã chức vụ, Mã phòng ban có tồn tại trong bảng Phòng Ban và Chức vụ không. Nếu không hãy đưa ra thông báo “Mã chức vụ/ Mã phòng ban không tồn tại” và ngừng xử lý.
        IF @MaChucVu NOT IN (SELECT MaChucVu FROM ChucVu)
        BEGIN
            PRINT N'Mã chức vụ không tồn tại'
            SET @ret = 0
            RETURN
        END
        IF @MaPhongBan NOT IN (SELECT MaPhongBan FROM PhongBan)
        BEGIN
            PRINT N'Mã phòng ban không tồn tại'
            SET @ret = 0
            RETURN
        END

        -- c.Kiểm tra Email nhập phải đúng định dạng. Nếu không hãy đưa ra thông báo “Email sai định dạng” và ngừng xử lý.
        IF @Email NOT LIKE '%@%.%'
        BEGIN
            PRINT N'Email sai định dạng'
            SET @ret = 0
            RETURN 
        END

        -- d. Tính Mã nhân viên mới. Mã nhân viên tiếp theo được tính như sau MAX(mã nhân viên đang có) + 1. Hãy đảm bảo số lượng ký tự luôn đúng với quy định về mã nhân viên
        DECLARE @newCust_id CHAR(6)
        DECLARE @maxCust_id INT
        SET @maxCust_id = (
            SELECT MAX(CAST(SUBSTRING(MaNhanVien, 3, LEN(MaNhanVien) - 2) AS INT)) 
            FROM NhanVien
        )
        SET @newCust_id = 'NV' + RIGHT('0000' + CAST(ISNULL(@maxCust_id, 0) + 1 AS NVARCHAR), 4)

        -- e. Check symmetric key
        IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'SymKey_test')
        BEGIN
            PRINT 'Khóa đối xứng không tồn tại. Vui lòng kiểm tra lại.';
            SET @ret = 0;
            RETURN;
        END;

        -- Open symmetric key
        OPEN SYMMETRIC KEY SymKey_test DECRYPTION BY CERTIFICATE Certificate_test;

        -- Encrypt sensitive data
        DECLARE @EncryptedMatKhau VARBINARY(MAX), @EncryptedSTK VARBINARY(MAX);
        SET @EncryptedMatKhau = EncryptByKey(Key_GUID('SymKey_test'), CAST(@MatKhau AS NVARCHAR(MAX)));
        SET @EncryptedSTK = EncryptByKey(Key_GUID('SymKey_test'), CAST(@STK AS NVARCHAR(MAX)));

        -- Thêm bản ghi mới vào
        INSERT INTO NhanVien (
            MaNhanVien, Ho, Ten, EncryptedMatKhau, NgaySinh, GioiTinh,SDT,DiaChi, Email, 
            LuongCoBan, NgayNhanViec, TrangThaiLamViec, EncryptedSTK, MaChucVu, MaPhongBan
        ) VALUES (
            @newCust_id, @LName, @FName, @EncryptedMatKhau, @NgaySinh, @GioiTinh,@SDT,@DiaChi, @Email, 
            @LuongCoBan, @NgayNhanViec, @TrangThaiLamViec, @EncryptedSTK, @MaChucVu, @MaPhongBan
        );

        -- Check 
        IF @@ROWCOUNT > 0
            SET @ret = 1;
        ELSE
            SET @ret = 0;

        -- Close symmetric key
        CLOSE SYMMETRIC KEY SymKey_test;

    END TRY
    BEGIN CATCH
        PRINT 'Lỗi: ' + ERROR_MESSAGE();
        SET @ret = 0;
    END CATCH
END;
GO

DECLARE @ret BIT;
EXEC spInsertNhanVienWithEncryptionnn 
    @LName = N'Họ 11', 
    @FName = N'Tên 11', 
    @MaChucVu = 'CV0001',
	@DiaChi = 'Địa chỉ 11',
	@SDT ='0881300845',
	@GioiTinh = 1,
    @MaPhongBan = 'PB0001', 
    @Email = 'NV0011@gmail.com', 
    @MatKhau = 'MK0011', 
    @STK = 'STK123456789012', 
    @NgaySinh = '1990-01-01', 
    @NgayNhanViec = '2024-01-01', 
    @TrangThaiLamViec = 1, 
	@LuongCoBan = '8582746.177',
    @ret = @ret OUTPUT;
Select *from NhanVien
SELECT * FROM NhanVien WHERE MaNhanVien = (SELECT MAX(MaNhanVien) FROM NhanVien);

--------------------STORED PROCEDURE CHỐNG SQL INJECTION------------------

-- 1. Đăng nhập
	--- a. Tấn công OR '1' = '1'
	go
	Select * From NhanVien 
	Where MaNhanVien = 'NV0001' And MatKhau = '123' OR '1'='1'

	--- Cách khắc phục:
	go
	Create proc DangNhap
		@MaNhanVien Nvarchar(50),
		@MatKhau Nvarchar(50)
	As
	Begin
		Select * From NhanVien 
		Where MaNhanVien = @MaNhanVien And MatKhau = @MatKhau
	End

	Exec DangNhap @MaNhanVien = 'NV0001', @MatKhau = '' OR '1' = '1'

--- b. Tấn công Blind SQL Injection (SQL mù)
	SELECT * FROM NhanVien 
	WHERE MaNhanVien = 'NV0001' AND SUBSTRING(MatKhau, 1, 1) = 'm'

---	Cách khắc phục:
	go
	CREATE PROCEDURE KiemTraDangNhap
		@MaNhanVien CHAR(6),
		@MatKhau NVARCHAR(50)
	AS
	BEGIN
		-- Sử dụng câu lệnh IF EXISTS để tránh trả về thông tin nhạy cảm
		IF EXISTS (
			SELECT 1
			FROM NhanVien
			WHERE MaNhanVien = @MaNhanVien AND MatKhau = @MatKhau
		)
		BEGIN
			SELECT 'Login Successful' AS Status;
		END
		ELSE
		BEGIN
			SELECT 'Login Failed' AS Status;
		END
	END;
	GO
	EXEC KiemTraDangNhap @MaNhanVien = 'NV0001', @MatKhau = ' '

-- 2. Tìm kiếm nhân viên:
	--- a. Truy vấn dễ bị SQL injection:
	SELECT MaNhanVien, EncryptedMatKhau, EncryptedSTK FROM NhanVien 
	WHERE MaNhanVien = 'NV0001' AND Ten = '' OR '1'='1' 

	--- b. Cách dùng Stored Procedure để tránh SQL Injection:
	go
	CREATE PROCEDURE TimKiemNhanVien
		@MaNhanVien CHAR(6),
		@Ten NVARCHAR(50)
	AS
	BEGIN
		SELECT MaNhanVien, EncryptedMatKhau, EncryptedSTK FROM NhanVien
		WHERE MaNhanVien = @MaNhanVien AND Ten = @Ten;
	END;

	EXEC TimKiemNhanVien 'NV0001', '' OR '1'='1' 

-- 3. Cập nhật thông tin nhân viên
	-- a. Truy vấn dễ bị SQL injection
	UPDATE NhanVien
	SET DiaChi = 'Hue'
	where MaNhanVien = 'NV0001' OR '1' = '1'

	-- b. Cách khắc phục
	CREATE PROCEDURE CapNhatDiaChiNhanVien
		@MaNhanVien CHAR(6),
		@DiaChi NVARCHAR(50)
	AS
	BEGIN
		UPDATE NhanVien
		SET DiaChi = @DiaChi
		WHERE MaNhanVien = @MaNhanVien;
	END;
	GO

	-- Gọi thủ tục 
	Exec CapNhatDiaChiNhanVien @MaNhanVien = 'NV0001', @DiaChi = 'DaNang' OR '1' = '1'
	

-- 4. Xóa thông tin Nhân viên
	-- a. Truy vấn dễ bị SQL injection
	DELETE FROM NhanVien
	WHERE MaLoi = '' OR '1' = '1'

	-- b. Cách khắc phục
	GO
	CREATE PROCEDURE XoaThongTinNhanVien
		@MaNhanVien CHAR(6)
	AS
	BEGIN
		DELETE FROM NhanVien
		WHERE MaNhanVien = @MaNhanVien;
	END;
	GO

	-- Gọi thủ tục 
	Exec XoaThongTinNhanVien @MaNhanVien = 'NV0001' OR '1' ='1'

