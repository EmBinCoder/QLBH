-- 1. Tạo CSDL
CREATE DATABASE QLBANHANG;
GO
USE QLBANHANG;
GO

-- 2 & 3. Tạo các bảng và ràng buộc
-- Bảng LOAISP
CREATE TABLE LOAISP (
    MaLoai VARCHAR(10) PRIMARY KEY,
    TenLoai NVARCHAR(50) NOT NULL UNIQUE -- Ràng buộc UNIQUE
);

-- Bảng SANPHAM
CREATE TABLE SANPHAM (
    MASP VARCHAR(10) PRIMARY KEY,
    TenSP NVARCHAR(100) NOT NULL,
    Mota NVARCHAR(255),
    Gia MONEY CHECK (Gia > 0), -- Ràng buộc CHECK
    MaLoai VARCHAR(10) REFERENCES LOAISP(MaLoai)
);

-- Bảng KHACHHANG
CREATE TABLE KHACHHANG (
    MAKH VARCHAR(10) PRIMARY KEY,
    TenKH NVARCHAR(100) NOT NULL,
    DC NVARCHAR(255),
    DT VARCHAR(20)
);

-- Bảng DONDH
CREATE TABLE DONDH (
    SoDDH VARCHAR(10) PRIMARY KEY,
    NgayDat DATETIME DEFAULT GETDATE(), -- Ràng buộc DEFAULT
    MAKH VARCHAR(10) REFERENCES KHACHHANG(MAKH)
);

-- Bảng CTDDH
CREATE TABLE CTDDH (
    SoDDH VARCHAR(10) REFERENCES DONDH(SoDDH),
    MASP VARCHAR(10) REFERENCES SANPHAM(MASP),
    SoLuong INT CHECK (SoLuong > 0),
    PRIMARY KEY (SoDDH, MASP) -- Khóa chính phức hợp
);

-- Bảng NGUYENLIEU
CREATE TABLE NGUYENLIEU (
    MaNL VARCHAR(10) PRIMARY KEY,
    TenNL NVARCHAR(100),
    DVT NVARCHAR(20),
    Gia MONEY CHECK (Gia > 0)
);

-- Bảng LAM
CREATE TABLE LAM (
    MaNL VARCHAR(10) REFERENCES NGUYENLIEU(MaNL),
    MASP VARCHAR(10) REFERENCES SANPHAM(MASP),
    SoLuong FLOAT CHECK (SoLuong > 0),
    PRIMARY KEY (MaNL, MASP)
);

-- 4. Tạo chỉ mục (Index) để tăng tốc độ truy vấn
CREATE NONCLUSTERED INDEX IX_SANPHAM_TenSP ON SANPHAM(TenSP);
CREATE NONCLUSTERED INDEX IX_KHACHHANG_TenKH ON KHACHHANG(TenKH);
CREATE NONCLUSTERED INDEX IX_DONDH_NgayDat ON DONDH(NgayDat);
-- Nhập LOAISP
INSERT INTO LOAISP VALUES ('L01', N'Tủ');
INSERT INTO LOAISP VALUES ('L02', N'Bàn');
INSERT INTO LOAISP VALUES ('L03', N'Giường');

-- Nhập SANPHAM
INSERT INTO SANPHAM VALUES ('SP01', N'Tủ trang điểm', N'Cao 1.4m, rộng 2.2m', 1000000, 'L01');
INSERT INTO SANPHAM VALUES ('SP02', N'Giường đơn Cali', N'Rộng 1.4m', 1500000, 'L03');
INSERT INTO SANPHAM VALUES ('SP03', N'Tủ DDA', N'Cao 1.6m, rộng 2.0m, cửa kiếng', 800000, 'L01');
INSERT INTO SANPHAM VALUES ('SP04', N'Bàn ăn', N'1m x 1.5m', 650000, 'L02');
INSERT INTO SANPHAM VALUES ('SP05', N'Bàn uống trà', N'Tròn, 1.8m', 1100000, 'L02');

