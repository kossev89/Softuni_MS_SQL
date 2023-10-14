SELECT [Name], Rating
FROM Boardgames
ORDER BY YearPublished, [Name] DESC

SELECT b.Id
, b.[Name]
, b.YearPublished
, c.[Name]
FROM Boardgames b
JOIN Categories c ON b.CategoryId = c.Id
WHERE CategoryId IN (6,8)
ORDER BY YearPublished DESC

SELECT c.Id
, CONCAT (c.FirstName,' ', c.LastName) CreatorName
, c.Email
FROM Creators c
WHERE c.Id NOT IN (SELECT CreatorId FROM CreatorsBoardgames)
ORDER BY CreatorName

SELECT TOP (5) b.[Name]
, b.Rating
, c.[Name]
FROM Boardgames b
JOIN PlayersRanges pr ON pr.Id = b.PlayersRangeId
JOIN Categories c ON b.CategoryId = c.Id
WHERE b.Rating>7 AND b.[Name] LIKE ('%a%')
OR b.Rating>7.50 AND pr.PlayersMin=2 AND pr.PlayersMax=5
ORDER BY b.[Name], b.Rating DESC

SELECT CONCAT (c.FirstName, ' ', c.LastName) FullName
, c.Email
, MAX (b.Rating) Rating
FROM Creators c
JOIN CreatorsBoardgames cb ON c.Id=cb.CreatorId
JOIN Boardgames b ON cb.BoardgameId = b.Id
WHERE Email LIKE ('%.com')
GROUP BY CONCAT (c.FirstName, ' ', c.LastName), c.Email
ORDER BY FullName

SELECT c.LastName
, CEILING(AVG (b.Rating)) AverageRating
, p.[Name] PublisherName
FROM Creators c
JOIN CreatorsBoardgames cb ON c.Id = cb.CreatorId
JOIN Boardgames b ON cb.BoardgameId = b.Id
JOIN Publishers p ON b.PublisherId = p.Id
WHERE c.Id IN (SELECT CreatorId FROM CreatorsBoardgames)
GROUP BY c.LastName, p.Id, p.[Name]
HAVING p.Id = 5
ORDER BY (AVG (b.Rating)) DESC