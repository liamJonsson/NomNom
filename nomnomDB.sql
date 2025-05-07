-- Skapa databas
CREATE DATABASE IF NOT EXISTS NomNomDB;
USE NomNomDB;

-- Skapa användare (byt lösenord till något säkert!)
CREATE USER IF NOT EXISTS 'nomuser'@'localhost' IDENTIFIED BY 'nompass123';

-- Ge användaren rättigheter till databasen
GRANT ALL PRIVILEGES ON NomNomDB.* TO 'nomuser'@'localhost';
FLUSH PRIVILEGES;

-- Tabell: Matvaror
CREATE TABLE Matvaror (
    MatvaruID INT AUTO_INCREMENT PRIMARY KEY,
    Vara VARCHAR(100) NOT NULL,
    Enhet VARCHAR(20) NOT NULL,
    Mangd DECIMAL(10,2) NOT NULL,
    BastFore DATE,
    PrisPerEnhet DECIMAL(10,2) NOT NULL
);

-- Tabell: Kylvaror
CREATE TABLE Kylvaror (
    MatvaruID INT PRIMARY KEY,
    FOREIGN KEY (MatvaruID) REFERENCES Matvaror(MatvaruID)
);

-- Tabell: Frysvaror
CREATE TABLE Frysvaror (
    MatvaruID INT PRIMARY KEY,
    FOREIGN KEY (MatvaruID) REFERENCES Matvaror(MatvaruID)
);

-- Tabell: Skafferi
CREATE TABLE Skafferi (
    MatvaruID INT PRIMARY KEY,
    FOREIGN KEY (MatvaruID) REFERENCES Matvaror(MatvaruID)
);

-- Tabell: Maträtter
CREATE TABLE Matratter (
    MatrattsID INT AUTO_INCREMENT PRIMARY KEY,
    Ratt VARCHAR(100) NOT NULL,
    Portioner INT,
    Kostnad DECIMAL(10,2),
    Tillagningstid INT, -- minuter
    HeadChef VARCHAR(100)
);

-- Tabell: Matsedel
CREATE TABLE Matsedel (
    MatsedelID INT AUTO_INCREMENT PRIMARY KEY,
    Vecka INT NOT NULL
);

-- Kopplingstabell: Maträtter består av Matvaror (M:N)
CREATE TABLE Matratt_Matvara (
    MatrattsID INT,
    MatvaruID INT,
    PRIMARY KEY (MatrattsID, MatvaruID),
    FOREIGN KEY (MatrattsID) REFERENCES Matratter(MatrattsID),
    FOREIGN KEY (MatvaruID) REFERENCES Matvaror(MatvaruID)
);

-- Kopplingstabell: Maträtter ingår i Matsedel (M:N)
CREATE TABLE Matsedel_Matratt (
    MatsedelID INT,
    MatrattsID INT,
    PRIMARY KEY (MatsedelID, MatrattsID),
    FOREIGN KEY (MatsedelID) REFERENCES Matsedel(MatsedelID),
    FOREIGN KEY (MatrattsID) REFERENCES Matratter(MatrattsID)
);

INSERT INTO Matvaror (Vara, Enhet, Mangd, BastFore, PrisPerEnhet) VALUES
('Tomat', 'st', 5, '2025-06-01', 2.50),
('Köttfärs', 'kg', 1.2, '2025-05-10', 89.90),
('Spaghetti', 'g', 500, '2026-01-01', 0.10);

INSERT INTO Kylvaror (MatvaruID) VALUES
(1), -- Tomat
(2); -- Köttfärs
-- Spaghetti ej kylvara

INSERT INTO Frysvaror (MatvaruID) VALUES
(2); -- Köttfärs (om du vill räkna den som både kyl/frys, annars hoppa)

INSERT INTO Skafferi (MatvaruID) VALUES
(3); -- Spaghetti

INSERT INTO Matratter (Ratt, Portioner, Kostnad, Tillagningstid, HeadChef) VALUES
('Spaghetti med köttfärssås', 4, 45.00, 30, 'Anna Andersson'),
('Tomatsoppa', 2, 20.00, 15, 'Erik Ek'),
('Pasta Bolognese', 3, 50.00, 25, 'Lisa Larsson');

INSERT INTO Matsedel (Vecka) VALUES
(19),
(20),
(21);

INSERT INTO Matratt_Matvara (MatrattsID, MatvaruID) VALUES
(1, 2), -- Spaghetti m. köttfärs → köttfärs
(1, 3), -- → spaghetti
(2, 1), -- Tomatsoppa → tomat
(3, 2), -- Pasta Bolognese → köttfärs
(3, 3); -- → spaghetti

INSERT INTO Matsedel_Matratt (MatsedelID, MatrattsID) VALUES
(1, 1),
(2, 2),
(3, 3);