-- Nhập KHACHHANG
INSERT INTO KHACHHANG VALUES ('KH001', N'Trần Hải Cường', N'731 Trần Hưng Đạo, Q.1, TP.HCM', '08-9776655');
INSERT INTO KHACHHANG VALUES ('KH002', N'Nguyễn Thị Bé', N'638 Nguyễn Văn Cừ, Q.5, TP.HCM', '0913-666123');
INSERT INTO KHACHHANG VALUES ('KH003', N'Trần Thị Minh Hòa', N'543 Mai Thị Lựu, Ba Đình, Hà Nội', '04-9238777');
INSERT INTO KHACHHANG VALUES ('KH004', N'Phạm Đình Tuân', N'975 Lê Lai, P.3, TP.Vũng Tàu', '064-543678');
INSERT INTO KHACHHANG VALUES ('KH005', N'Lê Xuân Nguyện', N'450 Trưng Vương, Mỹ Tho, Tiền Giang', '073-987123');
INSERT INTO KHACHHANG VALUES ('KH006', N'Văn Hùng Dũng', N'291 Hồ Văn Huê, Q.PN, TP.HCM', '08-8222111');
INSERT INTO KHACHHANG VALUES ('KH012', N'Lê Thị Hương Hoa', N'980 Lê Hồng Phong, TP.Vũng Tàu', '064-452100');
INSERT INTO KHACHHANG VALUES ('KH016', N'Hà Minh Trí', N'332 Nguyễn Thái Học, TP.Quy Nhơn', '056-565656');

-- Nhập DONDH
SET DATEFORMAT DMY; -- Thiết lập định dạng ngày tháng sang Ngày/Tháng/Năm
INSERT INTO DONDH VALUES ('DH001', '15/03/2010', 'KH001');
INSERT INTO DONDH VALUES ('DH002', '15/03/2010', 'KH016');
INSERT INTO DONDH VALUES ('DH003', '16/03/2010', 'KH003');
INSERT INTO DONDH VALUES ('DH004', '16/03/2010', 'KH012');
INSERT INTO DONDH VALUES ('DH005', '17/03/2010', 'KH001');
INSERT INTO DONDH VALUES ('DH006', '01/04/2010', 'KH002');

-- Nhập CTDDH
INSERT INTO CTDDH VALUES ('DH001', 'SP01', 5);
INSERT INTO CTDDH VALUES ('DH001', 'SP03', 1);
INSERT INTO CTDDH VALUES ('DH002', 'SP02', 2);
INSERT INTO CTDDH VALUES ('DH003', 'SP01', 2);
INSERT INTO CTDDH VALUES ('DH003', 'SP04', 10);
INSERT INTO CTDDH VALUES ('DH003', 'SP05', 5);
INSERT INTO CTDDH VALUES ('DH004', 'SP02', 2);
INSERT INTO CTDDH VALUES ('DH004', 'SP05', 2);
INSERT INTO CTDDH VALUES ('DH005', 'SP03', 3);
INSERT INTO CTDDH VALUES ('DH006', 'SP02', 4);
INSERT INTO CTDDH VALUES ('DH006', 'SP04', 3);
INSERT INTO CTDDH VALUES ('DH006', 'SP05', 6);

-- Nhập NGUYENLIEU
INSERT INTO NGUYENLIEU VALUES ('NL01', N'Gỗ Lim XP', 'm3', 1200000);
INSERT INTO NGUYENLIEU VALUES ('NL02', N'Gỗ Sao NT', 'm3', 1000000);
INSERT INTO NGUYENLIEU VALUES ('NL03', N'Gỗ tạp nham', 'm3', 500000);
INSERT INTO NGUYENLIEU VALUES ('NL04', N'Đinh lớn', 'Kg', 40000);
INSERT INTO NGUYENLIEU VALUES ('NL05', N'Đinh nhỏ', 'Kg', 30000);
INSERT INTO NGUYENLIEU VALUES ('NL06', N'Kiếng', 'm2', 350000);

-- Nhập LAM
INSERT INTO LAM VALUES ('NL01', 'SP01', 1.2);
INSERT INTO LAM VALUES ('NL03', 'SP01', 0.3);
INSERT INTO LAM VALUES ('NL06', 'SP01', 2.5);
INSERT INTO LAM VALUES ('NL02', 'SP02', 1.1);
INSERT INTO LAM VALUES ('NL04', 'SP02', 2.2);
INSERT INTO LAM VALUES ('NL02', 'SP03', 0.9);
INSERT INTO LAM VALUES ('NL05', 'SP03', 2.1);
INSERT INTO LAM VALUES ('NL02', 'SP04', 1.3);
INSERT INTO LAM VALUES ('NL04', 'SP04', 1.7);
INSERT INTO LAM VALUES ('NL03', 'SP05', 0.8);
INSERT INTO LAM VALUES ('NL05', 'SP05', 0.5);
INSERT INTO LAM VALUES ('NL06', 'SP05', 2.4);

