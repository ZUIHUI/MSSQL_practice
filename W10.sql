USE 練習10;
--1. 說明: 請使用OUTER　JOIN語法將[訂單]以及[訂購項目]合併，表格輸出顯示結果應與已下程式碼結果一致
SELECT A.訂單編號, A.下單日期, SUM(B.數量) AS 總數量
FROM  訂單 AS A LEFT OUTER JOIN 訂購項目 AS B ON A.訂單編號=B.訂單編號 GROUP BY A.訂單編號, A.下單日期
GO

--2. 查詢欄位中不確定字元語法
SELECT * FROM 標標公司
WHERE 產品名稱 LIKE '%手冊'

--3. 查詢欄位中不確定字元包含在某個範圍語法
SELECT * FROM 標標公司
WHERE 產品名稱 LIKE '%[S,T,U,V,W,X,Y,Z]indows%'

--4.  取代查詢結果替換字串
SELECT * FROM 問卷
SELECT 問卷編號,REPLACE(REPLACE (性別, '0', '女'), '1', '男') AS 性別,REPLACE(REPLACE(REPLACE(滿意度, '1', '差勁'), '2', '尚可'), '3', '滿意') AS 評價
FROM 問卷 ORDER BY 評價 DESC

