DROP TABLE Entfernung ;
DROP TABLE Flug ;
DROP TABLE BoardingCard ;
DROP TABLE Ticket ;
DROP TABLE Passagier ;
DROP TABLE Sitz ;
DROP TABLE Klasse ;
DROP TABLE Flugzeug ;
DROP TABLE Flugzeugtyp ;
DROP TABLE Location ;
DROP TABLE Flugplan ;
DROP TABLE Flughafen ;
DROP TABLE Fluggesellschaft ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table Fluggesellschaft
-- -----------------------------------------------------

CREATE TABLE Fluggesellschaft (
  GCode VARCHAR(3) NOT NULL,
  Name VARCHAR(45) NOT NULL,
  Firmensitz VARCHAR(45) NOT NULL,
  PRIMARY KEY (GCode))
;


-- -----------------------------------------------------
-- Table Flughafen
-- -----------------------------------------------------

CREATE TABLE Flughafen (
  HCode VARCHAR(3) NOT NULL,
  PRIMARY KEY (HCode))
;


-- -----------------------------------------------------
-- Table Flugplan
-- -----------------------------------------------------

CREATE TABLE Flugplan (
  planNr INT NOT NULL,
  HCode VARCHAR(3) NOT NULL,
  HCode1 VARCHAR(3) NOT NULL,
  GCode VARCHAR(3) NOT NULL,
  Abflug_Zeit_Soll DATE NOT NULL,
  Ankunft_Zeit_Soll DATE NOT NULL,
  PRIMARY KEY (planNr),
  CONSTRAINT fk_Flugplan_Flughafen1
    FOREIGN KEY (HCode)
    REFERENCES Flughafen (HCode)
    ,
  CONSTRAINT fk_Flugplan_Flughafen2
    FOREIGN KEY (HCode1)
    REFERENCES Flughafen (HCode)
    
    ,
  CONSTRAINT fk_Flugplan_Fluggesellschaft1
    FOREIGN KEY (GCode)
    REFERENCES Fluggesellschaft (GCode)
    
    )
;

CREATE INDEX fk_Flugplan_Flughafen1_idx ON Flugplan (HCode ASC);

CREATE INDEX fk_Flugplan_Flughafen2_idx ON Flugplan (HCode1 ASC);

CREATE INDEX fk_Flugplan_Fluggesell1_idx ON Flugplan (GCode ASC);


-- -----------------------------------------------------
-- Table Location
-- -----------------------------------------------------

CREATE TABLE Location (
  ICode VARCHAR(1) NOT NULL,
  PRIMARY KEY (ICode))
;


-- -----------------------------------------------------
-- Table Flugzeugtyp
-- -----------------------------------------------------

CREATE TABLE Flugzeugtyp (
  typID VARCHAR(7) NOT NULL,
  Hersteller VARCHAR(45) NOT NULL,
  PRIMARY KEY (typID))
;


-- -----------------------------------------------------
-- Table Flugzeug
-- -----------------------------------------------------

CREATE TABLE Flugzeug (
  RegNr_int INT NOT NULL,
  GCode VARCHAR(3) NOT NULL,
  typID VARCHAR(7) NOT NULL,
  PRIMARY KEY (RegNr_int),
  CONSTRAINT fk_Flugzeug_Fluggesellschaft
    FOREIGN KEY (GCode)
    REFERENCES Fluggesellschaft (GCode)
    
    ,
  CONSTRAINT fk_Flugzeug_Flugzeugtyp1
    FOREIGN KEY (typID)
    REFERENCES Flugzeugtyp (typID)
    
    )
;

CREATE INDEX fk_Flugzeug_Fluggesell_idx ON Flugzeug (GCode ASC);

CREATE INDEX fk_Flugzeug_Flugzeugtyp1_idx ON Flugzeug (typID ASC);


-- -----------------------------------------------------
-- Table Klasse
-- -----------------------------------------------------

CREATE TABLE  Klasse (
  klasse VARCHAR(3) NOT NULL,
  PRIMARY KEY (klasse))
;


-- -----------------------------------------------------
-- Table Sitz
-- -----------------------------------------------------

