CREATE FUNCTION udf_GetVolunteersCountFromADepartment (@VolunteersDepartment varchar(50))
RETURNS int
AS
BEGIN
DECLARE @count int =(
SELECT COUNT(v.Id)
FROM Volunteers v
JOIN VolunteersDepartments vp ON v.DepartmentId = vp.Id
WHERE vp.DepartmentName = @VolunteersDepartment
GROUP BY vp.DepartmentName)
RETURN @count
END

CREATE PROC usp_AnimalsWithOwnersOrNot(@AnimalName varchar(50))
AS
SELECT a.[Name]
,CASE
	WHEN a.OwnerId IS NULL THEN 'For adoption'
	ELSE o.[Name]
	END OwnersName
FROM Animals a
LEFT JOIN Owners o ON a.OwnerId = o.Id
WHERE a.[Name] = @AnimalName

EXEC usp_AnimalsWithOwnersOrNot 'Hippo'