-- a) loại sp nhiều sp nhất
create view view_a as
select top 1 with ties l.tenloai, count(s.masp) sl
from loaisp l join sanpham s on l.maloai=s.maloai
group by l.tenloai
order by sl desc
go

select * from view_a -- loại sp nhiều sp nhất


-- b) kh không đặt hàng 3/2010
create view view_b as
select tenkh, dc 
from khachhang 
where makh not in (
    select makh from dondh 
    where month(ngaydat)=3 and year(ngaydat)=2010
)
go


select * from view_b -- kh không đặt hàng 3/2010
-- c) kh đặt nhiều đơn nhất 3/2010
create view view_c as
select top 1 with ties k.tenkh, k.dc 
from khachhang k join dondh d on k.makh=d.makh 
where month(ngaydat)=3 and year(ngaydat)=2010 
group by k.tenkh, k.dc 
order by count(d.soddh) desc
go
select * from view_c -- kh đặt nhiều đơn nhất 3/2010
-- d) sp không được đặt 3/2010
create view view_d as
select tensp, mota 
from sanpham 
where masp not in (
    select c.masp 
    from ctddh c join dondh d on c.soddh=d.soddh 
    where month(ngaydat)=3 and year(ngaydat)=2010
)
go


select * from view_c -- kh đặt nhiều đơn nhất 3/2010
-- e) kh đặt trên 10 tủ dda
create view view_e as
select k.tenkh, k.dc, sum(c.soluong) tongsl 
from khachhang k 
join dondh d on k.makh=d.makh 
join ctddh c on d.soddh=c.soddh 
join sanpham s on c.masp=s.masp 
where s.tensp=N'Tủ DDA' 
group by k.tenkh, k.dc 
having sum(c.soluong)>10
go



-- f) sp làm từ nhiều loại nl nhất
create view view_f as
select top 1 with ties s.tensp, s.gia, count(l.manl) soloai 
from sanpham s join lam l on s.masp=l.masp 
group by s.tensp, s.gia 
order by soloai desc
go

-- g) sp giá sx > 1 triệu
create view view_g as
select s.tensp, sum(l.soluong*n.gia) giasx 
from sanpham s 
join lam l on s.masp=l.masp 
join nguyenlieu n on l.manl=n.manl 
group by s.tensp 
having sum(l.soluong*n.gia)>1000000
go

select * from view_g -- sp giá sx > 1 triệu

-- h) sp lãi > 20%
create view view_h as
select s.tensp, sum(l.soluong*n.gia) giasx, s.gia, 
       (s.gia-sum(l.soluong*n.gia))/sum(l.soluong*n.gia)*100 lai 
from sanpham s 
join lam l on s.masp=l.masp 
join nguyenlieu n on l.manl=n.manl 
group by s.tensp, s.gia		
having (s.gia-sum(l.soluong*n.gia))/sum(l.soluong*n.gia)>0.2
go
select * from view_h -- sp lãi > 20%
-- i) đơn hàng > 100 triệu
create view view_i as
select d.soddh, d.ngaydat, sum(c.soluong*s.gia) tongtien 
from dondh d 
join ctddh c on d.soddh=c.soddh 
join sanpham s on c.masp=s.masp 
group by d.soddh, d.ngaydat 
having sum(c.soluong*s.gia)>100000000
go

-- j) nl làm tất cả sp
create view view_j as
select n.tennl, n.gia 
from nguyenlieu n 
where not exists (
    select s.masp from sanpham s 
    where not exists (
        select * from lam l 
        where l.manl=n.manl and l.masp=s.masp
    )
)
go

-- k) kh đặt tất cả sp
create view view_k as
select k.tenkh, k.dc 
from khachhang k 
where not exists (
    select s.masp from sanpham s 
    where not exists (
        select * from dondh d join ctddh c on d.soddh=c.soddh 
        where d.makh=k.makh and c.masp=s.masp
    )
)
go

