USE �m��10

-- �l�d��
-- (1) �������� - �l�d�ߦ^�Ǭ��ƭ�
-- (2) ���M�� - �l�d�ߦ^�Ǭ��M��(���)
-- (3) ���զs�b - �ϥιB��l�P�_���l�d�ߦ^�ǬO�_���s�b: True or False

-- (1) �������� - �l�d�ߦ^�Ǭ��ƭȡA�f�tSUM���
-- P10-7
SELECT �q��s��, �U����, 
       �`�ƶq = (SELECT SUM(�ƶq) 
                 FROM  �q�ʶ��� 
                 WHERE �q��s�� = �q��.�q��s��)
FROM   �q��
GO
-- P10-8
SELECT ���~�W��, 
       �ʤ��� = ���� * 100 / ( SELECT SUM (����) FROM �мФ��q ) 
FROM �мФ��q
--�l�d�ߵ��G
SELECT SUM (����) FROM �мФ��q
GO
-- (1) �������� - �l�d�ߦ^�Ǭ��ƭȡA�f�tMAX���
-- P10-9a
SELECT ���~�W��, ���� 
FROM    �X�X���q 
WHERE ���� > ( 443 ) 
--�l�d�ߵ��G
SELECT AVG(����) FROM  �мФ��q
GO

--------------------------------------
-- (2) ���M�� - �l�d�ߦ^�Ǭ��M��(���) - �ϥ�IN
-- P10-9b
SELECT * 
FROM �мФ��q 
WHERE ���~�W�� IN ( SELECT *
                    FROM �X�X���q ) 
SELECT * 
FROM �мФ��q 
WHERE ���~�W�� IN ('Windows �ϥΤ�U','Linux �[�����','JAVA �{���y��')
--�l�d�ߵ��G
SELECT * FROM �X�X���q
GO

-- (2) ���M�� - �l�d�ߦ^�Ǭ��M��(���) - �ϥ�ALL 
-- P10-10a
SELECT ���� 
FROM �мФ��q 
WHERE ���� <= ALL ( SELECT ����   
                    FROM  �X�X���q 
                    WHERE ���� > 410)
--�l�d�ߵ��G
SELECT ����
FROM  �X�X���q
WHERE ���� > 410
GO

-- (2) ���M�� - �l�d�ߦ^�Ǭ��M��(���) - �ϥ�ANY
-- P10-10b
SELECT ���� 
FROM �мФ��q 
WHERE ���� <= SOME ( SELECT ����
                    FROM �X�X���q 
                    WHERE ���� > 410 ) 
--�l�d�ߵ��G
SELECT *
FROM �X�X���q 
WHERE ���� > 410 
GO

-- P10-11a
SELECT * 
FROM �мФ��q 
WHERE EXISTS ( SELECT * 
               FROM �X�X���q 
               WHERE ���~�W�� = �мФ��q.���~�W�� AND ���� > 495) 
SELECT * 
FROM �мФ��q 
WHERE ���~�W�� = 'Linux �[�����'

--�l�d�ߵ��G
SELECT * 
FROM �X�X���q
WHERE ���� > 495 

--�ۦP�\�઺���P�d�ߤ覡
-- P10-11b

SELECT �мФ��q.* 
FROM �мФ��q JOIN �X�X���q ON �мФ��q.���~�W�� = �X�X���q.���~�W��
WHERE �X�X���q.���� <401 

SELECT �мФ��q.*, �X�X���q.*
FROM �мФ��q JOIN �X�X���q ON �мФ��q.���~�W�� = �X�X���q.���~�W��
GO

-- P10-11c
SELECT * 
FROM �мФ��q 
WHERE ���~�W�� IN (SELECT ���~�W�� 
                   FROM �X�X���q 
                   WHERE ���� > 495)
SELECT * 
FROM �мФ��q 
WHERE ���~�W�� IN ('Windows �ϥΤ�U')

--�l�d�ߵ��G
SELECT ���~�W��
FROM �X�X���q 
WHERE ���� > 495

--����
-- �мФ��q JOIN �X�X���q ON �мФ��q.���~�W�� = �X�X���q.���~�W�� 
-- ���� 
-- WHERE �мФ��q.���~�W�� = �X�X���q.���~�W��

GO

--P10-12a
SELECT *
FROM �мФ��q
WHERE ���~�W�� IN (SELECT ���~�W��
                   FROM �X�X���q)
GO
-- P10-12b
SELECT * 
FROM �X�X���q 
WHERE ���~�W�� IN (SELECT ���~�W��   
                   FROM �мФ��q  
                   WHERE �X�X���q.���� > (SELECT COUNT(�ѦW) 
										  FROM �ɾ\�M��
										  WHERE ����>1)
			       ) 

GO

-- T-SQL �B��l
-- (1) ���w�B��l: = 
-- (2) ��ƹB��l
   --  �[�B��B���B��
-- (3) ����B��l
 -- ����    =,
 -- ������  !=, <>
 -- �j��    >, >=,  --- => ????
 -- �p��    <. <=,  --- =< ????
-- (4) �޿�B��l
 -- ALL, ANY, SOME, 
 -- EXISTS
 -- AND, OR
 -- BETWEEN 
 -- IN
 -- LIKE
  -- �ɥR���:
   -- _���u
   -- [ ], [^] -- ���w�d�� 
 -- NOT
-- P10-36a

-- (2) ��ƹB��l
   --  �[�B��B���B��
SELECT ���y�W��, ����, ���� AS Price, ���� * 0.75 AS �S�f��
FROM ���y

SELECT *
FROM ���y
GO

-- �d��: ����p��
 -- ���I: CAST - �D�n���A�ഫ
 -- ���I: CONVERT - �q�`�Φb�ɶ��榡�ഫ �r��<--->�ɶ�

