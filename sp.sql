--DROP FUNCTION GetdealID
use master

IF DB_ID ( 'spd' ) IS NOT NULL
DROP DATABASE spd;
GO
CREATE DATABASE spd;
GO

USE spd;
--1.Procedure
CREATE TYPE 分行 AS TABLE  
    ( 分行ID varchar(20) , 分行名稱 nvarchar(20) )  
GO
CREATE Procedure 搜尋分行
(@分行ID varchar(20),@table 分行 readonly)
AS
begin
	select 分行名稱 from @table where @分行ID=分行ID;
end
go

--2.Procedure
CREATE TYPE 排序 AS TABLE  
    ( 姓名 varchar(20) , 交易次數 nvarchar(20))  
GO
CREATE Procedure SORT
(@temp int ,@table 排序 readonly)
AS
begin
	if(@temp = 1)
		begin 
			select 姓名,交易次數 from @table ORDER BY 交易次數 asc
		end
	else if(@temp = 2)
		begin 
			select 姓名,交易次數 from @table ORDER BY 交易次數 DESC
		end
	return
end
go

--3.Procedure
CREATE TYPE 查詢客戶 AS TABLE  
( 
	訂單編號 int,
	客戶編號 int,
	下單日期 varchar(30), 
	書籍名稱 varchar(30), 
	書籍數量 int, 
	客戶名稱 varchar(30), 
	客戶聯絡人 varchar(30), 
	客戶地址 varchar(30), 
	客戶電話 varchar(30)
)  
GO
CREATE Procedure 查詢客戶
(@temp int ,@table 查詢客戶 readonly)
AS
select 訂單編號, 下單日期, 書籍名稱, 書籍數量, 客戶名稱, 客戶聯絡人, 客戶地址, 客戶電話
from @table
where 客戶編號 = @temp
go

--4.Procedure
CREATE PROCEDURE LOGFFF
AS
BEGIN
	DECLARE @DT nvarchar(15)=CONVERT(nvarchar(15),GETDATE(), 112)
	DECLARE @NO nvarchar(30)
	SELECT @NO=(SELECT LOG_COUNT FROM LOG_SEQ WHERE SDATE=@DT)
	IF @NO IS NULL
	BEGIN
		SET @NO='000000'
		INSERT INTO LOG_SEQ VALUES(@DT,@NO)
		RETURN 0 
	END
	ELSE IF @NO IS NOT NULL
	BEGIN
		SET @NO = right('000000'+ CAST( (CAST( @NO AS INT) +1) AS VARCHAR ),6);
		UPDATE LOG_SEQ SET LOG_COUNT = @NO WHERE SDATE = @DT;
		RETURN 0
	END
	ELSE 
	BEGIN
	RETURN 1
	END
END
GO

--5.Procedure

CREATE Procedure 帳號密碼驗證(
 @GID CHAR(10),
 @GPWD VARCHAR(10))
 AS
BEGIN
	IF EXISTS(SELECT * FROM Account WHERE AccID=@GID AND PwdID=HASHBYTES('SHA2_512',@GPWD))
		return 1;
	ELSE IF  EXISTS(SELECT * FROM Account WHERE AccID=@GID AND PwdID != HASHBYTES('SHA2_512',@GPWD))
		return 2;
	return 0;
END
GO

--6.我有在上課 Procedure

CREATE TYPE 我有在上課 AS TABLE 
(
	ID		int,
	拇指	int,
	食指	int,
	中指	int,
	無名指	int,
	小指	int
)  
GO
CREATE Procedure 我有在上課
(@id int ,@table 我有在上課 readonly)
AS
	select *
	from @table
	where ID = @id
GO

--BACKUP DATABASE BANK TO DISK = 'D:\func.bak'; /*備份*/
CREATE FUNCTION GetdealID()
RETURNS nvarchar(20)
AS
BEGIN
  DECLARE @dealIDD nvarchar(20)
  DECLARE @DT nvarchar(20)
  SELECT @DT = convert(nvarchar(20),getdate(),112)
  SELECT @dealIDD= @DT+'_'+ right('00000'+ltrim( isnull(max(cast(right(dealID, 7) as int)),0)+1), 6) from Deal where left(dealID, 8) = @DT
  RETURN @dealIDD