-- l) sp được tất cả kh đặt
create view view_l as
select s.tensp, s.mota 
from sanpham s 
where not exists (
    select k.makh from khachhang k 
    where not exists (
        select * from dondh d join ctddh c on d.soddh=c.soddh 
        where d.makh=k.makh and c.masp=s.masp
    )
)
go

-- m) kh lâu nhất chưa đặt
create view view_m as
select top 1 with ties k.tenkh, k.dc, max(d.ngaydat) ngayganhat 
from khachhang k join dondh d on k.makh=d.makh 
group by k.tenkh, k.dc 
order by ngayganhat asc
go
--Phần 4: stored procedure 

-- a) kh đặt ngày x
create proc sp_dskh_ngay @ngay datetime as
begin
    select distinct k.tenkh, k.dc 
    from khachhang k join dondh d on k.makh=d.makh 
    where d.ngaydat=@ngay
end
go
exec sp_dskh_ngay '2010-03-15'
-- b) kh đặt sp mã x
create proc sp_dskh_sp @masp varchar(10) as
begin
    select distinct k.tenkh, k.dc 
    from khachhang k 
    join dondh d on k.makh=d.makh 
    join ctddh c on d.soddh=c.soddh 
    where c.masp=@masp
end
go
exec sp_dskh_sp 'sp01'
-- c) kh đặt đơn > x tiền
create proc sp_dskh_tiendon @tien money as
begin
    select distinct k.tenkh, k.dc 
    from khachhang k 
    join dondh d on k.makh=d.makh 
    join ctddh c on d.soddh=c.soddh 
    join sanpham s on c.masp=s.masp 
    group by k.tenkh, k.dc, d.soddh 
    having sum(c.soluong*s.gia)>@tien
end
go

exec sp_dskh_tiendon 1000000
-- d) kh có tổng tiền mua > x
create proc sp_dskh_tientong @tien money as
begin
    select k.tenkh, k.dc 
    from khachhang k 
    join dondh d on k.makh=d.makh 
    join ctddh c on d.soddh=c.soddh 
    join sanpham s on c.masp=s.masp 
    group by k.tenkh, k.dc 
    having sum(c.soluong*s.gia)>@tien
end
go

-- e) sp lãi > x
create proc sp_dssp_lai @lai money as
begin
    select s.tensp, sum(l.soluong*n.gia) giasx, s.gia 
    from sanpham s 
    join lam l on s.masp=l.masp 
    join nguyenlieu n on l.manl=n.manl 
    group by s.tensp, s.gia 
    having (s.gia-sum(l.soluong*n.gia))>@lai
end
go

-- f) kh > x ngày chưa đặt
create proc sp_dskh_lau @ngay int as
begin
    select tenkh, dc from khachhang 
    where makh not in (
        select makh from dondh 
        where datediff(day, ngaydat, getdate())<=@ngay
    )
end
go

exec sp_dskh_lau 2000
-- g) sp có > x đơn
create proc sp_dssp_sodon @sodon int as
begin
    select s.tensp, count(distinct c.soddh) sl 
    from sanpham s join ctddh c on s.masp=c.masp 
    group by s.tensp 
    having count(distinct c.soddh)>@sodon
end
go

-- h) sp có tổng sl > x
create proc sp_dssp_tongsl @sl int as
begin
    select s.tensp, sum(c.soluong) tong 
    from sanpham s join ctddh c on s.masp=c.masp 
    group by s.tensp 
    having sum(c.soluong)>@sl
end
go

-- i) sp có tổng tiền > x
create proc sp_dssp_tongtien @tien money as
begin
    select s.tensp, sum(c.soluong*s.gia) tong 
    from sanpham s join ctddh c on s.masp=c.masp 
    group by s.tensp 
    having sum(c.soluong*s.gia)>@tien
end
go

--phần 5: trigger

-- a) max 2 đơn/ngày
create trigger trg_check_sodon on dondh for insert as
begin
    if (select count(*) from dondh d 
        join inserted i on d.makh=i.makh and d.ngaydat=i.ngaydat)>2
    begin 
        print N'Lỗi: Quá 2 đơn/ngày'
        rollback tran 
    end
