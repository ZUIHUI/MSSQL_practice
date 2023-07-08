USE 練習08

SET IDENTITY_INSERT 出貨記錄 ON
INSERT 出貨記錄 ( 編號, 日期, 客戶名稱, 書名, 數量)
VALUES ( 9, '2017-11-30', '夢天堂書局', 'Word 手冊', 20)

SET IDENTITY_INSERT 出貨記錄 OFF
SELECT *
FROM 出貨記錄

SET IDENTITY_INSERT 圖書室借用記錄 OFF
INSERT  圖書室借用記錄 ( 員工編號, 書名 )
SELECT A.編號, B.書籍名稱
FROM 員工 AS A, 書籍 AS B
WHERE 職位='辦事員'

SELECT *
FROM 圖書室借用記錄

EXEC sp_datatype_info

CREATE TABLE #datatype_info
(
	TYPE_NAME sysname,
    DATA_TYPE smallint,
    PRECISION int,
    LITERAL_PREFIX CHAR(32),
    LITERAL_SUFFIX CHAR(32),
    CREATE_PARAMS VARCHAR(32),
    NULLABLE smallint,
    CASE_SENSITIVE smallint,
    SEARCHABLE smallint,
    UNSIGNED_ATTRIBUTE smallint,
    MONEY smallint,
    AUTO_INCREMENT smallint,
    LOCAL_TYPE_NAME sysname,
    MINIMUM_SCALE smallint,
    MAXIMUM_SCALE smallint,
    SQL_DATA_TYPE smallint,
    SQL_DATETIME_SUB smallint,
    NUM_PREC_RADIX int,
    INTERVAL_PRECISION smallint,
    USERTYPE smallint
)

INSERT #datatype_info
EXEC sp_datatype_info

CREATE TABLE #datatype_info1
(
	TYPE_NAME sysname,
	PRECISION int,
	DATA_TYPE smallint,
)

INSERT #datatype_info1 (TYPE_NAME, PRECISION, DATA_TYPE)
SELECT TYPE_NAME, PRECISION, DATA_TYPE
FROM #datatype_info
WHERE TYPE_NAME='int' OR TYPE_NAME='smallint' OR TYPE_NAME='char' OR TYPE_NAME='varchar'

SELECT *
FROM #datatype_info1

--SELECT * FROM 客戶
SELECT B.*,A.日期,A.書名,A.數量,A.編號
FROM 出貨記錄 AS A,客戶 AS B
WHERE B.聯絡人 LIKE '陳%' AND A.客戶名稱 = B.客戶名稱

SELECT B.*,A.日期,A.書名,A.數量,A.編號
INTO #詳細借用記錄
FROM 出貨記錄 AS A,客戶 AS B
WHERE B.聯絡人 LIKE '陳%' AND A.客戶名稱 = B.客戶名稱
SELECT * FROM #詳細借用記錄

UPDATE 圖書室借用記錄
SET		數量 += 1,
		附註 = '經理借閱書籍漏記'
WHERE	員工編號 = 2
SELECT *
FROM 圖書室借用記錄

SELECT *
FROM 應徵者
WHERE 自傳 IS NULL

DELETE 應徵者
FROM 應徵者
WHERE 自傳 IS NULL

SELECT *
FROM 應徵者

CREATE TABLE #TEMP
(
    編號 int identity,
    員工編號 int NOT NULL,
    書名 nvarchar(30) NOT NULL,
	數量 int,
	歸還日期 date,
	附註 char(40)
)
--SELECT * FROM 員工
--SELECT * FROM 書籍
--SELECT * FROM 圖書室借用記錄
INSERT INTO 圖書室借用記錄 (員工編號, 書名, 數量, 歸還日期, 附註)
OUTPUT INSERTED.員工編號, INSERTED.書名, INSERTED.數量,INSERTED.歸還日期 INTO #TEMP(員工編號, 書名,數量,歸還日期)
SELECT 2,書籍名稱,1,GETDATE(),null
FROM 書籍
WHERE 書籍名稱 NOT IN (SELECT 書名 FROM 圖書室借用記錄)
SELECT * FROM #TEMP