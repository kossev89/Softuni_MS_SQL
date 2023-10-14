CREATE TABLE Categories(
Id int PRIMARY KEY IDENTITY
,[Name] varchar(50) NOT NULL)

CREATE TABLE Locations(
Id int PRIMARY KEY IDENTITY
, [Name] varchar(50) NOT NULL
, Municipality varchar(50)
, Province varchar(50))

CREATE TABLE Sites(
Id int PRIMARY KEY IDENTITY
, [Name] varchar(100) NOT NULL
, LocationId int FOREIGN KEY REFERENCES Locations(Id) NOT NULL
, CategoryId int FOREIGN KEY REFERENCES Categories(Id) NOT NULL
, Establishment varchar(15))

CREATE TABLE Tourists(
Id int PRIMARY KEY IDENTITY
, [Name] varchar(50) NOT NULL
, Age int CHECK (Age>=0 AND Age<=120) NOT NULL
, PhoneNumber varchar(20) NOT NULL
, Nationality varchar(30) NOT NULL
, Reward varchar(20))

CREATE TABLE SitesTourists(
TouristId int FOREIGN KEY REFERENCES Tourists(Id) NOT NULL
, SiteId int FOREIGN KEY REFERENCES Sites(Id) NOT NULL
, PRIMARY KEY (TouristId, SiteId))

CREATE TABLE BonusPrizes(
Id int PRIMARY KEY IDENTITY
, [Name] varchar(50) NOT NULL)

CREATE TABLE TouristsBonusPrizes(
TouristId int FOREIGN KEY REFERENCES Tourists(Id) NOT NULL
, BonusPrizeId int FOREIGN KEY REFERENCES BonusPrizes(Id) NOT NULL
, PRIMARY KEY (TouristId, BonusPrizeId))
