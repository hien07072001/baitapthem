create database baitap;
use baitap;

create table VATTU(
  MAVT int auto_increment primary key ,
  TENVTU varchar(50),
  DVITINH varchar(50) not null ,
  PHAMTRAM double not null
);

create table TONKHO(
  NAMTHANG date primary key ,
  MAVTU int ,
  SLDAU int not null ,
  TONGSLN int  not null ,
  TONGSLX int not null ,
  SLCUOI int not null ,
  constraint fk_TONKHO_VATTU foreign key (MAVTU) references VATTU(MAVT)
);

create table PXUAT(
    SOPX int auto_increment primary key not null ,
    NGAYXUAT date not null ,
    TENKH varchar(50) not null
);

create table DONDH(
    SODH int primary key ,
    NGAYDH date not null ,
    MANHACC int ,
    constraint fk_DONDH_NHACC foreign key (MANHACC) references NHACC(MANHACC)
);

create table NHACC(
    MANHACC int primary key ,
    TENNHACC varchar(200) not null ,
    DIACHI varchar(200),
    DIENTHOAI varchar(100)
);

create table PNHAP(
    SOPN int primary key ,
    NGAYNHAP date not null ,
    SODH int,
    constraint fk_PNHAP_DONDH foreign key (SODH)references DONDH(SODH)
);

create table  CTDONDH(
    SODH int,
    MAVT int,
    SLDAT int not null ,
    constraint fk_CTDONDH_DONDH foreign key (SODH)references DONDH(SODH),
    constraint fk_CTDONDH_VATTU foreign key (MAVT)references VATTU(MAVT)
);

create table CTPXUAT(
                        SOPX int,
                        MAVT int,
                        SLXUAT int not null ,
                        DGXUAT double,
                        constraint fk_CTPXUAT_PXUAT foreign key (SOPX)references PXUAT(SOPX),
                        constraint fk_CTPXUAT_VATTU foreign key (MAVT) references VATTU(MAVT)
);

create table CTPNHAP(
    MAVT int,
    SOPN int,
    SLNHAP int,
    DGNHAP double,
    constraint fk_CTPNHAP_VATTU foreign key (MAVT)references VATTU(MAVT),
    constraint fk_CTPNHAP_PNHAP foreign key (SOPN)references PNHAP(SOPN)
);

insert into VATTU values (01,'thep','ta',33.3),
                         (02,'sat','tan',40.1),
                         (03,'xi mang ','ta',66.2),
                         (04,'gach','tan',50.5),
                         (05,'than','ta',12.7);
insert into TONKHO values ('2015-04-01',01,10,72,21,43),
                          ('2016-05-02',02,50,83,12,57),
                          ('2017-06-03',03,24,55,33,24),
                          ('2018-07-04',04,36,60,44,11),
                          ('2019-08-05',05,47,70,21,32);
insert into PXUAT values (001,'2015-10-12','dao'),
                         (002,'2016-11-21','man'),
                         (003,'2017-12-07','cam '),
                         (004,'2018-01-18','quyt'),
                         (005,'2019-02-15','chanh');
insert into PNHAP values (1,'2015-05-11',21),
                         (3,'2016-04-15',22),
                         (2,'2017-05-22',23),
                         (5,'2017-07-04',24),
                         (4,'2018-05-27',25);
insert into NHACC values (112,'abc','Ha Noi','0123'),
                         (113,'acd','Hoa Binh','0145'),
                         (114,'xyz','Nam Dinh','0126'),
                         (115,'qwe','Thai Binh','0113'),
                         (116,'tyu','Ninh Binh','0109');
insert into DONDH values (21,'2015-03-11',112),
                         (22,'2016-01-01',113),
                         (23,'2016-05-21',114),
                         (24,'2015-05-14',115),
                         (25,'2018-03-22',116);
insert into CTPXUAT values (001,01,16,22.1),
                           (002,02,8,33.2),
                           (003,03,7,44.1),
                           (004,04,10,20.3),
                           (005,05,14,15.6);
insert into CTPNHAP values (1,01,9,12.0),
                           (2,02,8,15.7),
                           (3,03,1,9.3),
                           (4,04,7,4.3),
                           (5,05,5,5.1);
insert into CTDONDH values (21,01,3),
                           (22,02,5),
                           (23,03,7),
                           (24,04,9),
                           (25,05,14);

drop view vw_CTPNHAP;

create  view vw_CTPNHAP as select SOPN,VATTU.MAVT,SLNHAP,DGNHAP,SLNHAP*DGNHAP
    as 'tong tien' from VATTU
        join CTPNHAP on VATTU.MAVT = CTPNHAP.MAVT group by  SOPN;

select *from  vw_CTPNHAP;

create view vw_CTPNHAP_VT as select SOPN, VATTU.MAVT, TENVTU,SLNHAP, DGNHAP, SLNHAP*DGNHAP as 'Thành Tiền'
                             from VATTU join CTDONDH C on VATTU.MAVT = C.MAVT
                                        join CTPNHAP C2 on VATTU.MAVT = C2.MAVT group by SOPN, VATTU.MAVT, TENVTU, SLNHAP, DGNHAP;
