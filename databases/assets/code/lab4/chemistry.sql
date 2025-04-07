SET SEARCH_PATH TO lab4_1,public;

-- Table: Elements
CREATE TABLE Elements (
    ElementID INT PRIMARY KEY,
    Symbol VARCHAR(2) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    AtomicNumber INT NOT NULL,
    AtomicWeight REAL NOT NULL
);

-- Table: Compounds
CREATE TABLE Compounds (
    CompoundID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Formula VARCHAR(50) NOT NULL
);

-- Table: Reactions
CREATE TABLE Reactions (
    ReactionID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description TEXT
);

-- Table: Laboratories
CREATE TABLE Laboratories (
    LabID INT PRIMARY KEY,
    LabName VARCHAR(50) NOT NULL,
    Location VARCHAR(100) NOT NULL
);

-- Table: Researchers
CREATE TABLE Researchers (
    ResearcherID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    LabID INT,
    FOREIGN KEY (LabID) REFERENCES Laboratories(LabID)
);

-- Table: ChangeLog
CREATE TABLE ChangeLog (
    LogID SERIAL PRIMARY KEY,
    NEW_DATA JSON,
	OLD_DATE JSON,
	ACTION VARCHAR(32),
	TABLE_NAME VARCHAR(32),
    TIMESTAMP TIMESTAMP
);

-- Sample Data
-- Elements
INSERT INTO Elements (ElementID, Symbol, Name, AtomicNumber, AtomicWeight) VALUES
(1, 'H', 'Hydrogen', 1, 1.008),
(2, 'O', 'Oxygen', 8, 15.999),
(3, 'Na', 'Sodium', 11, 22.990),
(4, 'Cl', 'Chlorine', 17, 35.453),
(5, 'C', 'Carbon', 6, 12.011),
(6, 'N', 'Nitrogen', 7, 14.007),
(7, 'Fe', 'Iron', 26, 55.845),
(8, 'Cu', 'Copper', 29, 63.546),
(9, 'Au', 'Gold', 79, 196.967),
(10, 'Ag', 'Silver', 47, 107.868);

-- Compounds
INSERT INTO Compounds (CompoundID, Name, Formula) VALUES
(1, 'Water', 'H2O'),
(2, 'Sodium Chloride', 'NaCl'),
(3, 'Carbon Dioxide', 'CO2'),
(4, 'Methane', 'CH4'),
(5, 'Ethanol', 'C2H5OH'),
(6, 'Acetic Acid', 'CH3COOH'),
(7, 'Ammonia', 'NH3'),
(8, 'Sulfuric Acid', 'H2SO4'),
(9, 'Glucose', 'C6H12O6'),
(10, 'Calcium Carbonate', 'CaCO3');

-- Reactions
INSERT INTO Reactions (ReactionID, Name, Description) VALUES
(1, 'Combustion of Hydrogen', 'Reaction of hydrogen with oxygen to form water.'),
(2, 'Photosynthesis', 'Conversion of carbon dioxide and water into glucose and oxygen using sunlight.'),
(3, 'Respiration', 'Conversion of glucose and oxygen into carbon dioxide and water to release energy.'),
(4, 'Rusting of Iron', 'Reaction of iron with oxygen and moisture to form rust (iron oxide).'),
(5, 'Neutralization', 'Reaction between an acid and a base to form water and a salt.');

-- Laboratories
INSERT INTO Laboratories (LabID, LabName, Location) VALUES
(1, 'ChemLab1', 'Building A, Room 66'),
(2, 'ChemLab2', 'Building A, Room 21'),
(3, 'ChemLab3', 'Building A, Room 12'),
(4, 'ChemLab4', 'Building B, Room 4'),
(5, 'ChemLab5', 'Building B, Room 5');

-- Researchers
INSERT INTO Researchers (ResearcherID, FirstName, LastName, LabID) VALUES
(1, 'Jonathan', 'Meyer', 1),
(2, 'Angelika', 'Schmidt', 2),
(3, 'Sabine', 'Thorsten', 3),
(4, 'Heike', 'Osterbaum', 4),
(5, 'Michael', 'Günther', 5);

