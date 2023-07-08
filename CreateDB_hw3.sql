--DROP FUNCTION GetdealID

USE master
IF DB_ID ( 'HW3' ) IS NOT NULL
DROP DATABASE HW3
GO
CREATE DATABASE HW3
GO

USE HW3
GO
--BACKUP DATABASE BANK TO DISK = 'D:\HW3.bak'; /*備份*/
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
	PwdID     varchar(200),
    name1	  char(5),
    name2     char(10),
	birth	  date CHECK (DATEDIFF(yy,birth,GETDATE())>=18),
    sex       char(5) DEFAULT 'U',
    addres    char(20),
    city      char(5),
	country   char(10),
	UP_Date   datetime,
	UP_USER   char(10),
);

 CREATE TABLE Deal (
    AccID     char(10),
    dealID	  char(20)default dbo.GetdealID() Primary key,
    dealtime  datetime,
    ATMID	  char(5),
    dealType  int,
	deal_in   char(20),
    UP_Date   datetime,
	UP_USER   char(10)
);
GO

CREATE TABLE LOG_SEQ(
  SDATE varchar(15) NOT NULL PRIMARY KEY, -- 當天的log紀錄
  LOG_COUNT varchar(6) NOT NULL --當天一共有多少筆log
) 
GO

CREATE PROCEDURE LOGFFF
AS
BEGIN
	DECLARE @DT nvarchar(15)=CONVERT(nvarchar(15),GETDATE(), 112)
	IF NOT EXISTS(SELECT * FROM LOG_SEQ WHERE SDATE=@DT)
	BEGIN
		TRUNCATE TABLE LOG_SEQ;
		INSERT INTO LOG_SEQ(SDATE,LOG_COUNT) VALUES(@DT,0);
		UPDATE LOG_SEQ SET LOG_COUNT=LOG_COUNT+1;
	END
	ELSE IF  EXISTS(SELECT * FROM LOG_SEQ WHERE SDATE=@DT)
	BEGIN
		UPDATE LOG_SEQ SET LOG_COUNT=LOG_COUNT+1;
	END
END
GO

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
GO

INSERT INTO Information(AccID,PwdID, name1, name2,sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('082214145',HASHBYTES('SHA2_512','145'),'Lan','YI-CHENG', '男','2000-11-23','明德路365號','台北', 'Taiwan',GETDATE(),'1111');
INSERT INTO Information(AccID,PwdID, name1, name2, sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('082214146',HASHBYTES('SHA2_512','146'),'UU','U-ASD', '女','2000-12-09','明德路187號','新北', 'Taiwan',GETDATE(),'1112');
INSERT INTO Information(AccID,PwdID, name1, name2,sex, birth, addres, city, country, UP_Date, UP_USER)
VALUES ('082214144',HASHBYTES('SHA2_512','144'),'CHEN','YI-GGG', '男','1999-5-08','明德路254號','淡水', 'Taiwan',GETDATE(),'1113');
INSERT INTO Information(AccID,PwdID, name1, name2, sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('082214141',HASHBYTES('SHA2_512','141'),'EE','QWQ', '男','2000-12-09','明德路187號','新北', 'Taiwan',GETDATE(),'1112');
INSERT INTO Information(AccID,PwdID, name1, name2, sex, birth, addres, city, country, UP_Date, UP_USER)
VALUES ('082214143',HASHBYTES('SHA2_512','143'),'CC','QOQ', '女','1999-5-08','明德路254號','淡水', 'Taiwan',GETDATE(),'1113');
GO


INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'存入金額--5000', GETDATE(),'1111');
EXEC LOGFFF;
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'領款金額--5000', GETDATE(),'1111');
EXEC LOGFFF;
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'存入金額--5000', GETDATE(),'1111');
EXEC LOGFFF;
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'領款金額--5000', GETDATE(),'1111');
EXEC LOGFFF;
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1111');
EXEC LOGFFF;
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
EXEC LOGFFF;
INSERT INTO Deal(AccID,  dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
EXEC LOGFFF;
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
EXEC LOGFFF;
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
EXEC LOGFFF;
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
EXEC LOGFFF;
INSERT INTO Deal(AccID,  dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
EXEC LOGFFF;
INSERT INTO Deal(AccID,  dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
EXEC LOGFFF;
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144',GETDATE(), '03',1,'領款金額--5000', GETDATE(),'1113');
EXEC LOGFFF;
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
EXEC LOGFFF;
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
EXEC LOGFFF;
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
EXEC LOGFFF;
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143',GETDATE(), '02',1,'存入金額--5000', GETDATE(),'1112');
EXEC LOGFFF;
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
EXEC LOGFFF;
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141',GETDATE(), '03',1,'領款金額--5000', GETDATE(),'1113');
EXEC LOGFFF;
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143',GETDATE(), '03',1,'存入金額--5000', GETDATE(),'1113');
EXEC LOGFFF;
GO

ALTER TABLE Information ADD  CONSTRAINT FK_Account_Information FOREIGN KEY(AccID)
REFERENCES Account(AccID)
GO
ALTER TABLE Deal  ADD  CONSTRAINT FK_Account_Deal FOREIGN KEY(AccID)
REFERENCES Account (AccID)
GO

SELECT * FROM Deal
SELECT * FROM LOG_SEQ
SELECT * FROM Information

DECLARE @GID CHAR(10)
DECLARE @GPWD VARCHAR(10)
SET @GID='082214145'
SET @GPWD='145'
IF EXISTS(SELECT * FROM Information WHERE AccID=@GID AND PwdID=HASHBYTES('SHA2_512',@GPWD))
BEGIN SELECT @GID AS '輸入帳號',@GPWD AS '輸入密碼','密碼正確' AS '登入狀態' END
ELSE BEGIN SELECT @GID AS '輸入帳號',@GPWD AS '輸入密碼','密碼錯誤' AS '登入狀態' END
GO