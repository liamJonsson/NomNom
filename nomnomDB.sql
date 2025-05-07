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
    Mängd DECIMAL(10,2) NOT NULL,
    PrisPerEnhet DECIMAL(10,2) NOT NULL
);

-- Tabell: Kylvaror
CREATE TABLE Kylvaror (
    MatvaruID INT PRIMARY KEY,
    BästFöre DATE,
    FOREIGN KEY (MatvaruID) REFERENCES Matvaror(MatvaruID)
);

-- Tabell: Frysvaror
CREATE TABLE Frysvaror (
    MatvaruID INT PRIMARY KEY,
    BästFöre DATE,
    FOREIGN KEY (MatvaruID) REFERENCES Matvaror(MatvaruID)
);

-- Tabell: Skafferi
CREATE TABLE Skafferi (
    MatvaruID INT PRIMARY KEY,
    BästFöre DATE,
    FOREIGN KEY (MatvaruID) REFERENCES Matvaror(MatvaruID)
);

-- Tabell: Maträtter
CREATE TABLE Maträtter (
    MaträttsID INT AUTO_INCREMENT PRIMARY KEY,
    Rätt VARCHAR(100) NOT NULL,
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
CREATE TABLE Maträtt_Matvara (
    MaträttsID INT,
    MatvaruID INT,
    PRIMARY KEY (MaträttsID, MatvaruID),
    FOREIGN KEY (MaträttsID) REFERENCES Maträtter(MaträttsID),
    FOREIGN KEY (MatvaruID) REFERENCES Matvaror(MatvaruID)
);

-- Kopplingstabell: Maträtter ingår i Matsedel (M:N)
CREATE TABLE Matsedel_Maträtt (
    MatsedelID INT,
    MaträttsID INT,
    PRIMARY KEY (MatsedelID, MaträttsID),
    FOREIGN KEY (MatsedelID) REFERENCES Matsedel(MatsedelID),
    FOREIGN KEY (MaträttsID) REFERENCES Maträtter(MaträttsID)
);
