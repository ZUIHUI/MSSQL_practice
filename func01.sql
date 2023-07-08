--DROP FUNCTION GetdealID
use master

IF DB_ID ( 'func' ) IS NOT NULL
DROP DATABASE func;
GO
CREATE DATABASE func;
GO

USE func;
--1.function
CREATE TYPE ���� AS TABLE  
    ( ����ID varchar(20) , ����W�� nvarchar(20) )  
GO
CREATE FUNCTION �j�M����
(@����ID varchar(20) ,@table ���� readonly)
returns varchar(20)
begin
	declare @name char(20);
	select @name=(select ����W�� from @table where @����ID=����ID);
	RETURN @name;
end
go

--2.function
/*�bSQL 2012�᪺�����p�G�O Insert into ... Select ���ܡA���|�u�����vSelect��Order By*/
/*�ҥH�bFunction�̪�Insert Into ... Select �̦h�[�J ROW_NUMBER()�A�ӱj�������i��Ƨ�*/
CREATE TYPE �Ƨ� AS TABLE  
    ( �m�W varchar(20) , ������� nvarchar(20))  
GO
CREATE FUNCTION SORT
(@temp int ,@table �Ƨ� readonly)
returns @table1 TABLE(�m�W varchar(20) , ������� nvarchar(20),RM INT)
begin
	if(@temp = 1)
		begin 
			insert into @table1
			select �m�W,������� ,ROW_NUMBER() OVER(ORDER BY ������� asc) from @table
		end
	else if(@temp = 2)
		begin 
			insert into @table1
			select �m�W,������� ,ROW_NUMBER() OVER(ORDER BY ������� desc) from @table 
		end
	return
end
go

--3.function
CREATE TYPE �d�߫Ȥ� AS TABLE  
( 
	�q��s�� int,
	�Ȥ�s�� int,
	�U���� varchar(30), 
	���y�W�� varchar(30), 
	���y�ƶq int, 
	�Ȥ�W�� varchar(30), 
	�Ȥ��p���H varchar(30), 
	�Ȥ�a�} varchar(30), 
	�Ȥ�q�� varchar(30)
)  
GO
CREATE FUNCTION �d�߫Ȥ�
(@temp int ,@table �d�߫Ȥ� readonly)
returns TABLE
return(select �q��s��, �U����, ���y�W��, ���y�ƶq, �Ȥ�W��, �Ȥ��p���H, �Ȥ�a�}, �Ȥ�q��
from @table
where �Ȥ�s�� = @temp)
go

--4.function
/*�ϥΪ̩w�q���(Function)����ΨӰ���ק��Ʈw���A���ʧ@�A�ҥH�L�k��@���D�C*/

--5.function

CREATE FUNCTION �b���K�X����(
 @GID CHAR(10),
 @GPWD VARCHAR(10))
returns int
BEGIN
	IF EXISTS(SELECT * FROM Account WHERE AccID=@GID AND PwdID=HASHBYTES('SHA2_512',@GPWD))
		return 1;
	ELSE IF  EXISTS(SELECT * FROM Account WHERE AccID=@GID AND PwdID != HASHBYTES('SHA2_512',@GPWD))
		return 2;
	return 0;
END
GO