END
GO

CREATE TABLE Account(
    BankID     char(5),
    AccID	   char(10) Primary key,
	PwdID      varchar(200),
	PersonID   int IDENTITY(100000, 2),
    Balance    int,
    BranchID   char(10),
    AccType    int,
    UP_Date    datetime,
	UP_USER    char(10),
);

INSERT INTO Account (BankID, AccID,PwdID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('001','082214145',HASHBYTES('SHA2_512','145'),5000000, '0011',1, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID,PwdID,Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('001','082214146',HASHBYTES('SHA2_512','146'),10000, '0021',2, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID,PwdID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('001','082214144',HASHBYTES('SHA2_512','144'),200000, '0031',1, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID,PwdID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('002','082214141',HASHBYTES('SHA2_512','141'),1000000, '0031',3, GETDATE(),'1111');
INSERT INTO Account (BankID, AccID,PwdID, Balance, BranchID, AccType, UP_Date, UP_USER)
VALUES ('002','082214143',HASHBYTES('SHA2_512','143'),2000000, '0021',1, GETDATE(),'1111');
GO

CREATE TABLE Information (
    PersonID   int IDENTITY(100000, 2)  Primary key,
    name1	   char(5),
    name2      char(10),
	birth	   date CHECK (DATEDIFF(yy,birth,GETDATE())>=18),
    sex        char(5) DEFAULT 'U',
    addres     char(20),
    city       char(5),
	country    char(10),
	UP_Date    datetime,
	UP_USER    char(10),
);

INSERT INTO Information( name1, name2,sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('Lan','YI-CHENG', '男','2000-11-23','明德路365號','台北', 'Taiwan',GETDATE(),'1111');
INSERT INTO Information(name1, name2, sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('UU','U-ASD', '女','2000-12-09','明德路187號','新北', 'Taiwan',GETDATE(),'1112');
INSERT INTO Information(name1, name2,sex, birth, addres, city, country, UP_Date, UP_USER)
VALUES ('CHEN','YI-GGG', '男','1999-5-08','明德路254號','淡水', 'Taiwan',GETDATE(),'1113');
INSERT INTO Information(name1, name2, sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('EE','QWQ', '男','2000-12-09','明德路187號','新北', 'Taiwan',GETDATE(),'1112');
INSERT INTO Information( name1, name2, sex, birth, addres, city, country, UP_Date, UP_USER)
VALUES ('CC','QOQ', '女','1999-5-08','明德路254號','淡水', 'Taiwan',GETDATE(),'1113');
GO

ALTER TABLE Account ADD  CONSTRAINT FK_Account_Information FOREIGN KEY(PersonID)
REFERENCES Information(PersonID)
GO

 CREATE TABLE Deal (
    AccID      char(10),
    dealID	   char(20)default dbo.GetdealID() Primary key,
    dealtime   datetime,
    ATMID	   char(5),
    dealType   int,
	deal_in    char(20),
    UP_Date    datetime,
	UP_USER    char(10)
);
GO

INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'存入金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'領款金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'存入金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'領款金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID,  dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID,  dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID,  dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144',GETDATE(), '03',1,'領款金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141',GETDATE(), '03',1,'領款金額--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
GO

ALTER TABLE Deal  ADD  CONSTRAINT FK_Account_Deal FOREIGN KEY(AccID)
REFERENCES Account (AccID)
GO

CREATE TABLE LOG_SEQ(
	SDATE	   varchar(15) NOT NULL PRIMARY KEY, -- 當天的log紀錄
	LOG_COUNT  varchar(6) NOT NULL --當天一共有多少筆log
) 
GO

CREATE TABLE Bank(
    BankID     char(10) NOT NULL PRIMARY KEY,
    BankName   char(10),
	BankAddr   char(50),
);

INSERT INTO Bank (BankID, BankName, BankAddr)
VALUES ('001','中華郵政','明德路367號');
INSERT INTO Bank (BankID, BankName, BankAddr)
VALUES ('002','玉山銀行','仰德大道87號');
GO

CREATE TABLE Branch(
    BranchID   char(10) NOT NULL Primary key,
    BranchName char(20),
);

INSERT INTO Branch (BranchID,BranchName)
VALUES ('0011','中華郵政台北分行');
INSERT INTO Branch (BranchID,BranchName)
VALUES ('0021','玉山銀行板橋分行');
INSERT INTO Branch (BranchID,BranchName)
VALUES ('0031','台灣銀行桃園分行');
GO

ALTER TABLE Account ADD  CONSTRAINT FK_Account_Branch FOREIGN KEY(BranchID)
REFERENCES Branch (BranchID)
GO

CREATE TABLE RightHand(
	ID		int,
	拇指	int,
	食指	int,
	中指	int,
	無名指	int,
	小指	int,
)
INSERT INTO RightHand VALUES (1,1,0,0,0,0);
INSERT INTO RightHand VALUES (2,0,1,0,0,0);
INSERT INTO RightHand VALUES (3,0,0,1,0,0);
INSERT INTO RightHand VALUES (4,0,0,0,1,0);
INSERT INTO RightHand VALUES (5,0,0,0,0,1);

--1.consequence
DECLARE @WTF 分行
INSERT INTO @WTF
SELECT * FROM Branch;
DECLARE @ID char(20)
SET @ID = '0021';
EXEC 搜尋分行 @ID,@WTF 
GO

--2.consequence
DECLARE @sort 排序
INSERT INTO @sort
SELECT CONCAT(B.name1 ,' ,', B.name2) AS 姓名 ,COUNT(*) as 交易次數 
FROM Account AS A, Information AS B, Deal AS C 
WHERE A.AccID = C.AccID and A.PersonID = B.PersonID
GROUP BY CONCAT(B.name1 ,' ,', B.name2)
DECLARE @NUM char(20)
SET @NUM = '2';
EXEC SORT @NUM,@sort
GO

--3.consequence
DECLARE @QQ 查詢客戶
USE 練習09
INSERT INTO @QQ
SELECT 訂單.訂單編號,訂單.客戶編號, 下單日期, 書籍名稱, 數量, 客戶名稱, 聯絡人, 地址, 電話
FROM 訂單 
LEFT JOIN 客戶 ON 訂單.客戶編號=客戶.客戶編號
LEFT JOIN 訂購項目 ON 訂單.訂單編號=訂購項目.訂單編號
LEFT JOIN 書籍 ON 書籍.書籍編號=訂購項目.書籍編號
USE spd
DECLARE @COS int 
SET @COS = 1
EXEC 查詢客戶 @COS,@QQ
GO

--4.consequence
--4_1
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '03',1,'存入金額--1000', GETDATE(),'1113');
DECLARE @TT nvarchar(15)
EXEC @TT = LOGFFF
IF(@TT = 0)
SELECT '成功' AS '結果'

SELECT * FROM LOG_SEQ
--4_2
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '03',1,'存入金額--1000', GETDATE(),'1113');
EXEC @TT = LOGFFF
IF(@TT = 0)
SELECT '成功' AS '結果'
ELSE
SELECT '失敗' AS '結果'

SELECT * FROM LOG_SEQ

--5.consequence
DECLARE @gid nvarchar(15)
DECLARE @pwd nvarchar(200)
SET @gid='082214145'
SET @pwd='145'
DECLARE @GGG int
EXEC @GGG = 帳號密碼驗證 @gid,@pwd
IF(@GGG = 1)
	SELECT '帳密正確' AS '登入狀態';
ELSE IF(@GGG = 2)
	SELECT '密碼錯誤' AS '登入狀態';
ELSE
	SELECT '帳號不存在' AS '登入狀態';

--6.我有在上課
DECLARE @IDD 我有在上課
INSERT INTO @IDD
SELECT * FROM RightHand
DECLARE @WE INT = 3
EXEC 我有在上課 @WE,@IDD






