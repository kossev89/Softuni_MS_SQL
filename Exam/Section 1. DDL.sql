USE TouristAgency

CREATE TABLE Countries(
Id int PRIMARY KEY IDENTITY
, [Name] nvarchar (50) NOT NULL)

CREATE TABLE Destinations(
Id int PRIMARY KEY IDENTITY
, [Name] varchar (50) NOT NULL
, CountryId int FOREIGN KEY REFERENCES Countries(Id) NOT NULL)

CREATE TABLE Rooms(
Id int PRIMARY KEY IDENTITY
, [Type] varchar (40) NOT NULL
, Price decimal(18,2) NOT NULL
, BedCount int CHECK(BedCount>0 AND BedCount<=10) NOT NULL)

CREATE TABLE Hotels(
Id int PRIMARY KEY IDENTITY
, [Name] varchar (50) NOT NULL
, DestinationId int FOREIGN KEY REFERENCES Destinations(Id) NOT NULL)

CREATE TABLE Tourists(
Id int PRIMARY KEY IDENTITY
, [Name] nvarchar (80) NOT NULL
, PhoneNumber varchar (20) NOT NULL
, Email varchar (80)
, CountryId int FOREIGN KEY REFERENCES Countries(Id) NOT NULL)

CREATE TABLE Bookings(
Id int PRIMARY KEY IDENTITY
, ArrivalDate datetime2 NOT NULL
, DepartureDate datetime2 NOT NULL
, AdultsCount int CHECK(AdultsCount>=1 AND AdultsCount<=10) NOT NULL
, ChildrenCount int CHECK(ChildrenCount>=0 AND ChildrenCount<=19) NOT NULL
, TouristId int FOREIGN KEY REFERENCES Tourists(Id) NOT NULL
, HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL
, RoomId int FOREIGN KEY REFERENCES Rooms(Id) NOT NULL)

CREATE TABLE HotelsRooms(
HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL
, RoomId int FOREIGN KEY REFERENCES Rooms(Id) NOT NULL
, PRIMARY KEY(HotelId, RoomId))