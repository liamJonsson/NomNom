-- Använd databasen
USE NomNomDB;

-- Radera kopplingstabeller först (på grund av foreign keys)
DROP TABLE IF EXISTS Matsedel_Matratt;
DROP TABLE IF EXISTS Matratt_Matvara;

-- Radera tabeller med beroenden
DROP TABLE IF EXISTS Skafferi;
DROP TABLE IF EXISTS Frysvaror;
DROP TABLE IF EXISTS Kylvaror;

-- Radera huvudtabeller
DROP TABLE IF EXISTS Matsedel;
DROP TABLE IF EXISTS Matratter;
DROP TABLE IF EXISTS MatvarorForRatter;
DROP TABLE IF EXISTS Matvaror;

-- Skapa tabeller på nytt
CREATE TABLE Matvaror (
    MatvaruID INT AUTO_INCREMENT PRIMARY KEY,
    Vara VARCHAR(100) NOT NULL,
    Enhet VARCHAR(20) NOT NULL,
    Mangd DECIMAL(10,2) NOT NULL,
    BastFore DATE,
    PrisPerEnhet DECIMAL(10,2) NOT NULL
);

CREATE TABLE MatvarorForRatter (
    MatvaruID INT AUTO_INCREMENT PRIMARY KEY,
    Vara VARCHAR(100) NOT NULL,
    Enhet VARCHAR(20) NOT NULL,
    PrisPerEnhet DECIMAL(10,2) NOT NULL
);

CREATE TABLE Kylvaror (
    MatvaruID INT PRIMARY KEY,
    FOREIGN KEY (MatvaruID) REFERENCES Matvaror(MatvaruID)
);

CREATE TABLE Frysvaror (
    MatvaruID INT PRIMARY KEY,
    FOREIGN KEY (MatvaruID) REFERENCES Matvaror(MatvaruID)
);

CREATE TABLE Skafferi (
    MatvaruID INT PRIMARY KEY,
    FOREIGN KEY (MatvaruID) REFERENCES Matvaror(MatvaruID)
);

CREATE TABLE Matratter (
    MatrattsID INT AUTO_INCREMENT PRIMARY KEY,
    Ratt VARCHAR(100) NOT NULL,
    Portioner INT,
    Kostnad DECIMAL(10,2),
    Tillagningstid INT,
    HeadChef VARCHAR(100)
);

CREATE TABLE Matsedel (
    MatsedelID INT AUTO_INCREMENT PRIMARY KEY,
    Vecka INT NOT NULL
);

CREATE TABLE Matratt_Matvara (
    MatrattsID INT,
    MatvaruID INT,
    Mangd DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (MatrattsID, MatvaruID),
    FOREIGN KEY (MatrattsID) REFERENCES Matratter(MatrattsID),
    FOREIGN KEY (MatvaruID) REFERENCES MatvarorForRatter(MatvaruID)
);

CREATE TABLE Matsedel_Matratt (
    MatsedelID INT,
    MatrattsID INT,
    PRIMARY KEY (MatsedelID, MatrattsID),
    FOREIGN KEY (MatsedelID) REFERENCES Matsedel(MatsedelID),
    FOREIGN KEY (MatrattsID) REFERENCES Matratter(MatrattsID)
);

-- Lägg in startdata
INSERT INTO Matvaror (Vara, Enhet, Mangd, BastFore, PrisPerEnhet) VALUES
('Tomat', 'st', 5, '2025-06-01', 2.50),
('Köttfärs', 'kg', 1.2, '2025-05-10', 89.90),
('Spaghetti', 'g', 500, '2026-01-01', 0.10);

INSERT INTO MatvarorForRatter (Vara, Enhet, PrisPerEnhet) VALUES
('Tomat', 'st', 2.50),
('Köttfärs', 'kg', 89.90),
('Spaghetti', 'g', 0.10);

INSERT INTO Kylvaror (MatvaruID) VALUES
(1), -- Tomat
(2);

INSERT INTO Frysvaror (MatvaruID) VALUES
(2);

INSERT INTO Skafferi (MatvaruID) VALUES
(3);

INSERT INTO Matratter (Ratt, Portioner, Kostnad, Tillagningstid, HeadChef) VALUES
('Spaghetti med köttfärssås', 4, 45.00, 30, 'Anna Andersson'),
('Tomatsoppa', 2, 20.00, 15, 'Erik Ek'),
('Pasta Bolognese', 3, 50.00, 25, 'Lisa Larsson');

INSERT INTO Matsedel (Vecka) VALUES
(19),
(20),
(21);

INSERT INTO Matratt_Matvara (MatrattsID, MatvaruID, Mangd) VALUES
(1, 2, 2),
(1, 3, 2),
(2, 1, 2),
(3, 2, 2),
(3, 3, 2);

INSERT INTO Matsedel_Matratt (MatsedelID, MatrattsID) VALUES
(1, 1),
(2, 2),
(3, 3);
