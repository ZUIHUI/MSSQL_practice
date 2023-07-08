USE BANK 

SELECT CONCAT(B.name1 ,' ,', B.name2) AS 姓名 ,CONCAT(B.birth,',',B.sex) AS 生日與性別 ,CONCAT(B.city,',',B.country) AS 城市與國家,A.AccID AS 帳號,D.BranchID AS 分行帳號, A.Balance AS 餘額
FROM Account AS A, Information AS B, Deal AS C, Branch AS D
WHERE B.AccID=C.AccID and B.AccID=A.AccID and A.BranchID=D.BranchID

SELECT CONCAT(B.name1 ,' ,', B.name2) AS 姓名 ,COUNT(*) as 交易次數  
FROM Account AS A, Information AS B, Deal AS C, Branch AS D 
WHERE B.AccID=C.AccID and B.AccID=A.AccID and A.BranchID=D.BranchID GROUP BY C.AccID, B.name1, B.name2