end
go

-- b) tổng sl sp < 100
create trigger trg_check_sl on ctddh for insert, update as
begin
    if (select sum(soluong) from ctddh 
        where soddh=(select soddh from inserted))>100
    begin 
        print N'Lỗi: SL quá 100'
        rollback tran 
    end
end
go

-- c) không lỗ quá 50%
create trigger trg_check_lo on sanpham for insert, update as
begin
    declare @masp varchar(10), @ban money, @sx money
    select @masp=masp, @ban=gia from inserted
    
    select @sx=isnull(sum(l.soluong*n.gia),0) 
    from lam l join nguyenlieu n on l.manl=n.manl 
    where l.masp=@masp
    
    if @sx>0 and (@ban-@sx)/@sx < -0.5
    begin 
        print N'Lỗi: Lỗ quá 50%'
        rollback tran 
    end
end
go

--phần 6: cursor
-- a) liệt kê x sp của loại y
create proc sp_cursor_a @x int, @maloai varchar(10) as
begin
    declare @ten nvarchar(50), @tensp nvarchar(100) 
    declare @mota nvarchar(255), @gia money, @dem int=0
    
    select @ten=tenloai from loaisp where maloai=@maloai
    print N'Tên loại: '+@ten
    
    declare cur cursor for 
    select tensp, mota, gia from sanpham 
    where maloai=@maloai order by gia desc
    
    open cur
    fetch next from cur into @tensp, @mota, @gia
    
    while @@fetch_status=0 and @dem<@x 
    begin
        set @dem=@dem+1
        print N'SP '+cast(@dem as varchar)+': '+@tensp+N' - '+@mota+N' - '+cast(@gia as varchar)
        fetch next from cur into @tensp, @mota, @gia
    end
    
    close cur
    deallocate cur
end
go
exec sp_cursor_a 2, 'l01'
-- b) cập nhật giá theo lãi lỗ
create proc sp_cursor_b as
begin
    declare @masp varchar(10), @ban money, @sx money, @lai float
    declare cur cursor for select masp, gia from sanpham
    
    open cur
    fetch next from cur into @masp, @ban
    
    while @@fetch_status=0 
    begin
        select @sx=isnull(sum(l.soluong*n.gia),0) 
        from lam l join nguyenlieu n on l.manl=n.manl 
        where l.masp=@masp
        
        if @sx>0 begin
            set @lai=(@ban-@sx)/@sx
            if @lai>0.3 
                update sanpham set gia=gia*0.9 where masp=@masp
            else if @lai<0 
                update sanpham set gia=@sx where masp=@masp
            else 
                update sanpham set gia=gia*1.05 where masp=@masp
        end
        fetch next from cur into @masp, @ban
    end
    
    close cur
    deallocate cur
end
go


exec sp_cursor_b
select * from sanpham
-- c) thống kê đơn tháng x
create proc sp_cursor_c @thang int, @nam int as
begin
    declare @ngay datetime, @soddh varchar(10)
    declare @makh varchar(10), @tien money, @stt int
    
    declare cur_n cursor for 
    select distinct ngaydat from dondh 
    where month(ngaydat)=@thang and year(ngaydat)=@nam order by ngaydat
    
    open cur_n
    fetch next from cur_n into @ngay
    
    while @@fetch_status=0 
    begin
        print N'Ngày '+convert(varchar, @ngay, 103)
        set @stt=0
        
        declare cur_d cursor for 
        select d.soddh, d.makh, sum(c.soluong*s.gia) 
        from dondh d 
        join ctddh c on d.soddh=c.soddh 
        join sanpham s on c.masp=s.masp 
        where d.ngaydat=@ngay 
        group by d.soddh, d.makh
        
        open cur_d
        fetch next from cur_d into @soddh, @makh, @tien
        
        while @@fetch_status=0 
        begin
            set @stt=@stt+1
            print cast(@stt as varchar)+'-'+@soddh+': '+@makh+N', Tiền: '+cast(@tien as varchar)
            fetch next from cur_d into @soddh, @makh, @tien
        end
        
        close cur_d
        deallocate cur_d
        fetch next from cur_n into @ngay
    end
    
    close cur_n
    deallocate cur_n
end
go
exec sp_cursor_c 3, 2010
