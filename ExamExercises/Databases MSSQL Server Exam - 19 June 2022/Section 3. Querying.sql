SELECT [Name]
, PhoneNumber
, [Address]
, AnimalId
, DepartmentId
FROM Volunteers
ORDER BY [Name], AnimalId, DepartmentId

SELECT [Name]
, at.AnimalType
, FORMAT (a.BirthDate, 'dd.MM.yyyy') BirthDate
FROM Animals a
JOIN AnimalTypes at ON a.AnimalTypeId = at.Id
ORDER BY a.[Name]

SELECT TOP(5) 
o.[Name]
, COUNT(a.Id) CountOfAnimals
FROM Owners o
JOIN Animals a ON o.Id = a.OwnerId
GROUP BY o.[Name]
ORDER BY CountOfAnimals DESC, o.[Name]

SELECT CONCAT_WS('-', o.[Name], a.[Name]) OwnersAnimals
, o.PhoneNumber
, ac.CageId
FROM Owners o
JOIN Animals a ON o.Id=a.OwnerId
JOIN AnimalsCages ac ON a.Id = ac.AnimalId
WHERE a.AnimalTypeId = 1
ORDER BY o.[Name], a.[Name] DESC

SELECT v.[Name]
, v.PhoneNumber
, LTRIM(SUBSTRING(v.[Address], CHARINDEX(',', v.[Address])+ 1, LEN(v.[Address]))) [Address]
FROM Volunteers v
WHERE v.[Address] LIKE ('%Sofia%') AND v.DepartmentId=2
ORDER BY v.[Name]

SELECT a.[Name]
, YEAR(a.BirthDate) BirthYear
, at.AnimalType
FROM Animals a
JOIN AnimalTypes at ON a.AnimalTypeId = at.Id
WHERE a.OwnerId IS NULL AND (2022-YEAR(a.BirthDate))<5 AND a.AnimalTypeId NOT IN (3)
ORDER BY a.[Name]



