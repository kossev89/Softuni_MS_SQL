CREATE FUNCTION udf_RoomsWithTourists(@name varchar(50))
RETURNS int
AS
BEGIN
DECLARE @result int=(
SELECT SUM(b.AdultsCount+b.ChildrenCount)
FROM Bookings b
JOIN Tourists t ON b.TouristId = t.Id
JOIN Rooms r ON b.RoomId = r.Id
WHERE r.Type = @name)
RETURN @result
END

CREATE OR ALTER PROC usp_SearchByCountry(@country varchar(20))
AS
SELECT t.[Name]
, t.PhoneNumber
, t.Email
, COUNT(b.TouristId) CountOfBookings
FROM Tourists t
JOIN Countries c ON t.CountryId = c.Id
JOIN Bookings b ON t.Id = b.TouristId
WHERE t.Id IN (SELECT TouristId FROM Bookings) AND c.[Name]= @country
GROUP BY t.[Name], t.PhoneNumber, t.Email
ORDER BY t.[Name], CountOfBookings DESC

EXEC usp_SearchByCountry 'Greece'
