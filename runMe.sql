CREATE DATABASE WhoPanda;
USE master
IF DB_ID('WhoPanda') IS NOT NULL
DROP DATABASE WhoPanda;
GO
CREATE DATABASE WhoPanda;
GO

USE WhoPanda

CREATE TABLE 會員資料(
	學號 CHAR(10) PRIMARY KEY ,
	系所 CHAR(20),
	身分證字號 CHAR(10) NOT NULL UNIQUE,
	姓氏 NVARCHAR(10),
	名字 NVARCHAR(10),
	生日 DATE,
	性別 CHAR(10) DEFAULT 'F',
	在學狀態 CHAR(10),
	聯絡電話 CHAR(10),
	通訊地址 CHAR(20),
	UP_TIME DATETIME,
)
CREATE TABLE 付款方式(
	卡號 CHAR(10) PRIMARY KEY,
	UID CHAR(10),
	餘額 INT,
	付款類型 CHAR(20),
	UP_TIME DATETIME,
	FOREIGN KEY(UID) REFERENCES 會員資料(學號)
)
CREATE TABLE 商品(
	商品編號 INT IDENTITY(1,1) PRIMARY KEY,
	商品名稱 CHAR(20),
	店家編號 INT,
	店家名稱 CHAR(10),
	單價 CHAR(10),
	UP_TIME DATETIME,
)
CREATE TABLE 訂單(
	訂單編號 INT IDENTITY(1,1) PRIMARY KEY,
	訂購時間 DATETIME,
	商品編號 INT,
	店家編號 INT,
	送餐地點 CHAR(20),
	UP_TIME DATETIME,
	FOREIGN KEY(商品編號) REFERENCES 商品(商品編號)
)
CREATE TABLE 交易(
	交易編號 INT IDENTITY(1,1) PRIMARY KEY,
	付款卡號 CHAR(10),
	付款方式 CHAR(10),
	訂單狀態 CHAR(20),
	UP_TIME DATETIME,
	FOREIGN KEY(付款卡號) REFERENCES 付款方式(卡號)
)

INSERT INTO 會員資料(學號 ,系所 ,身分證字號 ,姓氏 ,名字 ,生日 ,性別 ,在學狀態 ,聯絡電話 ,通訊地址,UP_TIME)
VALUES('082214145','資管系','T0011','顧','天兵','2000-11-23','M','在學中','0987987978','仰德大道中央分隔島',GETDATE())
INSERT INTO 會員資料(學號 ,系所 ,身分證字號 ,姓氏 ,名字 ,生日 ,性別 ,在學狀態 ,聯絡電話 ,通訊地址,UP_TIME)
VALUES('082214216','資管系','H0221','許','嘿嘿','2002-08-09','F','在學中','0969681130','建國路但後座少了尼',GETDATE())
INSERT INTO 會員資料(學號 ,系所 ,身分證字號 ,姓氏 ,名字 ,生日 ,性別 ,在學狀態 ,聯絡電話 ,通訊地址,UP_TIME)
VALUES('082214588','資管系','Y0558','周','北七','2001-10-26','M','在學中','0969696969','中正北路上無名小店',GETDATE())


INSERT INTO 付款方式(卡號 ,UID ,餘額 ,付款類型,UP_TIME)
VALUES('001','082214145','5000','儲值金',GETDATE())
INSERT INTO 付款方式(卡號 ,UID ,餘額 ,付款類型,UP_TIME)
VALUES('002','082214216','20000','悠遊卡',GETDATE())
INSERT INTO 付款方式(卡號 ,UID ,餘額 ,付款類型,UP_TIME)
VALUES('003','082214588','1000','LINE Pay',GETDATE())

