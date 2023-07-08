USE BANK
ALTER DATABASE BANK 
MODIFY FILE ( 
	NAME='BANK_Primary',
	SIZE=16MB,
    MAXSIZE=40MB,
    FILEGROWTH=4MB 
);

CREATE TABLE Branch(
    BranchID    char(5) Primary key,
    Branchname  char(20),
);

INSERT INTO Branch(BranchID, Branchname)
VALUES ('0011','台灣銀行台北分行');
INSERT INTO Branch(BranchID, Branchname)
VALUES ('0021','玉山銀行石牌分行');
INSERT INTO Branch(BranchID, Branchname)
VALUES ('0031','中華郵政明德分局');

--EXEC sp_helpconstraint @objname = 'Information'

ALTER TABLE Information DROP CONSTRAINT DF__Information__sex__25869641; 
ALTER TABLE Information ADD CONSTRAINT df_sex DEFAULT 'M' FOR sex;

ALTER TABLE Deal ADD CONSTRAINT df_DealDate DEFAULT GETDATE() FOR UP_Date;
ALTER TABLE Account ADD CONSTRAINT df_AccountDate DEFAULT GETDATE() FOR UP_Date;
ALTER TABLE Information ADD CONSTRAINT df_InformationDate DEFAULT GETDATE() FOR UP_Date;

ALTER TABLE Information DROP CONSTRAINT chk_Information;
ALTER TABLE Information ADD CONSTRAINT chk_Information CHECK (country='Taiwan');

ALTER TABLE Deal  ADD  CONSTRAINT FK_Account_Deal FOREIGN KEY(AccID)
REFERENCES Account (AccID)
GO
ALTER TABLE Account with check ADD CONSTRAINT FK_Account_BranchID FOREIGN KEY(BranchID)
REFERENCES Branch (BranchID)
GO