-- P10-36b
PRINT CAST('2/20/2016' AS DATETIME) +1 
PRINT CAST('2/20/2016' AS DATETIME) + 3.25 

-- �ɥR
DECLARE @data1 varchar(30)='123';
DECLARE @data2 varchar(30)='456';
SELECT @data1+@data2;

SELECT cast(@data1 AS int) + cast(@data2 AS int);

--�����}�Ghttps://kknews.cc/code/ga46yp8.html

GO
-- P10-37a

SELECT ���y�W��, ����
FROM ���y
WHERE ���� >= 390

GO
-- P10-37b

SELECT ���y�W��, ����
FROM ���y 
WHERE ���y�W�� = 'AutoCAD �q��ø�ϻP�Ͼ�'

GO
-- P10-38a

SELECT * 
FROM �X�X���q 
WHERE (���� > 450 AND ���� < 500) OR ���� < 430

GO
-- P10-48b

SELECT * 
FROM �X�X���q 
WHERE ���� BETWEEN 420 AND 510
 
SELECT * 
FROM �X�X���q 
WHERE ���� >=420 AND ���� <=510 

GO
--P10-38c

SELECT * 
FROM �мФ��q 
WHERE ���~�W�� IN ( 'SQL ���O�_��', 'AutoCAD �о�', 'Linux ��U' ) 

 -- LIKE
  -- �ɥR���:
   -- _���u - �����T�r
   -- [ ], [^] -- ���w�d�� 
-- P10-39
SELECT * 
FROM �мФ��q 
WHERE ���~�W�� LIKE '[a-z]indows'

GO
-- P10-40a

SELECT  * 
FROM  �мФ��q
WHERE  NOT EXISTS ( SELECT  *  
                    FROM  �X�X���q 
                    WHERE  ���~�W�� = �мФ��q.���~�W��)

GO
-- P10-40b

PRINT 59 & 12 
PRINT 59 | 12 
PRINT 59 ^ 12 

GO
-- P10-41a
-- CONVERT varchar style: 
--- cast vs convert????
SELECT 'Linux �[����Ȫ�����O ' + CONVERT(varchar, ����,0) + ' ��' 
FROM �мФ��q 
WHERE ���~�W�� = 'Linux �[�����' 

SELECT 'Linux �[����Ȫ�����O ' + CONVERT(varchar, ����,1) + ' ��' 
FROM �мФ��q 
WHERE ���~�W�� = 'Linux �[�����' 

SELECT 'Linux �[����Ȫ�����O ' + CONVERT(varchar, ����,2) + ' ��' 
FROM �мФ��q 
WHERE ���~�W�� = 'Linux �[�����' 

SELECT * FROM �мФ��q 

UPDATE �мФ��q
SET ���� = 115432 
WHERE ���~�W�� = 'Linux �[�����'

-- �ѦҸ��https://www.w3schools.com/sql/func_sqlserver_convert.asp

GO

UPDATE ���y
SET ���� += 100 
WHERE ���y�W�� = 'Windows Server �t�ι��'


GO

-- P10-43
SET ANSI_NULLS OFF
SELECT * 
FROM ���u 
WHERE �D�޽s�� = NULL

GO

-- P10-44
SELECT �m�W,
       ISNULL(CAST(�D�޽s�� AS VARCHAR), 'Nono') AS �D��
FROM ���u

SELECT *
FROM ���u
WHERE �D�޽s�� IS NULL
GO
-- P10-45a

SELECT * 
FROM ���u
WHERE �D�޽s�� IS NULL 

GO

-- P10-45b
UPDATE ���u
SET �D�޽s�� = 0
WHERE �D�޽s�� IS NULL 

GO
-- P10-45c

SELECT *
FROM ���u
WHERE �D�޽s�� IS NOT NULL

GO

-------------------------------------------------------------
-- P10-46

SELECT IIF(�ʧO=0, '�k', '�k') AS �ʧO, ���N��, COUNT(*) AS �H��
FROM �ݨ�
GROUP BY �ʧO, ���N��  -- �̩ʧO�κ��N�פ��խp��
ORDER BY �ʧO, ���N��

SELECT *
FROM �ݨ�
GO
-- P10-47a

SELECT IIF(���N��=3, '���N', IIF(���N��=2, '�|�i', '�t�l')) ����, COUNT(*) �H��
FROM �ݨ�
GROUP BY ���N��  -- �̺��N�פ��խp��
ORDER BY ���N�� DESC

GO
-- P10-47b

SELECT CHOOSE(���N��, '�t�l', '�|�i', '���N') ����, COUNT(*) �H��
FROM �ݨ�
GROUP BY ���N��  -- �̺��N�פ��խp��
ORDER BY ���N�� DESC

GO