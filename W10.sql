USE �m��10;
--1. ����: �Шϥ�OUTER�@JOIN�y�k�N[�q��]�H��[�q�ʶ���]�X�֡A����X��ܵ��G���P�w�U�{���X���G�@�P
SELECT A.�q��s��, A.�U����, SUM(B.�ƶq) AS �`�ƶq
FROM  �q�� AS A LEFT OUTER JOIN �q�ʶ��� AS B ON A.�q��s��=B.�q��s�� GROUP BY A.�q��s��, A.�U����
GO

--2. �d����줤���T�w�r���y�k
SELECT * FROM �мФ��q
WHERE ���~�W�� LIKE '%��U'

--3. �d����줤���T�w�r���]�t�b�Y�ӽd��y�k
SELECT * FROM �мФ��q
WHERE ���~�W�� LIKE '%[S,T,U,V,W,X,Y,Z]indows%'

--4.  ���N�d�ߵ��G�����r��
SELECT * FROM �ݨ�
SELECT �ݨ��s��,REPLACE(REPLACE (�ʧO, '0', '�k'), '1', '�k') AS �ʧO,REPLACE(REPLACE(REPLACE(���N��, '1', '�t�l'), '2', '�|�i'), '3', '���N') AS ����
FROM �ݨ� ORDER BY ���� DESC

