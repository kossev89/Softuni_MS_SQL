CREATE OR ALTER FUNCTION udf_CreatorWithBoardgames(@name varchar(50)) 
RETURNS int 
AS 
BEGIN
DECLARE @result int=
(
SELECT COUNT (cb.BoardgameId) 
FROM Creators c
JOIN CreatorsBoardgames cb ON c.Id = cb.CreatorId
WHERE c.FirstName = @name
)
RETURN @result
END

CREATE PROC usp_SearchByCategory(@category varchar(50))
AS
SELECT b.[Name]
, b.YearPublished
, b.Rating
, c.[Name] CategoryName
, p.[Name] PublisherName
,CONCAT_WS (' ', pr.PlayersMin, 'people') MinPlayers
, CONCAT_WS (' ', pr.PlayersMax, 'people') MaxPlayers
FROM Boardgames b
JOIN Categories c ON b.CategoryId = c.Id
JOIN Publishers p ON b.PublisherId = p.Id
JOIN PlayersRanges pr ON b.PlayersRangeId = pr.Id
WHERE c.[Name] = @category
ORDER BY p.[Name], b.YearPublished DESC