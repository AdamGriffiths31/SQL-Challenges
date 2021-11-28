--Challenge 1
SELECT Cart1.ITEM
,Cart2.ITEM
FROM Cart1
FULL OUTER JOIN Cart2 ON Cart1.ITEM=Cart2.ITEM 

--Challenge 2
WITH CTE AS(
    SELECT EmployeeID,ManagerID,JobTitle,Salary,0 as level 
    FROM Employees WHERE JobTitle='President'
    UNION ALL
    SELECT E.EmployeeID,E.ManagerID,E.JobTitle,E.Salary,Level+1 
    FROM Employees E 
    INNER JOIN CTE O ON O.EMPLOYEEID=E.ManagerID
    )
SELECT * FROM CTE

--Challenge 4
SELECT * 
FROM Orders
WHERE CustomerID IN (SELECT CustomerID FROM Orders WHERE DeliveryState='CA')
AND DeliveryState='TX'

--Challenge 5
WITH CTE AS
    (SELECT CustomerID
    ,CASE WHEN TYPE='Cellular' THEN PhoneNumber ELSE NULL END AS Cellular
    ,CASE WHEN TYPE='Work' THEN PhoneNumber ELSE NULL END AS Work
    ,CASE WHEN TYPE='Home' THEN PhoneNumber ELSE NULL END AS Home
    FROM PhoneDirectory
    )
SELECT CustomerID,MAX(Cellular),MAX(Work),MAX(Home) FROM CTE
GROUP BY CustomerID

--Challenge 6
SELECT Workflow
FROM WorkflowSteps
GROUP BY Workflow
HAVING COUNT(*) <> COUNT(CompletionDate)

--Challenge 7
SELECT CandidateID
FROM Candidates
WHERE Occupation IN (SELECT Requirement FROM Requirements)
GROUP BY CandidateID
HAVING COUNT(*) = (SELECT COUNT(Requirement) FROM Requirements)

--Challenge 8
SELECT Workflow,SUM(Case1+Case2+Case3)
FROM WorkflowCases
GROUP BY Workflow  

--Challenge 9
WITH CTE AS
  (
  SELECT	a.EmployeeID AS EmployeeID, b.EmployeeID AS EmployeeID2
  , COUNT(*) LicenseCount
  FROM	Employees a INNER JOIN Employees b ON a.License = b.License
  WHERE	a.EmployeeID <> b.EmployeeID
  GROUP BY a.EmployeeID, b.EmployeeID
  )
SELECT * FROM CTE WHERE LicenseCount>1

--Challenge 10
SELECT SUM(IntegerValue)/COUNT(IntegerValue) AS Mean FROM SampleData;
SELECT TOP 1 IntegerValue,COUNT(IntegerValue) AS ModeCount 
FROM SampleData GROUP BY IntegerValue ORDER BY ModeCount DESC;
SELECT MAX(IntegerValue)-MIN(IntegerValue) AS RangeValue FROM SampleData;
SELECT (SELECT TOP 1 IntegerValue 
FROM(SELECT TOP 50 PERCENT IntegerValue 
FROM SampleData ORDER BY IntegerValue DESC))
+ (SELECT TOP 1 IntegerValue FROM
(SELECT TOP 50 PERCENT IntegerValue 
FROM SampleData ORDER BY IntegerValue ASC)) AS Medium