CREATE TABLE Sitz (
  idSitz INT NOT NULL,
  typID VARCHAR(7) NOT NULL,
  klasse VARCHAR(3) NOT NULL,
  ICode VARCHAR(1) NOT NULL,
  Raucherplatz VARCHAR(1) NOT NULL,
  Frei VARCHAR(1) NOT NULL,
  PRIMARY KEY (idSitz),
  CONSTRAINT fk_Sitz_Flugzeugtyp1
    FOREIGN KEY (typID)
    REFERENCES Flugzeugtyp (typID)
    
    ,
  CONSTRAINT fk_Sitz_Klasse1
    FOREIGN KEY (klasse)
    REFERENCES Klasse (klasse)
    
    ,
  CONSTRAINT fk_Sitz_Location1
    FOREIGN KEY (ICode)
    REFERENCES Location (ICode)
    
    )
;

CREATE INDEX fk_Sitz_Flugzeugtyp1_idx ON Sitz (typID ASC);

CREATE INDEX fk_Sitz_Klasse1_idx ON Sitz (klasse ASC);

CREATE INDEX fk_Sitz_Location1_idx ON Sitz (ICode ASC);


-- -----------------------------------------------------
-- Table Passagier
-- -----------------------------------------------------

CREATE TABLE Passagier (
  pID INT NOT NULL,
  Name VARCHAR(100) NOT NULL,
  Anrede VARCHAR(4) NOT NULL,
  Titel VARCHAR(20) NOT NULL,
  GebDat DATE NOT NULL,
  Geschl VARCHAR(1) NULL,
  Religion VARCHAR(45) NOT NULL,
  Vegetarische_Kost VARCHAR(1) NOT NULL,
  PRIMARY KEY (pID))
;


-- -----------------------------------------------------
-- Table Ticket
-- -----------------------------------------------------

CREATE TABLE Ticket (
  tID INT NOT NULL,
  pID INT NOT NULL,
  planNr INT NOT NULL,
  Preis FLOAT NOT NULL,
  Waehrung VARCHAR(3) NOT NULL,
  Verkaufsbuero VARCHAR(45) NOT NULL,
  Datum_Ausstellung DATE NOT NULL,
  PRIMARY KEY (tID),
  CONSTRAINT fk_Ticket_Passagier1
    FOREIGN KEY (pID)
    REFERENCES Passagier (pID)
    
    ,
  CONSTRAINT fk_Ticket_Flugplan1
    FOREIGN KEY (planNr)
    REFERENCES Flugplan (planNr)
    
    )
;

CREATE INDEX fk_Ticket_Passagier1_idx ON Ticket (pID ASC);

CREATE INDEX fk_Ticket_Flugplan1_idx ON Ticket (planNr ASC);


-- -----------------------------------------------------
-- Table BoardingCard
-- -----------------------------------------------------

CREATE TABLE BoardingCard (
  tID INT NOT NULL,
  idSitz INT NOT NULL,
  PRIMARY KEY (tID),
  CONSTRAINT fk_BoardingCard_Ticket1
    FOREIGN KEY (tID)
    REFERENCES Ticket(tID)
    ,
  CONSTRAINT fk_BoardingCard_Sitz1
    FOREIGN KEY (idSitz)
    REFERENCES Sitz (idSitz)
    
    )
;

CREATE INDEX fk_BoardingCard_Sitz1_idx ON BoardingCard (idSitz ASC);


-- -----------------------------------------------------
-- Table Flug
-- -----------------------------------------------------

CREATE TABLE Flug (
  flugID INT NOT NULL,
  planNr INT NOT NULL,
  RegNr_int INT NOT NULL,
  PRIMARY KEY (flugID),
  CONSTRAINT fk_Flug_Flugplan1
    FOREIGN KEY (planNr)
    REFERENCES Flugplan (planNr)
    ,
  CONSTRAINT fk_Flug_Flugzeug1
    FOREIGN KEY (RegNr_int)
    REFERENCES Flugzeug (RegNr_int)
    )
;

CREATE INDEX fk_Flug_Flugplan1_idx ON Flug (planNr ASC);


-- -----------------------------------------------------
-- Table Entfernung
-- -----------------------------------------------------

CREATE TABLE Entfernung (
  HCode VARCHAR(3) NOT NULL,
  HCode1 VARCHAR(3) NOT NULL,
  PRIMARY KEY (HCode, HCode1),
  CONSTRAINT fk_Entfernung_Flughafen1
    FOREIGN KEY (HCode)
    REFERENCES Flughafen (HCode)
    
    ,
  CONSTRAINT fk_Entfernung_Flughafen2
    FOREIGN KEY (HCode1)
    REFERENCES Flughafen (HCode)
    
    )
;