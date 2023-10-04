/*
Part I – Queries for Gringotts Database
1. Records' Count
Import the database and send the total count of records from the one and only table to Mr. Bodrog. Make sure nothing gets lost
*/
SELECT COUNT(wp.Id) AS [Count]
FROM WizzardDeposits AS wp
GO
/*
2. Longest Magic Wand
Select the size of the longest magic wand. Rename the new column appropriately.
*/
SELECT MAX (wp.MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits AS wp
GO
/*
3. Longest Magic Wand Per Deposit Groups
For wizards in each deposit group show the longest magic wand. Rename the new column appropriately.
*/
SELECT wp.DepositGroup, MAX(wp.MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits AS wp
GROUP BY wp.DepositGroup
GO
/*
4. Smallest Deposit Group Per Magic Wand Size
Select the two deposit groups with the lowest average wand size.
*/
SELECT TOP(2) wp.DepositGroup
FROM WizzardDeposits AS wp
GROUP BY wp.DepositGroup
ORDER BY AVG(wp.MagicWandSize)
GO
/*
5. Deposits Sum
Select all deposit groups and their total deposit sums.
*/
SELECT wp.DepositGroup, SUM(wp.DepositAmount) AS TotalSum
FROM WizzardDeposits AS wp
GROUP BY wp.DepositGroup
GO
/*
Select all deposit groups and their total deposit sums, but only for the wizards, who have their magic wands crafted by the Ollivander family.
*/
SELECT wp.DepositGroup, SUM(wp.DepositAmount) AS TotalSum
FROM WizzardDeposits AS wp
GROUP BY wp.DepositGroup, wp.MagicWandCreator
HAVING wp.MagicWandCreator = 'Ollivander Family'
GO
/*
7. Deposits Filter
Select all deposit groups and their total deposit sums, but only for the wizards, who have their magic wands crafted by the Ollivander family. Filter total deposit amounts lower than 150000. Order by total deposit amount in descending order.
*/
SELECT wp.DepositGroup, SUM(wp.DepositAmount) AS TotalSum
FROM WizzardDeposits AS wp
GROUP BY wp.DepositGroup, wp.MagicWandCreator
HAVING wp.MagicWandCreator = 'Ollivander Family' AND SUM(wp.DepositAmount)<150000
ORDER BY SUM(wp.DepositAmount) DESC
GO
/*
8.  Deposit Charge
Create a query that selects:
•	Deposit group 
•	Magic wand creator
•	Minimum deposit charge for each group 
Select the data in ascending order by MagicWandCreator and DepositGroup.
*/
SELECT wp.DepositGroup, wp.MagicWandCreator, MIN(wp.DepositCharge) AS MinDepositCharge
FROM WizzardDeposits AS wp
GROUP BY wp.DepositGroup, wp.MagicWandCreator
ORDER BY wp.MagicWandCreator, wp.DepositGroup
GO
/*
Write down a query that creates 7 different groups based on their age.
Age groups should be as follows:
•	[0-10]
•	[11-20]
•	[21-30]
•	[31-40]
•	[41-50]
•	[51-60]
•	[61+]
The query should return
•	Age groups
•	Count of wizards in it
*/
SELECT
CASE
WHEN wd.Age BETWEEN 0 and 10 THEN '[0-10]'
WHEN wd.Age BETWEEN 11 and 20 THEN '[11-20]'
WHEN wd.Age BETWEEN 21 and 30 THEN '[21-30]'
WHEN wd.Age BETWEEN 31 and 40 THEN '[31-40]'
WHEN wd.Age BETWEEN 41 and 50 THEN '[41-50]'
WHEN wd.Age BETWEEN 51 and 60 THEN '[51-60]'
WHEN wd.Age > 60  THEN '[61+]'
END AS AgeGroup
, COUNT (wd.Id)
FROM WizzardDeposits as wd
GROUP BY
CASE
WHEN wd.Age BETWEEN 0 and 10 THEN '[0-10]'
WHEN wd.Age BETWEEN 11 and 20 THEN '[11-20]'
WHEN wd.Age BETWEEN 21 and 30 THEN '[21-30]'
WHEN wd.Age BETWEEN 31 and 40 THEN '[31-40]'
WHEN wd.Age BETWEEN 41 and 50 THEN '[41-50]'
WHEN wd.Age BETWEEN 51 and 60 THEN '[51-60]'
WHEN wd.Age > 60  THEN '[61+]'
END
GO
/*
Create a query that returns all the unique wizard first letters of their first names only if they have deposit of type Troll Chest. Order them alphabetically. Use GROUP BY for uniqueness.
*/
SELECT DISTINCT SUBSTRING(wd.FirstName,1,1) FirstLetter
FROM WizzardDeposits wd
GROUP BY wd.FirstName, wd.DepositGroup
HAVING wd.DepositGroup = 'Troll Chest'
GO
/*
Mr. Bodrog is highly interested in profitability. He wants to know the average interest of all deposit groups, split by whether the deposit has expired or not. But that's not all. He wants you to select deposits with start date after 01/01/1985. Order the data descending by Deposit Group and ascending by Expiration Flag.
*/
SELECT wd.DepositGroup, wd.IsDepositExpired, AVG (wd.DepositInterest) AS AverageInterest
FROM WizzardDeposits AS wd
WHERE wd.DepositStartDate >= '1985-01-01'
GROUP BY wd.DepositGroup, wd.IsDepositExpired
ORDER BY wd.DepositGroup DESC, wd.IsDepositExpired
GO
/*
Mr. Bodrog definitely likes his werewolves more than you. This is your last chance to survive! Give him some data to play his favorite game Rich Wizard, Poor Wizard. The rules are simple: 
You compare the deposits of every wizard with the wizard after him. If a wizard is the last one in the database, simply ignore it. In the end you have to sum the difference between the deposits
*/
SELECT wd.FirstName AS 'Host Wizard'
, wd.DepositAmount AS 'Host Wizard Deposit'
, LEAD (wd.DepositAmount) OVER (ORDER BY wd.DepositAmount)  AS 'Guest Wizard'

FROM WizzardDeposits AS wd
/*
Part II – Queries for SoftUni Database

13. Departments Total Salaries
Create a query that shows the total sum of salaries for each department. Order them by DepartmentID.
*/
SELECT e.DepartmentID
, SUM (e.Salary) as TotalSalary
FROM Employees as e
GROUP BY e.DepartmentID
ORDER BY e.DepartmentID
/*
14. Employees Minimum Salaries
Select the minimum salary from the employees for departments with ID (2, 5, 7) but only for those, hired after 01/01/2000.
*/
SELECT e.DepartmentID, MIN(e.Salary) as MinimumSalary
FROM Employees as e
WHERE e.DepartmentID = 2 or e.DepartmentID=5 or e.DepartmentID=7 and e.HireDate > 2000-01-01
GROUP BY e.DepartmentID
ORDER BY e.DepartmentID
/*
15. Employees Average Salaries
Select all employees who earn more than 30000 into a new table. Then delete all employees who have ManagerID = 42 (in the new table). Then increase the salaries of all employees with DepartmentID = 1 by 5000. Finally, select the average salaries in each department.
*/
SELECT*
INTO EmployeesNew
FROM Employees e
WHERE e.Salary > 30000

DELETE
FROM EmployeesNew
WHERE ManagerID =42

UPDATE EmployeesNew
SET Salary+=5000
WHERE DepartmentID = 1

SELECT en.DepartmentID
, AVG (en.Salary) as AverageSalary
FROM EmployeesNew en
GROUP BY en.DepartmentID
ORDER BY en.DepartmentID
/*
16. Employees Maximum Salaries
Find the max salary for each department. Filter those, which have max salaries NOT in the range 30000 – 70000.
*/
SELECT e.DepartmentID
, MAX(e.Salary) as MaxSalary
FROM Employees e
GROUP BY e.DepartmentID
HAVING MAX(e.Salary) <30000 or MAX(e.Salary) > 70000
/*
17. Employees Count Salaries
Count the salaries of all employees, who don’t have a manager
*/
SELECT COUNT(e.Salary) as [Count]
FROM Employees e
WHERE e.ManagerID IS NULL
/*
18. *3rd Highest Salary
Find the third highest salary in each department if there is such. 
*/
SELECT ThirdHighestSalary, D FROM 
( SELECT Employees.Salary, DENSE_RANK() OVER (ORDER BY Employees.Salary DESC) RANK FROM Employees) as ThirdHighestSalary
WHERE RANK = 3














