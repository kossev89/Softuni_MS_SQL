/*
Exercises: Functions and Stored Procedures
This document defines the exercise assignments for the "Databases Basics - MSSQL" course @ Software University. 
You can check your solutions in the Judge system.
Part I – Queries for SoftUni Database
1.	Employees with Salary Above 35000
Create stored procedure usp_GetEmployeesSalaryAbove35000 that returns all employees' first and last names, whose salary above 35000. 
*/
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
	SELECT e.FirstName
	,e.LastName
	FROM Employees AS e
	WHERE e.Salary>35000

/*
2.	Employees with Salary Above Number
Create a stored procedure usp_GetEmployeesSalaryAboveNumber that accepts a number (of type DECIMAL(18,4)) as parameter and returns all employees' first and last names, whose salary is above or equal to the given number. 
*/
CREATE PROC usp_GetEmployeesSalaryAboveNumber (@inputNumber decimal(18,4))
AS
	SELECT e.FirstName AS 'First Name'
	,e.LastName AS 'Last Name'
	FROM Employees AS e
	WHERE e.Salary>=@inputNumber

/*
3.	Town Names Starting With
Create a stored procedure usp_GetTownsStartingWith that accepts a string as parameter and returns all town names starting with that string. 
*/
CREATE PROC usp_GetTownsStartingWith (@startsWith varchar(50))
AS
	SELECT t.[Name] AS Town
	FROM Towns AS t
	WHERE t.[Name] LIKE @startsWith+'%'

/*
4.	Employees from Town
Create a stored procedure usp_GetEmployeesFromTown that accepts town name as parameter and returns the first and last name of those employees, who live in the given town. 
*/
CREATE PROC usp_GetEmployeesFromTown (@townName varchar(50))
AS
	SELECT e.FirstName AS 'First Name'
	, e.LastName AS 'Last Name'
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON t.TownID = a.TownID
	WHERE t.[Name] LIKE @townName

/*
5.	Salary Level Function
Create a function ufn_GetSalaryLevel(@salary DECIMAL(18,4)) that receives salary of an employee and returns the level of the salary.
•	If salary is < 30000, return "Low"
•	If salary is between 30000 and 50000 (inclusive), return "Average"
•	If salary is > 50000, return "High"
*/

CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS varchar (20)
AS
BEGIN
DECLARE @salaryLevel varchar(50);
	IF (@salary < 30000)
	BEGIN
		SET @salaryLevel = 'Low'
	END
	ELSE IF (@salary <=50000)
	BEGIN
		SET @salaryLevel = 'Average'
	END
	ELSE
	BEGIN
		SET @salaryLevel = 'High'
	END
RETURN @salaryLevel
END

/*
6.	Employees by Salary Level
Create a stored procedure usp_EmployeesBySalaryLevel that receives as parameter level of salary (low, average, or high) and print the names of all employees, who have the given level of salary. You should use the function - "dbo.ufn_GetSalaryLevel(@Salary)", which was part of the previous task, inside your "CREATE PROCEDURE …" query.
*/

CREATE PROC usp_EmployeesBySalaryLevel (@levelOfSalary varchar (10))
AS
	SELECT e.FirstName AS 'First Name'
	, e.LastName AS 'Last Name'
	FROM Employees AS e
	WHERE dbo.ufn_GetSalaryLevel(e.Salary) = @levelOfSalary


