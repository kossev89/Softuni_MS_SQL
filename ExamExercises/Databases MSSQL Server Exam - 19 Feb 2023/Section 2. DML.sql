INSERT INTO Boardgames
VALUES
('Deep Blue', 2019, 5.67, 1, 15, 7)
,('Paris', 2016, 9.78, 7, 1, 5)
,('Catan: Starfarers', 2021, 9.87, 7, 13, 6)
, ('Bleeding Kansas', 2020, 3.25, 3, 7, 4)
, ('One Small Step', 2019, 5.75, 5, 9, 2)

INSERT INTO Publishers
VALUES
('Agman Games', 5, 'www.agmangames.com', '+16546135542')
, ('Amethyst Games', 7, 'www.amethystgames.com', '+15558889992')
, ('BattleBooks', 13, 'www.battlebooks.com', '+12345678907')

UPDATE PlayersRanges
SET PlayersMax+=1
WHERE PlayersMax=2 AND PlayersMin = 2

UPDATE Boardgames
SET [Name] = [Name]+'V2'
WHERE YearPublished >= 2020

DELETE FROM CreatorsBoardgames
WHERE BoardgameId IN (1 ,16, 31, 47)

DELETE FROM Boardgames
WHERE PublisherId IN (1,16,17)

DELETE FROM Publishers
WHERE AddressId = 5

DELETE FROM Addresses
WHERE Town LIKE 'L%'