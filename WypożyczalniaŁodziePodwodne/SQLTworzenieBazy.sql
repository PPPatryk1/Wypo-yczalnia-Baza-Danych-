--// TWORZENIE BAZY //--

USE [master]
GO

DROP DATABASE IF EXISTS WypożyczalniaŁodziPodwodnych
GO

CREATE DATABASE WypożyczalniaŁodziPodwodnych
GO

--// TWORZENIE TABEL //--

USE [WypożyczalniaŁodziPodwodnych]
GO

DROP TABLE IF EXISTS osoba
GO

CREATE TABLE osoba (
	ID int IDENTITY(1,1) NOT NULL,
	Imie nvarchar(50) NOT NULL,
	Nazwisko nvarchar(50) NOT NULL,
	Pesel char(11) NOT NULL,
	Telefon char(9) NOT NULL,
	Adres_Email nvarchar(50) NOT NULL,
	CONSTRAINT osoba_PK PRIMARY KEY NONCLUSTERED([id] ASC)
)
GO

DROP TABLE IF EXISTS Oddzial
GO

CREATE TABLE Oddzial (
	ID int IDENTITY(1,1) NOT NULL,
	Miasto varchar(50) NOT NULL,
	Ulica varchar(50) NOT NULL,
	Kod_Pocztowy varchar(6) NOT NULL,
	Telefon char(9) NOT NULL
	CONSTRAINT oddzial_PK PRIMARY KEY NONCLUSTERED([id] ASC)
)

DROP TABLE IF EXISTS Łodzie_podwodne
GO

CREATE TABLE Łodzie_podwodne ( 
	Id INT IDENTITY(1,1) NOT NULL, 
	Nazwa VARCHAR(30) UNIQUE NOT NULL, 
	Ilość_osób INT NOT NULL, 
	Głębokość_zanurzenia INT NOT NULL,
	Prędkość INT NOT NULL, 
	Waga INT NOT NULL,
	Długość INT NOT NULL,
	Wysokość INT NOT NULL,
	Cena INT NOT NULL,
	Status VARCHAR(10) NOT NULL CHECK (status IN ('wolny','zajety')) DEFAULT 'wolny'
	CONSTRAINT Łodzie_podwodne_PK PRIMARY KEY NONCLUSTERED([Id] ASC)
)
GO

DROP TABLE IF EXISTS Umowa
GO

CREATE TABLE Umowa (
    ID int IDENTITY(1,1) NOT NULL,
    IDŁodziPodwodnej INT NOT NULL,
    IDOsoby INT NOT NULL,
    IDOddziału INT NOT NULL,
    Dzień_rozpoczęcia DATE NOT NULL,
    Dzień_zakończenia DATE NOT NULL,
    Cena_całkowita INT,
    CONSTRAINT UmowaPK PRIMARY KEY NONCLUSTERED([ID] ASC),
    CONSTRAINT [IDŁódź_FK] FOREIGN KEY([IDŁodziPodwodnej]) REFERENCES  [dbo].[Łodzie_podwodne]([ID]),
    CONSTRAINT [ID_osoba_FK] FOREIGN KEY([IDOsoby]) REFERENCES [dbo].[osoba] ([ID]),
    CONSTRAINT [ID_oddział_FK] FOREIGN KEY([IDOddziału]) REFERENCES [dbo].[Oddzial] ([ID])
)

--// UZUPEŁNIANIE BAZY //--

-- UZUPEŁNIANIE TABELI osoba --

USE [WypożyczalniaŁodziPodwodnych]
GO

INSERT INTO [dbo].[osoba]
           ([Imie]
           ,[Nazwisko]
           ,[Pesel]
           ,[Telefon]
           ,[Adres_Email])
     VALUES
           ('Kazimierz','Sobczak','73020998592','426875986','eu@Duisgravida.com'),
		   ('Mirosława','Sobczak','04242919520','862557459','nunc.risus@et.ca'),
		   ('Julian','Sroka','93032432439','380807704','non@elitpharetraut.ca'),
		   ('Nataniel','Konieczny','28112364894','780412921','sagittis.semper@odioAliquam.ca'),
		   ('Patryk','Kozieł','39070956339','122329410','velit.egestas.lacinia@sitamet.edu'),
		   ('Przemysław','Kozieł','44072761632','240216717','Praesent@id.ca'),
		   ('David','Rutkowski','01262057290','415165453','nunc.sed@PraesentluctusCurabitur.ca')
GO

-- UZUPEŁNIANIE TABELI Łodzie podwodne

USE [WypożyczalniaŁodziPodwodnych]
GO

INSERT INTO [dbo].[Łodzie_podwodne]
           ([Nazwa],[Ilość_osób],[Głębokość_zanurzenia],[Prędkość],[Waga],[Długość],[Wysokość],[Cena],[Status])
     VALUES
           ('Nexus',6,240,22,2100,540,300,25000,'wolny'),
           ('DeepSwamp',5,1500,15,1500,480,310,42000,'wolny'),
           ('LittleCube',2,300,17,1100,440,240,10000,'zajety'),
           ('Spaceless',4,515,34,1800,520,280,17000,'wolny'),
           ('Vortex',5,150,54,1700,500,300,40000,'zajety');
GO

-- UZUPEŁNIANIE TABELI Oddział --

USE [WypożyczalniaŁodziPodwodnych]
GO

INSERT INTO [dbo].[Oddzial]
           ([Miasto]
           ,[Ulica]
           ,[Kod_Pocztowy]
           ,[Telefon])
     VALUES
           ('Słupsk','Łąkowa','15-377','689324154'),
		   ('Opole','Lipowa','58-580','865574753'),
		   ('Wrocław','Kołłątaja','74-274','584310323')
GO




