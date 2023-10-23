SELECT FORMAT(b.ArrivalDate, 'yyyy-MM-dd') ArrivalDate
, b.AdultsCount
, b.ChildrenCount
FROM Bookings b
JOIN Rooms r ON b.RoomId = r.Id
ORDER BY r.Price DESC, b.ArrivalDate

SELECT h.Id
, h.[Name]
FROM Hotels h
JOIN HotelsRooms hr ON h.Id = hr.HotelId
JOIN Rooms r ON hr.RoomId = r.Id
JOIN Bookings b ON h.Id = b.HotelId
WHERE r.Id = 8
GROUP BY h.Id, h.[Name]
ORDER BY COUNT(b.Id) DESC

SELECT Id
, [Name]
, PhoneNumber
FROM Tourists
WHERE Id NOT IN(SELECT TouristId FROM Bookings)
ORDER BY [Name]

SELECT TOP(10)
h.[Name] HotelName
, d.[Name] DestinationName
, c.[Name] CountryName
FROM Bookings b
JOIN Hotels h ON b.HotelId = h.Id
JOIN Destinations d ON h.DestinationId = d.Id
JOIN Countries c ON d.CountryId = c.Id
WHERE b.ArrivalDate < '2023-12-31' AND h.Id %2 <>0
ORDER BY c.[Name], b.ArrivalDate

SELECT h.[Name] HotelName
, r.Price RoomPrice
FROM Tourists t
JOIN Bookings b ON t.Id = b.TouristId
JOIN Hotels h ON b.HotelId = h.Id
JOIN Rooms r ON b.RoomId = r.Id
WHERE t.[Name] NOT LIKE '%EZ'
ORDER BY RoomPrice DESC

SELECT h.[Name] HotelName
, SUM (r.Price*DATEDIFF(DAY, b.ArrivalDate, b.DepartureDate)) HotelRevenue
FROM Bookings b
JOIN Hotels h ON b.HotelId = h.Id
JOIN Rooms r ON b.RoomId = r.Id
GROUP BY h.[Name]
ORDER BY HotelRevenue DESC