INSERT INTO 商品(商品名稱 ,店家編號 ,店家名稱 ,單價,UP_TIME)
VALUES('招牌飯','01','大三元','85元',GETDATE())
INSERT INTO 商品(商品名稱 ,店家編號 ,店家名稱 ,單價,UP_TIME)
VALUES('雞排飯','01','大三元','100元',GETDATE())
INSERT INTO 商品(商品名稱 ,店家編號 ,店家名稱 ,單價,UP_TIME)
VALUES('蔥爆牛肉飯','01','大三元','100元',GETDATE())
INSERT INTO 商品(商品名稱 ,店家編號 ,店家名稱 ,單價,UP_TIME)
VALUES('鍋貼10顆','02','阿財鍋貼','60元',GETDATE())
INSERT INTO 商品(商品名稱 ,店家編號 ,店家名稱 ,單價,UP_TIME)
VALUES('鍋貼20顆','02','阿財鍋貼','120元',GETDATE())
INSERT INTO 商品(商品名稱 ,店家編號 ,店家名稱 ,單價,UP_TIME)
VALUES('鍋貼30顆','02','阿財鍋貼','180元',GETDATE())

INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),1,'仰德大道中央分隔島','01',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),2,'建國路但後座少了尼','01',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),3,'建國路但後座少了尼','01',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),4,'中正北路上無名小店','02',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),5,'仰德大道中央分隔島','02',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),6,'中正北路上無名小店','02',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),1,'仰德大道中央分隔島','01',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),2,'建國路但後座少了尼','01',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),3,'建國路但後座少了尼','01',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),4,'中正北路上無名小店','02',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),5,'仰德大道中央分隔島','02',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),6,'中正北路上無名小店','02',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),4,'中正北路上無名小店','02',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),5,'仰德大道中央分隔島','02',GETDATE())
INSERT INTO 訂單(訂購時間,商品編號,送餐地點,店家編號,UP_TIME)
VALUES(GETDATE(),6,'中正北路上無名小店','02',GETDATE())

INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('001','儲值金','已送達並扣款完成',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('001','儲值金','已送達並扣款完成',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('002','悠遊卡','外送員尚未取餐',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('002','悠遊卡','已送達並扣款完成',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('001','儲值金','餐點運送中',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('003','LINE Pay','已送達並扣款完成',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('001','儲值金','已送達並扣款完成',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('003','LINE Pay','已送達並扣款完成',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('001','儲值金','已送達並扣款完成',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('003','LINE Pay','外送員尚未取餐',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('002','悠遊卡','已送達並扣款完成',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('003','LINE Pay','已送達並扣款完成',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('003','LINE Pay','餐點運送中',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('002','悠遊卡','外送員尚未取餐',GETDATE())
INSERT INTO 交易(付款卡號 ,付款方式 ,訂單狀態,UP_TIME)
VALUES('003','LINE Pay','已送達並扣款完成',GETDATE())

UPDATE 會員資料
SET 在學狀態='休學中'
OUTPUT deleted.學號,deleted.在學狀態 原在學狀態,INSERTED.在學狀態 異動後在學狀態
WHERE 學號='082214145'

SELECT C.交易編號,C.付款方式,C.訂單狀態,D.送餐地點,C.付款卡號,B.付款類型,E.店家名稱,E.商品名稱,E.單價,CONCAT(A.姓氏,' ',A.名字) AS 姓名,CONCAT(A.學號,'/',A.生日,'/',A.性別) AS 基本資訊
FROM 會員資料 AS A,付款方式 AS B,交易 AS C,訂單 AS D,商品 AS E
WHERE A.學號=B.UID AND C.付款卡號=B.卡號 AND D.商品編號=E.商品編號 AND C.付款方式=B.付款類型 AND C.交易編號=D.訂單編號

SELECT C.交易編號,C.付款方式,C.訂單狀態,D.送餐地點,C.付款卡號,B.付款類型,E.店家名稱,E.商品名稱,E.單價,CONCAT(A.姓氏,' ',A.名字) AS 姓名,CONCAT(A.學號,'/',A.生日,'/',A.性別) AS 基本資訊
INTO #PERSONAL_HISTORY
FROM 會員資料 AS A,付款方式 AS B,交易 AS C,訂單 AS D,商品 AS E
WHERE A.學號=B.UID AND C.付款卡號=B.卡號 AND D.商品編號=E.商品編號 AND C.付款方式=B.付款類型 AND C.交易編號=D.訂單編號

SELECT * FROM #PERSONAL_HISTORY

--DROP TABLE #PERSONAL_HISTORY
