CREATE DATABASE WhoPanda;
USE master
IF DB_ID('WhoPanda') IS NOT NULL
DROP DATABASE WhoPanda;
GO
CREATE DATABASE WhoPanda;
GO

USE WhoPanda

CREATE TABLE �|�����(
	�Ǹ� CHAR(10) PRIMARY KEY ,
	�t�� CHAR(20),
	�����Ҧr�� CHAR(10) NOT NULL UNIQUE,
	�m�� NVARCHAR(10),
	�W�r NVARCHAR(10),
	�ͤ� DATE,
	�ʧO CHAR(10) DEFAULT 'F',
	�b�Ǫ��A CHAR(10),
	�p���q�� CHAR(10),
	�q�T�a�} CHAR(20),
	UP_TIME DATETIME,
)
CREATE TABLE �I�ڤ覡(
	�d�� CHAR(10) PRIMARY KEY,
	UID CHAR(10),
	�l�B INT,
	�I������ CHAR(20),
	UP_TIME DATETIME,
	FOREIGN KEY(UID) REFERENCES �|�����(�Ǹ�)
)
CREATE TABLE �ӫ~(
	�ӫ~�s�� INT IDENTITY(1,1) PRIMARY KEY,
	�ӫ~�W�� CHAR(20),
	���a�s�� INT,
	���a�W�� CHAR(10),
	��� CHAR(10),
	UP_TIME DATETIME,
)
CREATE TABLE �q��(
	�q��s�� INT IDENTITY(1,1) PRIMARY KEY,
	�q�ʮɶ� DATETIME,
	�ӫ~�s�� INT,
	���a�s�� INT,
	�e�\�a�I CHAR(20),
	UP_TIME DATETIME,
	FOREIGN KEY(�ӫ~�s��) REFERENCES �ӫ~(�ӫ~�s��)
)
CREATE TABLE ���(
	����s�� INT IDENTITY(1,1) PRIMARY KEY,
	�I�ڥd�� CHAR(10),
	�I�ڤ覡 CHAR(10),
	�q�檬�A CHAR(20),
	UP_TIME DATETIME,
	FOREIGN KEY(�I�ڥd��) REFERENCES �I�ڤ覡(�d��)
)

INSERT INTO �|�����(�Ǹ� ,�t�� ,�����Ҧr�� ,�m�� ,�W�r ,�ͤ� ,�ʧO ,�b�Ǫ��A ,�p���q�� ,�q�T�a�},UP_TIME)
VALUES('082214145','��ިt','T0011','�U','�ѧL','2000-11-23','M','�b�Ǥ�','0987987978','���w�j�D�������j�q',GETDATE())
INSERT INTO �|�����(�Ǹ� ,�t�� ,�����Ҧr�� ,�m�� ,�W�r ,�ͤ� ,�ʧO ,�b�Ǫ��A ,�p���q�� ,�q�T�a�},UP_TIME)
VALUES('082214216','��ިt','H0221','�\','�K�K','2002-08-09','F','�b�Ǥ�','0969681130','�ذ������y�֤F��',GETDATE())
INSERT INTO �|�����(�Ǹ� ,�t�� ,�����Ҧr�� ,�m�� ,�W�r ,�ͤ� ,�ʧO ,�b�Ǫ��A ,�p���q�� ,�q�T�a�},UP_TIME)
VALUES('082214588','��ިt','Y0558','�P','�_�C','2001-10-26','M','�b�Ǥ�','0969696969','�����_���W�L�W�p��',GETDATE())


INSERT INTO �I�ڤ覡(�d�� ,UID ,�l�B ,�I������,UP_TIME)
VALUES('001','082214145','5000','�x�Ȫ�',GETDATE())
INSERT INTO �I�ڤ覡(�d�� ,UID ,�l�B ,�I������,UP_TIME)
VALUES('002','082214216','20000','�y�C�d',GETDATE())
INSERT INTO �I�ڤ覡(�d�� ,UID ,�l�B ,�I������,UP_TIME)
VALUES('003','082214588','1000','LINE Pay',GETDATE())

INSERT INTO �ӫ~(�ӫ~�W�� ,���a�s�� ,���a�W�� ,���,UP_TIME)
VALUES('�۵P��','01','�j�T��','85��',GETDATE())
INSERT INTO �ӫ~(�ӫ~�W�� ,���a�s�� ,���a�W�� ,���,UP_TIME)
VALUES('���ƶ�','01','�j�T��','100��',GETDATE())
INSERT INTO �ӫ~(�ӫ~�W�� ,���a�s�� ,���a�W�� ,���,UP_TIME)
VALUES('���z���׶�','01','�j�T��','100��',GETDATE())
INSERT INTO �ӫ~(�ӫ~�W�� ,���a�s�� ,���a�W�� ,���,UP_TIME)
VALUES('��K10��','02','���]��K','60��',GETDATE())
INSERT INTO �ӫ~(�ӫ~�W�� ,���a�s�� ,���a�W�� ,���,UP_TIME)
VALUES('��K20��','02','���]��K','120��',GETDATE())
INSERT INTO �ӫ~(�ӫ~�W�� ,���a�s�� ,���a�W�� ,���,UP_TIME)
VALUES('��K30��','02','���]��K','180��',GETDATE())

INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),1,'���w�j�D�������j�q','01',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),2,'�ذ������y�֤F��','01',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),3,'�ذ������y�֤F��','01',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),4,'�����_���W�L�W�p��','02',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),5,'���w�j�D�������j�q','02',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),6,'�����_���W�L�W�p��','02',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),1,'���w�j�D�������j�q','01',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),2,'�ذ������y�֤F��','01',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),3,'�ذ������y�֤F��','01',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),4,'�����_���W�L�W�p��','02',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),5,'���w�j�D�������j�q','02',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),6,'�����_���W�L�W�p��','02',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),4,'�����_���W�L�W�p��','02',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),5,'���w�j�D�������j�q','02',GETDATE())
INSERT INTO �q��(�q�ʮɶ�,�ӫ~�s��,�e�\�a�I,���a�s��,UP_TIME)
VALUES(GETDATE(),6,'�����_���W�L�W�p��','02',GETDATE())

INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('001','�x�Ȫ�','�w�e�F�æ��ڧ���',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('001','�x�Ȫ�','�w�e�F�æ��ڧ���',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('002','�y�C�d','�~�e���|�����\',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('002','�y�C�d','�w�e�F�æ��ڧ���',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('001','�x�Ȫ�','�\�I�B�e��',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('003','LINE Pay','�w�e�F�æ��ڧ���',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('001','�x�Ȫ�','�w�e�F�æ��ڧ���',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('003','LINE Pay','�w�e�F�æ��ڧ���',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('001','�x�Ȫ�','�w�e�F�æ��ڧ���',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('003','LINE Pay','�~�e���|�����\',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('002','�y�C�d','�w�e�F�æ��ڧ���',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('003','LINE Pay','�w�e�F�æ��ڧ���',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('003','LINE Pay','�\�I�B�e��',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('002','�y�C�d','�~�e���|�����\',GETDATE())
INSERT INTO ���(�I�ڥd�� ,�I�ڤ覡 ,�q�檬�A,UP_TIME)
VALUES('003','LINE Pay','�w�e�F�æ��ڧ���',GETDATE())

UPDATE �|�����
SET �b�Ǫ��A='��Ǥ�'
OUTPUT deleted.�Ǹ�,deleted.�b�Ǫ��A ��b�Ǫ��A,INSERTED.�b�Ǫ��A ���ʫ�b�Ǫ��A
WHERE �Ǹ�='082214145'

SELECT C.����s��,C.�I�ڤ覡,C.�q�檬�A,D.�e�\�a�I,C.�I�ڥd��,B.�I������,E.���a�W��,E.�ӫ~�W��,E.���,CONCAT(A.�m��,' ',A.�W�r) AS �m�W,CONCAT(A.�Ǹ�,'/',A.�ͤ�,'/',A.�ʧO) AS �򥻸�T
FROM �|����� AS A,�I�ڤ覡 AS B,��� AS C,�q�� AS D,�ӫ~ AS E
WHERE A.�Ǹ�=B.UID AND C.�I�ڥd��=B.�d�� AND D.�ӫ~�s��=E.�ӫ~�s�� AND C.�I�ڤ覡=B.�I������ AND C.����s��=D.�q��s��

SELECT C.����s��,C.�I�ڤ覡,C.�q�檬�A,D.�e�\�a�I,C.�I�ڥd��,B.�I������,E.���a�W��,E.�ӫ~�W��,E.���,CONCAT(A.�m��,' ',A.�W�r) AS �m�W,CONCAT(A.�Ǹ�,'/',A.�ͤ�,'/',A.�ʧO) AS �򥻸�T
INTO #PERSONAL_HISTORY
FROM �|����� AS A,�I�ڤ覡 AS B,��� AS C,�q�� AS D,�ӫ~ AS E
WHERE A.�Ǹ�=B.UID AND C.�I�ڥd��=B.�d�� AND D.�ӫ~�s��=E.�ӫ~�s�� AND C.�I�ڤ覡=B.�I������ AND C.����s��=D.�q��s��

SELECT * FROM #PERSONAL_HISTORY

--DROP TABLE #PERSONAL_HISTORY
