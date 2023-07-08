USE master

IF DB_ID ( 'NTUNHS_IM' ) IS NOT NULL
DROP DATABASE NTUNHS_IM;
GO
CREATE DATABASE NTUNHS_IM;  
GO

ALTER AUTHORIZATION ON DATABASE::"NTUNHS_IM" TO [082214145];

USE NTUNHS_IM;


 create table Account(
    BankID    char(5),
    AccID	  char(10)Primary key,
    Balance   int,
    BranchID  char(5),
    AccType   int,
    UP_Date   datetime,
	UP_USER   char(10)
);


	CREATE TABLE Information (
    PersonID  char(10) Primary key,
	AccID     char(10),
    name1	  char(5),
    name2     char(10),
	birth	  date,
    sex       char(5),
    addres    char(20),
    city      char(5),
	country   char(10),
	UP_Date   datetime,
	UP_USER   char(10)
);


 CREATE TABLE Deal (
    AccID     char(10),
    dealID	  char(10) Primary key,
    dealtime  datetime,
    ATMID	  char(5),
    dealType  int,
	deal_in   char(20),
    UP_Date   datetime,
	UP_USER   char(10)
);


 CREATE TABLE Bank (
    BankID    char(5) Primary key,
    Bankname  char(10),
    addres    char(20)
);
/*DROP TABLE Information;*/

ALTER TABLE  Information ADD  CONSTRAINT FK_Account_Information FOREIGN KEY(AccID)
REFERENCES Account (AccID)
GO
ALTER TABLE Deal  ADD  CONSTRAINT FK_Account_Deal FOREIGN KEY(AccID)
REFERENCES Account (AccID)
GO
ALTER TABLE Account  ADD  CONSTRAINT FK_Account_Account FOREIGN KEY(BankID)
REFERENCES Bank (BankID)
GO


INSERT INTO Bank(BankID,Bankname,addres)
VALUES ('001','台灣銀行','中正路333號');
INSERT INTO Bank(BankID,Bankname,addres)
VALUES ('002','玉山銀行','中山路454號');

INSERT INTO Account (BankID, AccID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('001','082214145',5000000, '001',1, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('001','082214146',10000, '002',2, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('001','082214144',200000, '003',1, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('002','082214141',1000000, '004',3, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('002','082214143',2000000, '005',1, GETDATE(),'1111');


INSERT INTO Information(PersonID,AccID, name1, name2, sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('01','082214145','Lan','YI-CHENG', '男','2000-11-23','明德路365號','台北', '台灣',GETDATE(),'1111');
INSERT INTO Information(PersonID,AccID, name1, name2, sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('02','082214146','UU','U-ASD', '男','2000-12-09','明德路187號','新北', '台灣',GETDATE(),'1112');
INSERT INTO Information(PersonID,AccID, name1, name2, sex, birth, addres, city, country, UP_Date, UP_USER)
VALUES ('03','082214144','CHEN','YI-GGG', '女','1999-5-08','明德路254號','淡水', '台灣',GETDATE(),'1113');

INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145','001',GETDATE(), '01',1,'存入金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145','002',GETDATE(), '01',1,'領款金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145','003',GETDATE(), '01',1,'存入金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145','004',GETDATE(), '01',1,'領款金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145','005',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','006',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','007',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','008',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','009',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','010',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','011',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144','012',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144','013',GETDATE(), '03',1,'領款金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144','014',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');


 SELECT A.BankID, B.PersonID, C.AccID ,C.dealID, C.dealtime, C.dealType, C.deal_in
 FROM Account AS A,Information AS B,Deal AS C,Bank AS D
 WHERE B.AccID=C.AccID and B.AccID=A.AccID AND D.BankID=A.BankID 