USE BANK 

SELECT CONCAT(B.name1 ,' ,', B.name2) AS �m�W ,CONCAT(B.birth,',',B.sex) AS �ͤ�P�ʧO ,CONCAT(B.city,',',B.country) AS �����P��a,A.AccID AS �b��,D.BranchID AS ����b��, A.Balance AS �l�B
FROM Account AS A, Information AS B, Deal AS C, Branch AS D
WHERE B.AccID=C.AccID and B.AccID=A.AccID and A.BranchID=D.BranchID

SELECT CONCAT(B.name1 ,' ,', B.name2) AS �m�W ,COUNT(*) as �������  
FROM Account AS A, Information AS B, Deal AS C, Branch AS D 
WHERE B.AccID=C.AccID and B.AccID=A.AccID and A.BranchID=D.BranchID GROUP BY C.AccID, B.name1, B.name2
