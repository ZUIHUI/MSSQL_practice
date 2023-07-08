USE master
IF DB_ID ( 'BANK' ) IS NOT NULL
DROP DATABASE BANK;

CREATE DATABASE BANK
ON PRIMARY             /*修改*/
( NAME='BANK_Primary',
  FILENAME=
   'D:\MSSQL_DB\BANK.mdf',
    SIZE=4MB,
    MAXSIZE=10MB,
    FILEGROWTH=1MB
)
LOG ON
  ( NAME='BANK_log',
    FILENAME =
        'D:\MSSQL_DB\BANK_log.ldf'
)

EXEC sp_detach_db BANK /*卸離*/

CREATE DATABASE BANK
ON PRIMARY             /*修改*/
( NAME='BANK_Primary',
  FILENAME=
   'D:\MSSQL_DB\BANK.mdf',
    SIZE=4MB,
    MAXSIZE=10MB,
    FILEGROWTH=1MB
)
LOG ON
  ( NAME='BANK_log',
    FILENAME =
        'D:\MSSQL_DB\BANK_log.ldf'
)
FOR ATTACH;


--BACKUP DATABASE BANK TO DISK = 'D:\BANK.bak'; /*備份*/

USE BANK

CREATE FUNCTION GetdealID()
RETURNS nvarchar(20)
AS
BEGIN
  DECLARE @dealIDD nvarchar(20)
  DECLARE @DT nvarchar(20)
  SELECT @DT = convert(varchar(10),getdate(),112)
  SELECT @dealIDD= @DT+'_'+ right('0000'+ltrim( isnull(max(cast(right(dealID, 6) as int)),1)+1), 5) from Deal where left(dealID, 8) = @DT
  RETURN @dealIDD
END
GO

create table Account(
    BankID    char(5),
    AccID	  char(10) Primary key,
    Balance   int,
    BranchID  char(5),
    AccType   int,
    UP_Date   datetime,
	UP_USER   char(10),
);

CREATE TABLE Information (
    PersonID  int IDENTITY(100000, 2)  Primary key,
	AccID     char(10),
    name1	  char(5),
    name2     char(10),
	birth	  date,
    sex       char(5) DEFAULT 'U',
    addres    char(20),
    city      char(5),
	country   char(10),
	UP_Date   datetime,
	UP_USER   char(10),
	CONSTRAINT chk_Information CHECK(birth <='2003-01-01')
);

 CREATE TABLE Deal (
    AccID     char(10),
    dealID	  char(20) default dbo.GetdealID() Primary key,
    dealtime  datetime,
    ATMID	  char(5),
    dealType  int,
	deal_in   char(20),
    UP_Date   datetime,
	UP_USER   char(10)
);


INSERT INTO Account (BankID, AccID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('001','082214145',5000000, '0011',1, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('001','082214146',10000, '0021',2, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('001','082214144',200000, '0031',1, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('002','082214141',1000000, '0031',3, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('002','082214143',2000000, '0021',1, GETDATE(),'1111');

INSERT INTO Information(AccID, name1, name2,sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('082214145','Lan','YI-CHENG', '男','2000-11-23','明德路365號','台北', 'Taiwan',GETDATE(),'1111');
INSERT INTO Information(AccID, name1, name2, sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('082214146','UU','U-ASD', '女','2004-12-09','明德路187號','新北', 'Taiwan',GETDATE(),'1112');
INSERT INTO Information(AccID, name1, name2,sex, birth, addres, city, country, UP_Date, UP_USER)
VALUES ('082214144','CHEN','YI-GGG', '男','1999-5-08','明德路254號','淡水', 'Taiwan',GETDATE(),'1113');
INSERT INTO Information(AccID, name1, name2, sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('082214141','EE','QWQ', '男','2004-12-09','明德路187號','新北', 'Taiwan',GETDATE(),'1112');
INSERT INTO Information(AccID, name1, name2, sex, birth, addres, city, country, UP_Date, UP_USER)
VALUES ('082214143','CC','QOQ', '女','1999-5-08','明德路254號','淡水', 'Taiwan',GETDATE(),'1113');

INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'存入金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'領款金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145','@dealID',GETDATE(), '01',1,'存入金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145','@dealID',GETDATE(), '01',1,'領款金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145','@dealID',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','@dealID',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','@dealID',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','@dealID',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','@dealID',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','@dealID',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146','@dealID',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144','@dealID',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144','@dealID',GETDATE(), '03',1,'領款金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144','@dealID',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141','@dealID',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141','@dealID',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143','@dealID',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143','@dealID',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141','@dealID',GETDATE(), '03',1,'領款金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID, dealID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143','@dealID',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');

ALTER TABLE Information ADD  CONSTRAINT FK_Account_Information FOREIGN KEY(AccID)
REFERENCES Account(AccID)
GO

select * from Deal