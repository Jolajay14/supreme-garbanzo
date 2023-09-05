--CREATE DATABASE PrescriptionsDB;      --- Part 1 Creating the PrescriptionsDB database

--USE PrescriptionsDB;
--GO

--ALTER TABLE dbo.Prescriptions  ----adding the foreign key constraints
--ADD FOREIGN KEY (PRACTICE_CODE) REFERENCES dbo.Medical_Practice(PRACTICE_CODE);

--ALTER TABLE dbo.Prescriptions
--ADD FOREIGN KEY (BNF_CODE) REFERENCES dbo.Drugs(BNF_CODE);

--SELECT *        --Part 2 
--FROM dbo.Drugs
--WHERE BNF_DESCRIPTION LIKE '%tablets%' OR BNF_DESCRIPTION 
--LIKE '%capsules%';

--SELECT PRESCRIPTION_CODE, ROUND(QUANTITY * ITEMS, 0)  --Part 3
--AS TOTAL_QUANTITY
--FROM dbo.PRESCRIPTIONS;

--SELECT DISTINCT CHEMICAL_SUBSTANCE_BNF_DESCR    --Part 4
--FROM dbo.Drugs


--SELECT dr.BNF_CHAPTER_PLUS_CODE, COUNT(pr.PRESCRIPTION_CODE)  --Part 5
--AS NUMBER_OF_PRESCRIPTIONS,
--AVG(pr.ACTUAL_COST) AS AVERAGE_COST,
--MAX(pr.ACTUAL_COST) AS MAXIMUM_COST,
--MIN(pr.ACTUAL_COST) AS MINIMUM_COST
--FROM Drugs AS dr INNER JOIN Prescriptions AS pr
--ON dr.BNF_CODE = pr.BNF_CODE
--GROUP BY dr.BNF_CHAPTER_PLUS_CODE;

--SELECT mp.PRACTICE_NAME, p.PRESCRIPTION_CODE, p.ACTUAL_COST    ---Part 6
--FROM (
--  SELECT PRACTICE_CODE, MAX(ACTUAL_COST) AS MAX_COST
--  FROM dbo.Prescriptions
--  GROUP BY PRACTICE_CODE
--) a
--JOIN dbo.Prescriptions p ON a.PRACTICE_CODE = p.PRACTICE_CODE 
--AND a.MAX_COST = p.ACTUAL_COST
--JOIN dbo.Medical_Practice mp ON p.PRACTICE_CODE = mp.PRACTICE_CODE
--WHERE p.ACTUAL_COST > 4000
--ORDER BY p.ACTUAL_COST DESC;

--SELECT PRACTICE_NAME      ---Part 7a
--FROM dbo.Medical_Practice
--WHERE EXISTS(
--  SELECT *
--  FROM dbo.Prescriptions
--  JOIN dbo.Drugs ON Prescriptions.BNF_CODE = Drugs.BNF_CODE
--  WHERE Prescriptions.PRACTICE_CODE =Medical_Practice.PRACTICE_CODE
--  AND Drugs.BNF_DESCRIPTION LIKE '%Paracetamol%'
--  )

--SELECT *                     ----Part 7b
--FROM dbo.Prescriptions
--WHERE PRACTICE_CODE IN (
--    SELECT PRACTICE_CODE
--    FROM Medical_Practice
--    WHERE PRACTICE_NAME= 'Lever Chambers 2'
--);

--SELECT m.PRACTICE_NAME, d.BNF_DESCRIPTION, p.ACTUAL_COST,    ---Part 7c
--p.PRESCRIPTION_CODE
--FROM dbo.Prescriptions p
--JOIN dbo.Medical_Practice m ON p.PRACTICE_CODE = m.PRACTICE_CODE
--JOIN dbo.Drugs d ON p.BNF_CODE = d.BNF_CODE;



--SELECT PRACTICE_CODE, SUM(ACTUAL_COST) as Total_Cost   --Part 7d
--FROM dbo.Prescriptions
--GROUP BY PRACTICE_CODE
--HAVING COUNT(*)>50
--ORDER BY Total_Cost DESC;

--SELECT m.PRACTICE_NAME, d.BNF_DESCRIPTION,    ---Part 7f
--SUM(p.QUANTITY * p.ITEMS) as Total_Quantity
--FROM dbo.Prescriptions p
--JOIN dbo.Medical_Practice m ON p.PRACTICE_CODE = m.PRACTICE_CODE
--JOIN dbo.Drugs d ON p.BNF_CODE = d.BNF_CODE
--GROUP BY m.PRACTICE_NAME, d.BNF_DESCRIPTION
--ORDER BY Total_Quantity DESC;


--Part 7e
--SELECT DISTINCT Medical_Practice.*, COALESCE(ADDRESS_4, 'Unknown') AS ADDRESS_4_UPDATED, COALESCE(ADDRESS_2, 'Unknown') AS ADDRESS_2_UPDATED
--FROM Medical_Practice
--INNER JOIN Prescriptions ON Medical_Practice.PRACTICE_CODE = Prescriptions.PRACTICE_CODE
--INNER JOIN Drugs ON Prescriptions.BNF_CODE = Drugs.BNF_CODE
--WHERE Medical_Practice.POSTCODE LIKE 'BL1%' AND Drugs.CHEMICAL_SUBSTANCE_BNF_DESCR LIKE '%amoxicillin%';

