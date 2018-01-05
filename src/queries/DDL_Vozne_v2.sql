﻿/*
Created: 03.01.2018
Modified: 04.01.2018
Model: RE Oracle 10g
Database: Oracle 10g
*/


-- Create user data types section -------------------------------------------------

CREATE OR REPLACE TYPE T_REC_HISTORIA_CENY
AS OBJECT (
  datum_od DATE,
  datum_do DATE,
  cena     NUMBER,
ORDER MEMBER FUNCTION tried_cenu (porovnat T_REC_HISTORIA_CENY)
  RETURN NUMBER
)
/
CREATE OR REPLACE TYPE BODY T_REC_HISTORIA_CENY
AS ORDER MEMBER FUNCTION tried_cenu (porovnat T_REC_HISTORIA_CENY)
  RETURN NUMBER IS
  BEGIN
    IF porovnat.cena > self.cena
    THEN RETURN 1;
    ELSIF porovnat.cena < self.cena
      THEN RETURN -1;
    ELSE RETURN 0;
    END IF;
  END;
END;
/

CREATE OR REPLACE TYPE T_HISTORIA_CENY
IS TABLE OF T_REC_HISTORIA_CENY
/

-- Create tables section -------------------------------------------------

-- Table OSOBA

CREATE TABLE OSOBA (
  ROD_CISLO     CHAR(10) NOT NULL,
  MENO          VARCHAR2(30),
  PRIEZVISKO    VARCHAR2(30),
  DAT_NARODENIA DATE,
  ADRESA_OSOBY  VARCHAR2(50),
  KONTAKT_OSOBY VARCHAR2(15)
)
/

-- Add keys for table OSOBA

ALTER TABLE OSOBA
  ADD CONSTRAINT KEY1 PRIMARY KEY (ROD_CISLO)
/

-- Table and Columns comments section

COMMENT ON COLUMN OSOBA.ROD_CISLO IS 'd'
/

-- Table ZAMESTNANEC

CREATE TABLE ZAMESTNANEC (
  ID_ZAMESTNANCA    INTEGER NOT NULL,
  ROD_CISLO         CHAR(10),
  ID_SPOLOCNOSTI    INTEGER,
  DATUM_PRIJATIA    DATE    NOT NULL,
  DATUM_PREPUSTENIA DATE
)
/

-- Create indexes for table ZAMESTNANEC

CREATE INDEX IX_RELATIONSHIP9
  ON ZAMESTNANEC (ROD_CISLO)
/

CREATE INDEX IX_RELATIONSHIP1
  ON ZAMESTNANEC (ID_SPOLOCNOSTI)
/

-- Add keys for table ZAMESTNANEC

ALTER TABLE ZAMESTNANEC
  ADD CONSTRAINT KEY2 PRIMARY KEY (ID_ZAMESTNANCA)
/

-- Table SPOLOCNOST

CREATE TABLE SPOLOCNOST (
  ID_SPOLOCNOSTI      INTEGER NOT NULL,
  ID_TYPU_SPOLOCNOSTI INTEGER,
  NAZOV_SPOLOCNOSTI   VARCHAR2(30),
  ADRESA_SPOLOCNOSTI  VARCHAR2(50),
  KONTAKT_SPOLOCNOSTI VARCHAR2(15)
)
/

-- Create indexes for table SPOLOCNOST

CREATE INDEX IX_RELATIONSHIP26
  ON SPOLOCNOST (ID_TYPU_SPOLOCNOSTI)
/

-- Add keys for table SPOLOCNOST

ALTER TABLE SPOLOCNOST
  ADD CONSTRAINT KEY3 PRIMARY KEY (ID_SPOLOCNOSTI)
/

-- Table TYP_SPOLOCNOSTI

CREATE TABLE TYP_SPOLOCNOSTI (
  ID_TYPU_SPOLOCNOSTI INTEGER NOT NULL,
  TYP_SPOLOCNOSTI     CHAR(20)
)
/

-- Add keys for table TYP_SPOLOCNOSTI

ALTER TABLE TYP_SPOLOCNOSTI
  ADD CONSTRAINT KEY4 PRIMARY KEY (ID_TYPU_SPOLOCNOSTI)
/

-- Table VOZEN

