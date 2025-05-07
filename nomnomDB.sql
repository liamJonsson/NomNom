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