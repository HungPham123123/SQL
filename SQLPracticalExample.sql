CREATE DATABASE NTB_DB;

USE NTB_DB;


CREATE TABLE Location (
    LocationID char(6) PRIMARY KEY,
    Name nvarchar(50) NOT NULL,
    Description nvarchar(100)
);

CREATE TABLE Land (
    LandID int PRIMARY KEY IDENTITY,
    Title nvarchar(100) NOT NULL,
    LocationID char(6) FOREIGN KEY REFERENCES Location(LocationID),
    Detail nvarchar(1000),
    StartDate datetime NOT NULL,
    EndDate datetime NOT NULL
);

CREATE TABLE Building (
    BuildingID int PRIMARY KEY IDENTITY,
    LandID int FOREIGN KEY REFERENCES Land(LandID),
    BuildingType nvarchar(50),
    Area int DEFAULT 50,
    Floors int DEFAULT 1,
    Rooms int DEFAULT 1,
    Cost money
);

INSERT INTO Location (LocationID, Name, Description)
VALUES
    ('100001', 'Urban', 'Urban Region'),
    ('100002', 'Suburban', 'Suburban Region'),
    ('100003', 'Rural', 'Rural Region');

INSERT INTO Land (Title, LocationID, Detail, StartDate, EndDate)
VALUES
    ('My Dinh', '100001', 'My Dinh in Urban Region', '2010-01-01', '2012-12-31'),
    ('Hoai Duc', '100002', 'Hoai Duc in Suburban Region', '2013-02-01', '2023-11-30'),
    ('An Thuong', '100003', 'An Thuong in Rural Region', '2000-03-01', '2010-10-31');

INSERT INTO Building (LandID, BuildingType, Area, Floors, Rooms, Cost)
VALUES
    (1, 'Villa', 200, 2, 4, 1000),
    (2, 'Apartment', 150, 3, 6, 800),
    (3, 'Supermarket', 300, 1, 1, 1500);

--4. List all the buildings with a floor area of 100m2 or more.
SELECT * FROM Building
WHERE Area >= 100;
--5. List the construction land will be completed before January 2013.
SELECT * FROM Land
WHERE EndDate < '2013-01-01';
--6. List all buildings to be built in the land of title "My Dinh”
SELECT Building.* FROM Building
JOIN Land ON Building.LandID = Land.LandID
WHERE Land.Title = 'My Dinh';
--7. Create a view v_Buildings contains the following information (BuildingID, Title, Name, BuildingType, Area, Floors) from table Building, Land and Location.
CREATE VIEW v_Buildings AS
SELECT Building.BuildingID, Land.Title, Location.Name, Building.BuildingType, Building.Area, Building.Floors
FROM Building
JOIN Land ON Building.LandID = Land.LandID
JOIN Location ON Land.LocationID = Location.LocationID;
--8. Create a view v_TopBuildings about 5 buildings with the most expensive price per m2.
CREATE VIEW v_TopBuildings AS
SELECT TOP 5 BuildingID, BuildingType, Area, Cost/Area AS PricePerM2
FROM Building
ORDER BY PricePerM2 DESC;
--9. Create a store called sp_SearchLandByLocation with input parameter is the area code and retrieve planned land for this area.
CREATE PROCEDURE sp_SearchLandByLocation @AreaCode char(6)
AS
BEGIN
    SELECT Land.* FROM Land
    JOIN Location ON Land.LocationID = Location.LocationID
    WHERE Location.LocationID = @AreaCode;
END;
--10. Create a store called sp_SearchBuidingByLand procedure input parameter is the land code and retrieve the buildings built on that land.
CREATE PROCEDURE sp_SearchBuildingByLand @LandCode int
AS
BEGIN
    SELECT * FROM Building
    WHERE LandID = @LandCode;
END;