CREATE TABLE VOZEN (
  ID_VOZNA             INTEGER NOT NULL,
  ID_TYPU_VOZNA        INTEGER,
  ID_VLASTNIKA         INTEGER,
  ID_VYROBCU           INTEGER,
  ID_DOMOVSKEJ_STANICE INTEGER,
  DATUM_NADOBUDNUTIA   DATE    NOT NULL
)
/

-- Create indexes for table VOZEN

CREATE INDEX IX_RELATIONSHIP30
  ON VOZEN (ID_TYPU_VOZNA)
/

CREATE INDEX IX_RELATIONSHIP33
  ON VOZEN (ID_VYROBCU)
/

CREATE INDEX IX_Relationship2
  ON VOZEN (ID_VLASTNIKA)
/

CREATE INDEX IX_Relationship3
  ON VOZEN (ID_DOMOVSKEJ_STANICE)
/

-- Add keys for table VOZEN

ALTER TABLE VOZEN
  ADD CONSTRAINT KEY5 PRIMARY KEY (ID_VOZNA)
/

-- Table TYP_VOZNA

CREATE TABLE TYP_VOZNA (
  ID_TYPU_VOZNA  INTEGER NOT NULL,
  CENA           NUMBER  NOT NULL,
  FOTO_VOZNA     BLOB,
  TYP_VOZNA      VARCHAR2(30),
  ODPIS_PERCENTA NUMBER
)
/

-- Add keys for table TYP_VOZNA

ALTER TABLE TYP_VOZNA
  ADD CONSTRAINT KEY6 PRIMARY KEY (ID_TYPU_VOZNA)
/

-- Table and Columns comments section

COMMENT ON COLUMN TYP_VOZNA.FOTO_VOZNA IS 'Pozor, moze to byt aj macka vo vreci !'
/

-- Table STANICA

CREATE TABLE STANICA (
  ID_STANICE      INTEGER NOT NULL,
  NAZOV_STANICE   VARCHAR2(30),
  ADRESA_STANICE  VARCHAR2(30),
  KONTAKT_STANICE VARCHAR2(30)
)
/

-- Add keys for table STANICA

ALTER TABLE STANICA
  ADD CONSTRAINT KEY7 PRIMARY KEY (ID_STANICE)
/

-- Table KONTROLA

CREATE TABLE KONTROLA (
  ID_KONTROLY      INTEGER NOT NULL,
  ID_TYPU_KONTROLY INTEGER,
  ID_VOZNA         INTEGER,
  POPIS_KONTROLY   VARCHAR2(100)
)
/

-- Create indexes for table KONTROLA

CREATE INDEX IX_RELATIONSHIP27
  ON KONTROLA (ID_TYPU_KONTROLY)
/

CREATE INDEX IX_RELATIONSHIP34
  ON KONTROLA (ID_VOZNA)
/

-- Add keys for table KONTROLA

ALTER TABLE KONTROLA
  ADD CONSTRAINT KEY8 PRIMARY KEY (ID_KONTROLY)
/

-- Table TYP_KONTROLY

CREATE TABLE TYP_KONTROLY (
  ID_TYPU_KONTROLY INTEGER NOT NULL,
  CENA_KONTROLY    NUMBER  NOT NULL,
  TYP_KONTROLY     VARCHAR2(100)
)
/

-- Add keys for table TYP_KONTROLY

ALTER TABLE TYP_KONTROLY
  ADD CONSTRAINT KEY9 PRIMARY KEY (ID_TYPU_KONTROLY)
/

-- Table VYRADENY_VOZEN

CREATE TABLE VYRADENY_VOZEN (
  ID_VYRAD_VOZEN  INTEGER NOT NULL,
  ID_VOZNA        INTEGER,
  DATUM_VYRADENIA DATE    NOT NULL,
  POPIS_VYRADENIA VARCHAR2(20)
)
/

-- Create indexes for table VYRADENY_VOZEN

CREATE INDEX IX_RELATIONSHIP21
  ON VYRADENY_VOZEN (ID_VOZNA)
/

-- Add keys for table VYRADENY_VOZEN

ALTER TABLE VYRADENY_VOZEN
  ADD CONSTRAINT KEY10 PRIMARY KEY (ID_VYRAD_VOZEN)
/

-- Table OPRAVA

CREATE TABLE OPRAVA (
  ID_OPRAVY      INTEGER NOT NULL,
  ID_KONTROLY    INTEGER,
  ID_TYPU_OPRAVY INTEGER,
  POPIS_OPRAVY   VARCHAR2(100)
)
/

