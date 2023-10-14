CREATE OR ALTER FUNCTION udf_GetTouristsCountOnATouristSite (@Site varchar(50))
RETURNS int
AS
BEGIN
DECLARE @result int=
(SELECT COUNT(t.Id)
FROM Tourists t
JOIN SitesTourists st ON t.Id = st.TouristId
JOIN Sites s ON st.SiteId = s.Id
WHERE s.[Name] = @Site)
RETURN @result
END

CREATE OR ALTER PROC usp_AnnualRewardLottery(@TouristName varchar(50))
AS
DECLARE @count int =(SELECT COUNT (st.SiteId)
FROM Tourists t
JOIN SitesTourists st ON t.Id = st.TouristId
WHERE t.[Name] = @TouristName
GROUP BY t.[Name], t.Reward)
SELECT [Name]
, CASE
	WHEN @count>=100 THEN 'Gold badge'
	WHEN @count>=50 THEN 'Silver badge'
	WHEN @count>=25 THEN 'Bronze badge'
	ELSE Tourists.Reward
	END Reward
FROM Tourists
WHERE [Name] = @TouristName

EXEC usp_AnnualRewardLottery 'Gerhild Lutgard'

EXEC usp_AnnualRewardLottery 'Teodor Petrov'

EXEC usp_AnnualRewardLottery 'Zac Walsh'



