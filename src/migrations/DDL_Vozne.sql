/*
Created: 28.11.2017
Modified: 3.12.2017
Model: Oracle 12c Release 1
Database: Oracle 12c
*/


-- Create entities section -------------------------------------------------

-- Table Osoba

CREATE TABLE "Osoba"(
  "rod_cislo" Char(11) NOT NULL,
  "meno" Varchar2(30 ),
  "priezvisko" Varchar2(30 ),
  "dat_narodenia" Date,
  "adresa_osoby" Varchar2(50 ),
  "kontakt_osoby" Varchar2(15 )
)
/

-- Add keys for table Osoba

ALTER TABLE "Osoba" ADD CONSTRAINT "Key1" PRIMARY KEY ("rod_cislo")
/

-- Table and Columns comments section

COMMENT ON COLUMN "Osoba"."rod_cislo" IS 'd'
/

-- Table Zamestnanec

CREATE TABLE "Zamestnanec"(
  "id_zamestnanca" Integer NOT NULL,
  "rod_cislo" Char(11),
  "id_spolocnosti" Integer,
  "datum_priatia" Date NOT NULL,
  "datum_prepustenia" Date
)
/

-- Add keys for table Zamestnanec

ALTER TABLE "Zamestnanec" ADD CONSTRAINT "Key2" PRIMARY KEY ("id_zamestnanca")
/

-- Table Spolocnost

CREATE TABLE "Spolocnost"(
  "id_spolocnosti" Integer NOT NULL,
  "id_typu_spolocnosti" Integer,
  "nazov_spolocnosti" Varchar2(30 ),
  "adresa_spolocnosti" Varchar2(50 ),
  "kontakt_spolocnosti" Varchar2(15 )
)
/

-- Add keys for table Spolocnost

ALTER TABLE "Spolocnost" ADD CONSTRAINT "Key3" PRIMARY KEY ("id_spolocnosti")
/

-- Table Typ_Spolocnosti

CREATE TABLE "Typ_Spolocnosti"(
  "id_typu_spolocnosti" Integer NOT NULL,
  "typ_spolocnosti" Char(20 )
)
/

-- Add keys for table Typ_Spolocnosti

ALTER TABLE "Typ_Spolocnosti" ADD CONSTRAINT "Key4" PRIMARY KEY ("id_typu_spolocnosti")
/

-- Table Vozen

CREATE TABLE "Vozen"(
  "id_vozna" Integer NOT NULL,
  "id_typu_vozna" Integer,
  "id_vlastnika" Integer,
  "id_vyrobcu" Integer,
  "id_domovskej_stanice" Integer NOT NULL
)
/

-- Add keys for table Vozen

ALTER TABLE "Vozen" ADD CONSTRAINT "Key5" PRIMARY KEY ("id_vozna","id_domovskej_stanice")
/

-- Table Typ_Vozna

CREATE TABLE "Typ_Vozna"(
  "id_typu_vozna" Integer NOT NULL,
  "typ_vozna" Varchar2(30 ),
  "cena" Number NOT NULL,
  "odpis_percenta" Number
)
/

-- Add keys for table Typ_Vozna

ALTER TABLE "Typ_Vozna" ADD CONSTRAINT "Key6" PRIMARY KEY ("id_typu_vozna")
/

-- Table Stanica

CREATE TABLE "Stanica"(
  "id_stanice" Integer NOT NULL,
  "nazov_stanice" Varchar2(30 ),
  "adresa_stanice" Varchar2(30 ),
  "kontakt_stanice" Varchar2(30 )
)
/

-- Add keys for table Stanica

ALTER TABLE "Stanica" ADD CONSTRAINT "Key7" PRIMARY KEY ("id_stanice")
/

-- Table Kontrola

CREATE TABLE "Kontrola"(
  "id_kontroly" Integer NOT NULL,
  "id_typu_kontroly" Integer,
  "id_vozna" Integer,
  "popis_kontroly" Varchar2(100 ),
  "id_stanice" Integer
)
/

-- Add keys for table Kontrola

ALTER TABLE "Kontrola" ADD CONSTRAINT "Key8" PRIMARY KEY ("id_kontroly")
/

-- Table Typ_Kontroly

CREATE TABLE "Typ_Kontroly"(
  "id_typu_kontroly" Integer NOT NULL,
  "typ_kontroly" Varchar2(30 ),
  "cena_kontroly" Number NOT NULL
)
/

-- Add keys for table Typ_Kontroly

ALTER TABLE "Typ_Kontroly" ADD CONSTRAINT "Key9" PRIMARY KEY ("id_typu_kontroly")
/

-- Table Vyradeny_Vozen