-- Create indexes for table OPRAVA

CREATE INDEX IX_RELATIONSHIP24
  ON OPRAVA (ID_KONTROLY)
/

CREATE INDEX IX_RELATIONSHIP28
  ON OPRAVA (ID_TYPU_OPRAVY)
/

-- Add keys for table OPRAVA

ALTER TABLE OPRAVA
  ADD CONSTRAINT KEY11 PRIMARY KEY (ID_OPRAVY)
/

-- Table TYP_OPRAVY

CREATE TABLE TYP_OPRAVY (
  ID_TYPU_OPRAVY INTEGER NOT NULL,
  CENA_OPRAVY    NUMBER  NOT NULL,
  TYP_OPRAVY     VARCHAR2(100)
)
/

-- Add keys for table TYP_OPRAVY

ALTER TABLE TYP_OPRAVY
  ADD CONSTRAINT KEY12 PRIMARY KEY (ID_TYPU_OPRAVY)
/

-- Table SUCIASTKA

CREATE TABLE SUCIASTKA (
  ID_SUCIASTKY      INTEGER NOT NULL,
  ID_TYPU_SUCIASTKY INTEGER,
  ID_DODAVATELA     INTEGER,
  CENA_SUCIASTKY    NUMBER  NOT NULL
)
/

-- Create indexes for table SUCIASTKA

CREATE INDEX IX_RELATIONSHIP29
  ON SUCIASTKA (ID_TYPU_SUCIASTKY)
/

CREATE INDEX IX_RELATIONSHIP32
  ON SUCIASTKA (ID_DODAVATELA)
/

-- Add keys for table SUCIASTKA

ALTER TABLE SUCIASTKA
  ADD CONSTRAINT KEY13 PRIMARY KEY (ID_SUCIASTKY)
/

-- Table TYP_SUCIASTKY

CREATE TABLE TYP_SUCIASTKY (
  ID_TYPU_SUCIASTKY INTEGER NOT NULL,
  HISTORIA_CENY     T_HISTORIA_CENY,
  TYP_SUCIASTKY     VARCHAR2(30)
)
  NESTED TABLE HISTORIA_CENY STORE AS T_HISTORIA_CENY_TABLE;
/

-- Add keys for table TYP_SUCIASTKY

ALTER TABLE TYP_SUCIASTKY
  ADD CONSTRAINT KEY14 PRIMARY KEY (ID_TYPU_SUCIASTKY)
/

-- Table OPRAVA_SUCIASTKA

CREATE TABLE OPRAVA_SUCIASTKA (
  ID_OPRAVY      INTEGER NOT NULL,
  ID_ZAMESTNANCA INTEGER NOT NULL,
  ID_SUCIASTKY   INTEGER,
  OPRAVA_OD      DATE    NOT NULL,
  OPRAVA_DO      DATE
)
/

-- Create indexes for table OPRAVA_SUCIASTKA

CREATE INDEX IX_RELATIONSHIP35
  ON OPRAVA_SUCIASTKA (ID_SUCIASTKY)
/

-- Add keys for table OPRAVA_SUCIASTKA

ALTER TABLE OPRAVA_SUCIASTKA
  ADD CONSTRAINT KEY15 PRIMARY KEY (OPRAVA_OD, ID_OPRAVY, ID_ZAMESTNANCA)
/

-- Table KONTROLA_ZAMESTNANEC

CREATE TABLE KONTROLA_ZAMESTNANEC (
  ID_ZAMESTNANCA INTEGER NOT NULL,
  ID_KONTROLY    INTEGER NOT NULL,
  KONTROLA_OD    DATE    NOT NULL,
  KONTROLA_DO    DATE
)
/

-- Add keys for table KONTROLA_ZAMESTNANEC

ALTER TABLE KONTROLA_ZAMESTNANEC
  ADD CONSTRAINT KEY16 PRIMARY KEY (KONTROLA_OD, ID_ZAMESTNANCA, ID_KONTROLY)
/

-- Table VOZEN_STANICA

CREATE TABLE VOZEN_STANICA (
  ID_VOZNA     INTEGER NOT NULL,
  ID_STANICE   INTEGER NOT NULL,
  V_STANICI_OD DATE    NOT NULL,
  V_STANICI_DO DATE
)
/