DROP VIEW vw_CTPNHAP_VT;
select * from vw_CTPNHAP_VT order by SOPN;

create view vw_CTPNHAP_VT as select SOPN, VATTU.MAVT, TENVTU,SLNHAP, DGNHAP, SLNHAP*DGNHAP as 'Thành Tiền'
                             from VATTU join CTDONDH C on VATTU.MAVT = C.MAVT
                                        join CTPNHAP C2 on VATTU.MAVT = C2.MAVT group by SOPN, VATTU.MAVT, TENVTU, SLNHAP, DGNHAP;
DROP VIEW vw_CTPNHAP_VT;
select * from vw_CTPNHAP_VT order by SOPN;

create view w_CTPNHAP_VT_P as select CTPNHAP.SOPN, NGAYNHAP, SODH,CTPNHAP.MAVT, TENVTU, SLNHAP,DGNHAP,SLNHAP*DGNHAP AS 'THANH TIỀN' FROM CTPNHAP
                                                                                                                                              JOIN PNHAP P on CTPNHAP.SOPN = P.SOPN
                                                                                                                                              JOIN VATTU V on CTPNHAP.MAVT = V.MAVT GROUP BY CTPNHAP.SOPN;
DROP VIEW w_CTPNHAP_VT_P;
SELECT *FROM w_CTPNHAP_VT_P;

CREATE VIEW vw_CTPNHAP_VT_PN_DH AS SELECT CTPNHAP.SOPN, NGAYNHAP,SODH,CTPNHAP.MAVT,TENVTU,SLNHAP,DGNHAP, SLNHAP*DGNHAP AS 'THÀNH TIỀN'
                                   FROM CTPNHAP JOIN VATTU V on CTPNHAP.MAVT = V.MAVT
                                                JOIN PNHAP P on CTPNHAP.SOPN = P.SOPN GROUP BY CTPNHAP.SOPN;
SELECT * FROM vw_CTPNHAP_VT_PN_DH;

CREATE VIEW vw_CTPNHAP_loc  AS SELECT SOPN, MAVT, SLNHAP,DGNHAP, SLNHAP*DGNHAP AS 'THÀNH TIỀN' FROM CTPNHAP ;
SELECT * FROM vw_CTPNHAP_loc;

CREATE VIEW vw_CTPNHAP_VT_loc AS SELECT CTPNHAP.SOPN,CTPNHAP.MAVT,TENVTU,SLNHAP,DGNHAP,SLNHAP*DGNHAP AS 'THÀNH TIỀN' FROM CTPNHAP
                                                                                                                               JOIN PNHAP P on CTPNHAP.SOPN = P.SOPN
                                                                                                                               JOIN VATTU V on CTPNHAP.MAVT = V.MAVT;
SELECT * FROM vw_CTPNHAP_VT_loc ;

CREATE VIEW vw_CTPXUAT AS SELECT SOPX,MAVT,SLXUAT,DGXUAT, SLXUAT*DGXUAT AS 'THÀNH TIỀN'
                          FROM CTPXUAT;
SELECT * FROM vw_CTPXUAT;

CREATE VIEW vw_CTPXUAT_VT AS SELECT SOPX,CTPXUAT.MAVT,TENVTU,SLXUAT,DGXUAT FROM CTPXUAT
                                                                                     JOIN VATTU V on CTPXUAT.MAVT= V.MAVT GROUP BY SOPX;

SELECT * FROM vw_CTPXUAT_VT;


CREATE VIEW vw_CTPXUAT_VT_PX  AS SELECT CX.SOPX , TENKH, V.MAVT ,TENVTU,SLXUAT,DGXUAT FROM PXUAT
                                                                                                JOIN CTPXUAT CX JOIN VATTU V on CX.MAVT = V.MAVT GROUP BY CX.SOPX;

DROP VIEW vw_CTPXUAT_VT_PX;
SELECT *FROM vw_CTPXUAT_VT_PX;

-- STORE PROCEDURE
CREATE PROCEDURE TONKHO(
    IN TOTAL INT
)
BEGIN SELECT* FROM TONKHO WHERE SLCUOI = TOTAL;
END;

CALL baitap.TONKHO(4);

CREATE PROCEDURE TONKHO(
    IN MAVT INT
)
BEGIN  SELECT SLCUOI FROM TONKHO WHERE MAVTU = MAVT;
END;

DROP PROCEDURE TONKHO;

CALL baitap.TONKHO(5);

CREATE PROCEDURE TIEN_XUAT(IN MAVT INT)
BEGIN SELECT SLXUAT*DGXUAT AS 'TỔNG TIỀN' FROM CTPXUAT WHERE MAVT = MAVT;
END;

CALL TIEN_XUAT(5);



