USE �m��08

SET IDENTITY_INSERT �X�f�O�� ON
INSERT �X�f�O�� ( �s��, ���, �Ȥ�W��, �ѦW, �ƶq)
VALUES ( 9, '2017-11-30', '�ڤѰ�ѧ�', 'Word ��U', 20)

SET IDENTITY_INSERT �X�f�O�� OFF
SELECT *
FROM �X�f�O��

SET IDENTITY_INSERT �ϮѫǭɥΰO�� OFF
INSERT  �ϮѫǭɥΰO�� ( ���u�s��, �ѦW )
SELECT A.�s��, B.���y�W��
FROM ���u AS A, ���y AS B
WHERE ¾��='��ƭ�'

SELECT *
FROM �ϮѫǭɥΰO��

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

--SELECT * FROM �Ȥ�
SELECT B.*,A.���,A.�ѦW,A.�ƶq,A.�s��
FROM �X�f�O�� AS A,�Ȥ� AS B
WHERE B.�p���H LIKE '��%' AND A.�Ȥ�W�� = B.�Ȥ�W��

SELECT B.*,A.���,A.�ѦW,A.�ƶq,A.�s��
INTO #�ԲӭɥΰO��
FROM �X�f�O�� AS A,�Ȥ� AS B
WHERE B.�p���H LIKE '��%' AND A.�Ȥ�W�� = B.�Ȥ�W��
SELECT * FROM #�ԲӭɥΰO��

UPDATE �ϮѫǭɥΰO��
SET		�ƶq += 1,
		���� = '�g�z�ɾ\���y�|�O'
WHERE	���u�s�� = 2
SELECT *
FROM �ϮѫǭɥΰO��

SELECT *
FROM ���x��
WHERE �۶� IS NULL

DELETE ���x��
FROM ���x��
WHERE �۶� IS NULL

SELECT *
FROM ���x��

CREATE TABLE #TEMP
(
    �s�� int identity,
    ���u�s�� int NOT NULL,
    �ѦW nvarchar(30) NOT NULL,
	�ƶq int,
	�k�٤�� date,
	���� char(40)
)
--SELECT * FROM ���u
--SELECT * FROM ���y
--SELECT * FROM �ϮѫǭɥΰO��
INSERT INTO �ϮѫǭɥΰO�� (���u�s��, �ѦW, �ƶq, �k�٤��, ����)
OUTPUT INSERTED.���u�s��, INSERTED.�ѦW, INSERTED.�ƶq,INSERTED.�k�٤�� INTO #TEMP(���u�s��, �ѦW,�ƶq,�k�٤��)
SELECT 2,���y�W��,1,GETDATE(),null
FROM ���y
WHERE ���y�W�� NOT IN (SELECT �ѦW FROM �ϮѫǭɥΰO��)
SELECT * FROM #TEMP