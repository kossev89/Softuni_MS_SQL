CREATE TABLE Categories(
Id int PRIMARY KEY IDENTITY
, [Name] varchar(50) NOT NULL)

CREATE TABLE Addresses(
Id int PRIMARY KEY IDENTITY
, StreetName nvarchar(100) NOT NULL
, StreetNumber int NOT NULL
, Town varchar (30) NOT NULL
, Country varchar (50) NOT NULL
, ZIP int NOT NULL)

CREATE TABLE Publishers(
Id int PRIMARY KEY IDENTITY
, [Name] varchar (30) UNIQUE NOT NULL
, AddressId int FOREIGN KEY REFERENCES Addresses(Id) NOT NULL
, Website nvarchar(40) NOT NULL
, Phone nvarchar(20) NOT NULL)

CREATE TABLE PlayersRanges(
Id int PRIMARY KEY IDENTITY
, PlayersMin int NOT NULL
, PlayersMax int NOT NULL)

CREATE TABLE Boardgames(
Id int PRIMARY KEY IDENTITY
, [Name] nvarchar (30) NOT NULL
, YearPublished int NOT NULL
, Rating decimal (18,2) NOT NULL
, CategoryId int FOREIGN KEY REFERENCES Categories(Id) NOT NULL
, PublisherId int FOREIGN KEY REFERENCES Publishers(Id) NOT NULL
, PlayersRangeId int FOREIGN KEY REFERENCES PlayersRanges(Id) NOT NULL)

CREATE TABLE Creators(
Id int PRIMARY KEY IDENTITY
, FirstName nvarchar (30) NOT NULL
, LastName nvarchar (30) NOT NULL
, Email nvarchar (30) NOT NULL)

CREATE TABLE CreatorsBoardgames(
CreatorId int FOREIGN KEY REFERENCES Creators(Id) NOT NULL
, BoardgameId int FOREIGN KEY REFERENCES Boardgames(Id) NOT NULL
, PRIMARY KEY(CreatorId, BoardgameId))