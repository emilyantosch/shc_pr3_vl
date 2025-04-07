CREATE SCHEMA IF NOT EXISTS lab4_2;
SET SEARCH_PATH TO lab4_2,public;
-- Create Countries table
CREATE TABLE Countries (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(50),
    Population INT,
    CapitalCity VARCHAR(50)
);

-- Insert sample data into Countries table
INSERT INTO Countries (CountryID, CountryName, Population, CapitalCity)
VALUES
    (1, 'USA', 331002651, 'Washington, D.C.'),
    (2, 'Brazil', 212993603, 'Brasília'),
    (3, 'China', 1444216107, 'Beijing'),
    (4, 'India', 1380004385, 'New Delhi'),
    (5, 'Russia', 145912025, 'Moscow'),
    (6, 'Australia', 25499884, 'Canberra'),
    (7, 'Canada', 37742154, 'Ottawa'),
    (8, 'Argentina', 45195774, 'Buenos Aires'),
    (9, 'Germany', 83783942, 'Berlin'),
    (10, 'France', 65273511, 'Paris'),
    (11, 'Japan', 126476461, 'Tokyo'),
    (12, 'South Africa', 59308690, 'Pretoria'),
    (13, 'Mexico', 128932753, 'Mexico City'),
    (14, 'Egypt', 104258327, 'Cairo'),
    (15, 'Saudi Arabia', 34813871, 'Riyadh'),
    (16, 'Nigeria', 206139587, 'Abuja'),
    (17, 'United Kingdom', 67886011, 'London'),
    (18, 'Italy', 60461826, 'Rome');

-- Create Continents table
CREATE TABLE Continents (
    ContinentID INT PRIMARY KEY,
    ContinentName VARCHAR(50)
);

-- Insert sample data into Continents table
INSERT INTO Continents (ContinentID, ContinentName)
VALUES
    (1, 'North America'),
    (2, 'South America'),
    (3, 'Asia'),
    (4, 'Europe'),
    (5, 'Africa'),
    (6, 'Oceania');

-- Create Cities table
CREATE TABLE Cities (
    CityID INT PRIMARY KEY,
    CityName VARCHAR(50),
    CountryID INT,
    Population INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

-- Insert sample data into Cities table
INSERT INTO Cities (CityID, CityName, CountryID, Population)
VALUES
    (1, 'New York City', 1, 8336817),
    (2, 'Rio de Janeiro', 2, 6718903),
    (3, 'Beijing', 3, 21706917),
    (4, 'Mumbai', 4, 12442373),
    (5, 'Moscow', 5, 12615882),
    (6, 'Sydney', 6, 5312163),
    (7, 'Toronto', 7, 2731571),
    (8, 'Buenos Aires', 8, 3054305),
    (9, 'Berlin', 9, 3669491),
    (10, 'Paris', 10, 2148271),
    (11, 'Tokyo', 11, 37393129),
    (12, 'Pretoria', 12, 741651),
    (13, 'Mexico City', 13, 9209944),
    (14, 'Cairo', 14, 10230350),
    (15, 'Riyadh', 15, 6937374),
    (16, 'Abuja', 16, 2149524),
    (17, 'London', 17, 8982256),
    (18, 'Rome', 18, 2870493);

-- Create Rivers table
CREATE TABLE Rivers (
    RiverID INT PRIMARY KEY,
    RiverName VARCHAR(50),
    Length INT,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

-- Insert sample data into Rivers table
INSERT INTO Rivers (RiverID, RiverName, Length, CountryID)
VALUES
    (1, 'Mississippi', 6275, 1),
    (2, 'Amazon', 6575, 2),
    (3, 'Yangtze', 6300, 3),
    (4, 'Ganges', 2525, 4),
    (5, 'Volga', 3530, 5),
    (6, 'Murray-Darling', 3751, 6),
    (7, 'Mackenzie', 1738, 7),
    (8, 'Paraná', 4880, 8),
    (9, 'Rhine', 1233, 9),
    (10, 'Seine', 777, 10),
    (11, 'Shinano', 367, 11),
    (12, 'Orange', 2200, 12),
    (13, 'Grijalva', 480, 13),
    (14, 'Nile', 6650, 14),
    (15, 'Wadi Hanifah', 160, 15),
    (16, 'Niger', 4184, 16),
    (17, 'Thames', 346, 17),
    (18, 'Tiber', 405, 18);

-- Create Mountains table
CREATE TABLE Mountains (
    MountainID INT PRIMARY KEY,
    MountainName VARCHAR(50),
    Height INT,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

-- Insert sample data into Mountains table
INSERT INTO Mountains (MountainID, MountainName, Height, CountryID)
VALUES
    (1, 'Denali', 6190, 1),
    (2, 'Pico da Neblina', 2995, 2), 
    (3, 'Everest', 8848, 3),  
    (4, 'Kangchenjunga', 8586, 4),  
    (5, 'Ural Mountains', 1895, 5),
    (6, 'Australian Alps', 2228, 6),
    (7, 'Canadian Rockies', 3954, 7),
    (8, 'Aconcagua', 6962, 8),  
    (9, 'Zugspitze', 2962, 9),  
    (10, 'Mont Blanc', 4808, 10),
    (11, 'Mount Fuji', 3776, 11),
    (12, 'Drakensberg', 3482, 12),
    (13, 'Popocatepetl', 5452, 13),
    (14, 'Mount Sinai', 2285, 14),
    (15, 'Asir Mountains', 3133, 15),
    (16, 'Kufena Mountain', 936, 16),
    (17, 'Ben Nevis', 1345, 17),
    (18, 'Gran Sasso', 2912, 18);

-- Create Languages table
CREATE TABLE Languages (
    LanguageID INT PRIMARY KEY,
    LanguageName VARCHAR(50)
);

-- Insert sample data into Languages table
INSERT INTO Languages (LanguageID, LanguageName)
VALUES
    (1, 'English'),
    (2, 'Portuguese'),
    (3, 'Mandarin'),
    (4, 'Hindi'),
    (5, 'Russian'),
    (6, 'Spanish'),
    (7, 'German'),
    (8, 'French'),
    (9, 'Japanese'),
    (10, 'Afrikaans'),
    (11, 'Spanish'),
    (12, 'Arabic'),
    (13, 'Hausa'),
    (14, 'Italian');

-- Create CountryLanguages table
CREATE TABLE CountryLanguages (
    CountryID INT,
    LanguageID INT,
    PRIMARY KEY (CountryID, LanguageID),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID),
    FOREIGN KEY (LanguageID) REFERENCES Languages(LanguageID)
);

-- Insert sample data into CountryLanguages table
INSERT INTO CountryLanguages (CountryID, LanguageID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 1),
    (7, 1),
    (8, 6),
    (9, 7),
    (10, 8),
    (11, 9),
    (12, 10),
    (13, 11),
    (14, 12),
    (15, 13),
    (16, 13),
    (17, 1),
    (18, 14);
