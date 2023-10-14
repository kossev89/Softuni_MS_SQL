CREATE TABLE Owners(
Id int PRIMARY KEY IDENTITY
, [Name] varchar (50) NOT NULL
, PhoneNumber varchar (15) NOT NULL
, [Address] varchar (50))

CREATE TABLE AnimalTypes(
Id int PRIMARY KEY IDENTITY
, AnimalType varchar (30) NOT NULL)

CREATE TABLE Cages(
Id int PRIMARY KEY IDENTITY
, AnimalTypeId int FOREIGN KEY REFERENCES AnimalTypes(Id) NOT NULL)

CREATE TABLE Animals(
Id int PRIMARY KEY IDENTITY
, [Name] varchar (30) NOT NULL
, BirthDate date NOT NULL
, OwnerId int FOREIGN KEY REFERENCES Owners(Id)
, AnimalTypeId int FOREIGN KEY REFERENCES AnimalTypes(Id) NOT NULL)

CREATE TABLE AnimalsCages(
CageId int FOREIGN KEY REFERENCES Cages(Id) NOT NULL
, AnimalId int FOREIGN KEY REFERENCES Animals(Id) NOT NULL
, PRIMARY KEY(CageId, AnimalId))

CREATE TABLE VolunteersDepartments(
Id int PRIMARY KEY IDENTITY
, DepartmentName varchar (30) NOT NULL)

CREATE TABLE Volunteers(
Id int PRIMARY KEY IDENTITY
, [Name] varchar (50) NOT NULL
, PhoneNumber varchar (15) NOT NULL
, [Address] varchar (50)
, AnimalId int FOREIGN KEY REFERENCES Animals(Id)
, DepartmentId int FOREIGN KEY REFERENCES VolunteersDepartments(Id) NOT NULL)