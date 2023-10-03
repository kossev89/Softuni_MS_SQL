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