--BACKUP DATABASE BANK TO DISK = 'D:\func.bak'; /*�ƥ�*/
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
VALUES ('Lan','YI-CHENG', '�k','2000-11-23','���w��365��','�x�_', 'Taiwan',GETDATE(),'1111');
INSERT INTO Information(name1, name2, sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('UU','U-ASD', '�k','2000-12-09','���w��187��','�s�_', 'Taiwan',GETDATE(),'1112');
INSERT INTO Information(name1, name2,sex, birth, addres, city, country, UP_Date, UP_USER)
VALUES ('CHEN','YI-GGG', '�k','1999-5-08','���w��254��','�H��', 'Taiwan',GETDATE(),'1113');
INSERT INTO Information(name1, name2, sex, birth, addres, city,country, UP_Date, UP_USER)
VALUES ('EE','QWQ', '�k','2000-12-09','���w��187��','�s�_', 'Taiwan',GETDATE(),'1112');
INSERT INTO Information( name1, name2, sex, birth, addres, city, country, UP_Date, UP_USER)
VALUES ('CC','QOQ', '�k','1999-5-08','���w��254��','�H��', 'Taiwan',GETDATE(),'1113');
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
VALUES ('082214145',GETDATE(), '01',1,'�s�J���B--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'��ڪ��B--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'�s�J���B--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '01',1,'��ڪ��B--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214145',GETDATE(), '02',1,'�s�J���B--5000', GETDATE(),'1111');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'�s�J���B--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID,  dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'�s�J���B--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'�s�J���B--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'�s�J���B--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'�s�J���B--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID,  dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214146',GETDATE(), '02',1,'�s�J���B--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID,  dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144',GETDATE(), '03',1,'�s�J���B--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144',GETDATE(), '03',1,'��ڪ��B--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214144',GETDATE(), '03',1,'�s�J���B--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141',GETDATE(), '02',1,'�s�J���B--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141',GETDATE(), '02',1,'�s�J���B--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID, dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143',GETDATE(), '02',1,'�s�J���B--5000', GETDATE(),'1112');
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143',GETDATE(), '03',1,'�s�J���B--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214141',GETDATE(), '03',1,'��ڪ��B--5000', GETDATE(),'1113');
INSERT INTO Deal(AccID,dealtime, ATMID, dealType,deal_in, UP_Date,UP_USER)
VALUES ('082214143',GETDATE(), '03',1,'�s�J���B--5000', GETDATE(),'1113');
GO

ALTER TABLE Deal  ADD  CONSTRAINT FK_Account_Deal FOREIGN KEY(AccID)
REFERENCES Account (AccID)
GO

CREATE TABLE LOG_SEQ(
	SDATE	   varchar(15) NOT NULL PRIMARY KEY, -- ��Ѫ�log����
	LOG_COUNT  varchar(6) NOT NULL --��Ѥ@�@���h�ֵ�log
) 
GO

CREATE TABLE Bank(
    BankID     char(10) NOT NULL PRIMARY KEY,
    BankName   char(10),
	BankAddr   char(50),
);

INSERT INTO Bank (BankID, BankName, BankAddr)
VALUES ('001','���ضl�F','���w��367��');
INSERT INTO Bank (BankID, BankName, BankAddr)
VALUES ('002','�ɤs�Ȧ�','���w�j�D87��');
GO

CREATE TABLE Branch(
    BranchID   char(10) NOT NULL Primary key,
    BranchName char(20),
);

INSERT INTO Branch (BranchID,BranchName)
VALUES ('0011','���ضl�F�x�_����');
INSERT INTO Branch (BranchID,BranchName)
VALUES ('0021','�ɤs�Ȧ�O������');
INSERT INTO Branch (BranchID,BranchName)
VALUES ('0031','�x�W�Ȧ������');
GO

ALTER TABLE Account ADD  CONSTRAINT FK_Account_Branch FOREIGN KEY(BranchID)
REFERENCES Branch (BranchID)
GO

--1.consequence
DECLARE @WTF ����
INSERT INTO @WTF
SELECT * FROM Branch;
DECLARE @ID char(20)
SET @ID = '0021';
SELECT dbo.�j�M����(@ID,@WTF) as ����W��

--2.consequence
DECLARE @sort �Ƨ�
INSERT INTO @sort
SELECT CONCAT(B.name1 ,' ,', B.name2) AS �m�W ,COUNT(*) as ������� 
FROM Account AS A, Information AS B, Deal AS C 
WHERE A.AccID = C.AccID and A.PersonID = B.PersonID
GROUP BY CONCAT(B.name1 ,' ,', B.name2)
DECLARE @NUM char(20)
SET @NUM = '2';
SELECT �m�W,������� FROM dbo.SORT(@NUM,@sort)
GO

--3.consequence
DECLARE @QQ �d�߫Ȥ�
USE �m��09
INSERT INTO @QQ
SELECT �q��.�q��s��,�q��.�Ȥ�s��, �U����, ���y�W��, �ƶq, �Ȥ�W��, �p���H, �a�}, �q��
FROM �q�� 
LEFT JOIN �Ȥ� ON �q��.�Ȥ�s��=�Ȥ�.�Ȥ�s��
LEFT JOIN �q�ʶ��� ON �q��.�q��s��=�q�ʶ���.�q��s��
LEFT JOIN ���y ON ���y.���y�s��=�q�ʶ���.���y�s��
USE func
DECLARE @COS int 
SET @COS = 1
SELECT * FROM �d�߫Ȥ�(@COS,@QQ)
GO

--4.consequence
/*�ϥΪ̩w�q���(Function)����ΨӰ���ק��Ʈw���A���ʧ@�A�ҥH�L�k��@���D�C*/

--5.consequence
DECLARE @gid nvarchar(15)
DECLARE @pwd nvarchar(200)
SET @gid='082214145'
SET @pwd='145'
DECLARE @GGG int
SELECT @GGG = dbo.�b���K�X����(@gid,@pwd)
IF(@GGG = 1)
	SELECT '�b�K���T' AS '�n�J���A';
ELSE IF(@GGG = 2)
	SELECT '�K�X���~' AS '�n�J���A';
ELSE
	SELECT '�b�����s�b' AS '�n�J���A';