CREATE TABLE "Vyradeny_Vozen"(
  "id_vyrad_vozen" Integer NOT NULL,
  "id_vozna" Integer,
  "id_stanice" Integer
)
/

-- Add keys for table Vyradeny_Vozen

ALTER TABLE "Vyradeny_Vozen" ADD CONSTRAINT "Key10" PRIMARY KEY ("id_vyrad_vozen")
/

-- Table Oprava

CREATE TABLE "Oprava"(
  "id_opravy" Integer NOT NULL,
  "id_kontroly" Integer,
  "id_typu_opravy" Integer,
  "popis_opravy" Varchar2(100 )
)
/

-- Add keys for table Oprava

ALTER TABLE "Oprava" ADD CONSTRAINT "Key11" PRIMARY KEY ("id_opravy")
/

-- Table Typ_Opravy

CREATE TABLE "Typ_Opravy"(
  "id_typu_opravy" Integer NOT NULL,
  "typ_opravy" Varchar2(30 ),
  "cena_opravy" Number NOT NULL
)
/

-- Add keys for table Typ_Opravy

ALTER TABLE "Typ_Opravy" ADD CONSTRAINT "Key12" PRIMARY KEY ("id_typu_opravy")
/

-- Table Suciastka

CREATE TABLE "Suciastka"(
  "id_suciastky" Integer NOT NULL,
  "id_typu_suciastky" Integer,
  "id_dodavatela" Integer,
  "cena_suciastky" Number NOT NULL
)
/

-- Add keys for table Suciastka

ALTER TABLE "Suciastka" ADD CONSTRAINT "Key13" PRIMARY KEY ("id_suciastky")
/

-- Table Typ_Suciastky

CREATE TABLE "Typ_Suciastky"(
  "id_typu_suciastky" Integer NOT NULL,
  "typ_suciastky" Varchar2(30 )
)
/

-- Add keys for table Typ_Suciastky

ALTER TABLE "Typ_Suciastky" ADD CONSTRAINT "Key14" PRIMARY KEY ("id_typu_suciastky")
/

-- Table Oprava_Suciastka

CREATE TABLE "Oprava_Suciastka"(
  "id_opravy" Integer NOT NULL,
  "id_zamestnanca" Integer NOT NULL,
  "id_suciastky" Integer,
  "oprava_od" Date NOT NULL,
  "oprava_do" Date
)
/

-- Add keys for table Oprava_Suciastka

ALTER TABLE "Oprava_Suciastka" ADD CONSTRAINT "Key15" PRIMARY KEY ("id_opravy","id_zamestnanca","oprava_od")
/

-- Table Kontrola_Zamestnanec

CREATE TABLE "Kontrola_Zamestnanec"(
  "id_zamestnanca" Integer NOT NULL,
  "id_kontroly" Integer NOT NULL,
  "kontrola_od" Date NOT NULL,
  "kontrola_do" Date
)
/

-- Add keys for table Kontrola_Zamestnanec

ALTER TABLE "Kontrola_Zamestnanec" ADD CONSTRAINT "Key16" PRIMARY KEY ("id_zamestnanca","id_kontroly","kontrola_od")
/

-- Table Vozen_Stanica

CREATE TABLE "Vozen_Stanica"(
  "id_vozna" Integer NOT NULL,
  "id_stanice" Integer NOT NULL,
  "v_stanici_od" Date NOT NULL,
  "v_stanici_do" Date,
  "id_stanice" Integer NOT NULL
)
/

-- Add keys for table Vozen_Stanica

ALTER TABLE "Vozen_Stanica" ADD CONSTRAINT "Key18" PRIMARY KEY ("id_vozna","id_stanice","v_stanici_od","id_stanice")
/

-- Create indexes for entities section -------------------------------------------------

CREATE INDEX "IX_Relationship9" ON "Zamestnanec" ("rod_cislo")
/
CREATE INDEX "IX_Relationship1" ON "Zamestnanec" ("id_spolocnosti")
/
CREATE INDEX "IX_Relationship26" ON "Spolocnost" ("id_typu_spolocnosti")
/
CREATE INDEX "IX_Relationship30" ON "Vozen" ("id_typu_vozna")
/
CREATE INDEX "IX_Relationship31" ON "Vozen" ("id_vlastnika")
/
CREATE INDEX "IX_Relationship33" ON "Vozen" ("id_vyrobcu")
/
CREATE INDEX "IX_Relationship27" ON "Kontrola" ("id_typu_kontroly")
/
CREATE INDEX "IX_Relationship34" ON "Kontrola" ("id_vozna","id_stanice")
/
CREATE INDEX "IX_Relationship21" ON "Vyradeny_Vozen" ("id_vozna","id_stanice")
/
CREATE INDEX "IX_Relationship24" ON "Oprava" ("id_kontroly")
/
CREATE INDEX "IX_Relationship28" ON "Oprava" ("id_typu_opravy")
/
CREATE INDEX "IX_Relationship29" ON "Suciastka" ("id_typu_suciastky")
/
CREATE INDEX "IX_Relationship32" ON "Suciastka" ("id_dodavatela")
/
CREATE INDEX "IX_Relationship3" ON "Oprava_Suciastka" ("id_suciastky")
/



