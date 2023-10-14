SELECT [Name]
, Age
, PhoneNumber
, Nationality
FROM Tourists
ORDER BY Nationality, Age DESC, [Name]

SELECT s.[Name] [Site]
, l.[Name] [Location]
, s.Establishment Establishment
, c.[Name] Category
FROM Sites s
JOIN Locations l ON s.LocationId = l.Id
JOIN Categories c ON s.CategoryId = c.Id
ORDER BY c.[Name] DESC, l.[Name], s.[Name]

SELECT l.Province Province
, l.Municipality Municipality
, l.[Name] [Location]
, COUNT (s.Id) CountOfSites
FROM Locations l
JOIN Sites s ON l.Id = s.LocationId
WHERE Province = 'Sofia'
GROUP BY l.Id, l.Province, l.Municipality, l.[Name]
ORDER BY CountOfSites DESC, l.[Name]

SELECT s.[Name] [Site]
, l.[Name] [Location]
, l.Municipality Municipality
, l.Province Province
, s.Establishment Establishment
FROM Sites s
JOIN Locations l ON s.LocationId = l.Id
WHERE LEFT(l.[Name], 1) NOT IN ('B', 'M', 'D') AND s.Establishment LIKE ('%BC')
ORDER BY s.[Name]

SELECT t.[Name]
, t.Age
, t.PhoneNumber 
, t.Nationality
, CASE
	WHEN bp.[Name] IS NULL THEN '(no bonus prize)'
	ELSE bp.[Name]
	END Reward
FROM Tourists t
LEFT JOIN TouristsBonusPrizes tb ON t.Id = tb.TouristId
LEFT JOIN BonusPrizes bp ON tb.BonusPrizeId = bp.Id
ORDER BY t.[Name]

SELECT SUBSTRING( t.[Name] , LEN(t.[Name]) -  CHARINDEX(' ',REVERSE(t.[Name])) + 2  , LEN(t.[Name])  ) LastName
, t.Nationality
, t.Age
, t.PhoneNumber
FROM Tourists t
JOIN SitesTourists st ON t.Id = st.TouristId
JOIN Sites s ON st.SiteId = s.Id
WHERE s.CategoryId = 8
GROUP BY SUBSTRING( t.[Name] , LEN(t.[Name]) -  CHARINDEX(' ',REVERSE(t.[Name])) + 2  , LEN(t.[Name])  )
, t.Nationality
, t.Age
, t.PhoneNumber
ORDER BY LastName