-- Add keys for table VOZEN_STANICA

ALTER TABLE VOZEN_STANICA
  ADD CONSTRAINT KEY18 PRIMARY KEY (V_STANICI_OD, ID_VOZNA, ID_STANICE)
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE OPRAVA_SUCIASTKA
  ADD FOREIGN KEY (ID_OPRAVY) REFERENCES OPRAVA (ID_OPRAVY)
/


ALTER TABLE KONTROLA_ZAMESTNANEC
  ADD FOREIGN KEY (ID_ZAMESTNANCA) REFERENCES ZAMESTNANEC (ID_ZAMESTNANCA)
/


ALTER TABLE KONTROLA_ZAMESTNANEC
  ADD FOREIGN KEY (ID_KONTROLY) REFERENCES KONTROLA (ID_KONTROLY)
/


ALTER TABLE VOZEN_STANICA
  ADD FOREIGN KEY (ID_VOZNA) REFERENCES VOZEN (ID_VOZNA)
/


ALTER TABLE VOZEN_STANICA
  ADD FOREIGN KEY (ID_STANICE) REFERENCES STANICA (ID_STANICE)
/


ALTER TABLE ZAMESTNANEC
  ADD CONSTRAINT je FOREIGN KEY (ROD_CISLO) REFERENCES OSOBA (ROD_CISLO)
/


ALTER TABLE VYRADENY_VOZEN
  ADD FOREIGN KEY (ID_VOZNA) REFERENCES VOZEN (ID_VOZNA)
/


ALTER TABLE OPRAVA
  ADD FOREIGN KEY (ID_KONTROLY) REFERENCES KONTROLA (ID_KONTROLY)
/


ALTER TABLE SPOLOCNOST
  ADD FOREIGN KEY (ID_TYPU_SPOLOCNOSTI) REFERENCES TYP_SPOLOCNOSTI (ID_TYPU_SPOLOCNOSTI)
/


ALTER TABLE KONTROLA
  ADD FOREIGN KEY (ID_TYPU_KONTROLY) REFERENCES TYP_KONTROLY (ID_TYPU_KONTROLY)
/


ALTER TABLE OPRAVA
  ADD FOREIGN KEY (ID_TYPU_OPRAVY) REFERENCES TYP_OPRAVY (ID_TYPU_OPRAVY)
/


ALTER TABLE SUCIASTKA
  ADD FOREIGN KEY (ID_TYPU_SUCIASTKY) REFERENCES TYP_SUCIASTKY (ID_TYPU_SUCIASTKY)
/


ALTER TABLE VOZEN
  ADD FOREIGN KEY (ID_TYPU_VOZNA) REFERENCES TYP_VOZNA (ID_TYPU_VOZNA)
/


ALTER TABLE SUCIASTKA
  ADD FOREIGN KEY (ID_DODAVATELA) REFERENCES SPOLOCNOST (ID_SPOLOCNOSTI)
/


ALTER TABLE VOZEN
  ADD FOREIGN KEY (ID_VYROBCU) REFERENCES SPOLOCNOST (ID_SPOLOCNOSTI)
/


ALTER TABLE KONTROLA
  ADD FOREIGN KEY (ID_VOZNA) REFERENCES VOZEN (ID_VOZNA)
/


ALTER TABLE ZAMESTNANEC
  ADD FOREIGN KEY (ID_SPOLOCNOSTI) REFERENCES SPOLOCNOST (ID_SPOLOCNOSTI)
/


ALTER TABLE OPRAVA_SUCIASTKA
  ADD FOREIGN KEY (ID_ZAMESTNANCA) REFERENCES ZAMESTNANEC (ID_ZAMESTNANCA)
/


ALTER TABLE OPRAVA_SUCIASTKA
  ADD FOREIGN KEY (ID_SUCIASTKY) REFERENCES SUCIASTKA (ID_SUCIASTKY)
/


ALTER TABLE VOZEN
  ADD FOREIGN KEY (ID_VLASTNIKA) REFERENCES SPOLOCNOST (ID_SPOLOCNOSTI)
/


ALTER TABLE VOZEN
  ADD FOREIGN KEY (ID_DOMOVSKEJ_STANICE) REFERENCES STANICA (ID_STANICE)
/




-- Grant permissions section -------------------------------------------------