-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE "Oprava_Suciastka" ADD CONSTRAINT "" FOREIGN KEY ("id_opravy") REFERENCES "Oprava" ("id_opravy")
/


ALTER TABLE "Kontrola_Zamestnanec" ADD CONSTRAINT "" FOREIGN KEY ("id_zamestnanca") REFERENCES "Zamestnanec" ("id_zamestnanca")
/


ALTER TABLE "Kontrola_Zamestnanec" ADD CONSTRAINT "" FOREIGN KEY ("id_kontroly") REFERENCES "Kontrola" ("id_kontroly")
/


ALTER TABLE "Vozen_Stanica" ADD CONSTRAINT "" FOREIGN KEY ("id_vozna", "id_stanice") REFERENCES "Vozen" ("id_vozna", "id_domovskej_stanice")
/


ALTER TABLE "Vozen_Stanica" ADD CONSTRAINT "" FOREIGN KEY ("id_stanice") REFERENCES "Stanica" ("id_stanice")
/


ALTER TABLE "Zamestnanec" ADD CONSTRAINT "je" FOREIGN KEY ("rod_cislo") REFERENCES "Osoba" ("rod_cislo")
/


ALTER TABLE "Vyradeny_Vozen" ADD CONSTRAINT "" FOREIGN KEY ("id_vozna", "id_stanice") REFERENCES "Vozen" ("id_vozna", "id_domovskej_stanice")
/


ALTER TABLE "Oprava" ADD CONSTRAINT "" FOREIGN KEY ("id_kontroly") REFERENCES "Kontrola" ("id_kontroly")
/


ALTER TABLE "Spolocnost" ADD CONSTRAINT "" FOREIGN KEY ("id_typu_spolocnosti") REFERENCES "Typ_Spolocnosti" ("id_typu_spolocnosti")
/


ALTER TABLE "Kontrola" ADD CONSTRAINT "" FOREIGN KEY ("id_typu_kontroly") REFERENCES "Typ_Kontroly" ("id_typu_kontroly")
/


ALTER TABLE "Oprava" ADD CONSTRAINT "" FOREIGN KEY ("id_typu_opravy") REFERENCES "Typ_Opravy" ("id_typu_opravy")
/


ALTER TABLE "Suciastka" ADD CONSTRAINT "" FOREIGN KEY ("id_typu_suciastky") REFERENCES "Typ_Suciastky" ("id_typu_suciastky")
/


ALTER TABLE "Vozen" ADD CONSTRAINT "" FOREIGN KEY ("id_typu_vozna") REFERENCES "Typ_Vozna" ("id_typu_vozna")
/


ALTER TABLE "Vozen" ADD CONSTRAINT "" FOREIGN KEY ("id_vlastnika") REFERENCES "Spolocnost" ("id_spolocnosti")
/


ALTER TABLE "Suciastka" ADD CONSTRAINT "" FOREIGN KEY ("id_dodavatela") REFERENCES "Spolocnost" ("id_spolocnosti")
/


ALTER TABLE "Vozen" ADD CONSTRAINT "" FOREIGN KEY ("id_vyrobcu") REFERENCES "Spolocnost" ("id_spolocnosti")
/


ALTER TABLE "Kontrola" ADD CONSTRAINT "" FOREIGN KEY ("id_vozna", "id_stanice") REFERENCES "Vozen" ("id_vozna", "id_domovskej_stanice")
/


ALTER TABLE "Zamestnanec" ADD CONSTRAINT "" FOREIGN KEY ("id_spolocnosti") REFERENCES "Spolocnost" ("id_spolocnosti")
/


ALTER TABLE "Oprava_Suciastka" ADD CONSTRAINT "" FOREIGN KEY ("id_zamestnanca") REFERENCES "Zamestnanec" ("id_zamestnanca")
/


ALTER TABLE "Oprava_Suciastka" ADD CONSTRAINT "" FOREIGN KEY ("id_suciastky") REFERENCES "Suciastka" ("id_suciastky")
/


ALTER TABLE "Vozen" ADD CONSTRAINT "" FOREIGN KEY ("id_domovskej_stanice") REFERENCES "Stanica" ("id_stanice")
/





