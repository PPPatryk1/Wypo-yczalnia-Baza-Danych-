--// TWORZENIE BAZY //--

USE [master]
GO

DROP DATABASE IF EXISTS Wypo�yczalnia�odziPodwodnych
GO

CREATE DATABASE Wypo�yczalnia�odziPodwodnych
GO

--// TWORZENIE TABEL //--

USE [Wypo�yczalnia�odziPodwodnych]
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

DROP TABLE IF EXISTS �odzie_podwodne
GO

CREATE TABLE �odzie_podwodne ( 
	Id INT IDENTITY(1,1) NOT NULL, 
	Nazwa VARCHAR(30) UNIQUE NOT NULL, 
	Ilo��_os�b INT NOT NULL, 
	G��boko��_zanurzenia INT NOT NULL,
	Pr�dko�� INT NOT NULL, 
	Waga INT NOT NULL,
	D�ugo�� INT NOT NULL,
	Wysoko�� INT NOT NULL,
	Cena INT NOT NULL,
	Status VARCHAR(10) NOT NULL CHECK (status IN ('wolny','zajety')) DEFAULT 'wolny'
	CONSTRAINT �odzie_podwodne_PK PRIMARY KEY NONCLUSTERED([Id] ASC)
)
GO

DROP TABLE IF EXISTS Umowa
GO

CREATE TABLE Umowa (
    ID int IDENTITY(1,1) NOT NULL,
    ID�odziPodwodnej INT NOT NULL,
    IDOsoby INT NOT NULL,
    IDOddzia�u INT NOT NULL,
    Dzie�_rozpocz�cia DATE NOT NULL,
    Dzie�_zako�czenia DATE NOT NULL,
    Cena_ca�kowita INT,
    CONSTRAINT UmowaPK PRIMARY KEY NONCLUSTERED([ID] ASC),
    CONSTRAINT [ID��d�_FK] FOREIGN KEY([ID�odziPodwodnej]) REFERENCES  [dbo].[�odzie_podwodne]([ID]),
    CONSTRAINT [ID_osoba_FK] FOREIGN KEY([IDOsoby]) REFERENCES [dbo].[osoba] ([ID]),
    CONSTRAINT [ID_oddzia�_FK] FOREIGN KEY([IDOddzia�u]) REFERENCES [dbo].[Oddzial] ([ID])
)

--// UZUPE�NIANIE BAZY //--

-- UZUPE�NIANIE TABELI osoba --

USE [Wypo�yczalnia�odziPodwodnych]
GO

INSERT INTO [dbo].[osoba]
           ([Imie]
           ,[Nazwisko]
           ,[Pesel]
           ,[Telefon]
           ,[Adres_Email])
     VALUES
           ('Kazimierz','Sobczak','73020998592','426875986','eu@Duisgravida.com'),
		   ('Miros�awa','Sobczak','04242919520','862557459','nunc.risus@et.ca'),
		   ('Julian','Sroka','93032432439','380807704','non@elitpharetraut.ca'),
		   ('Nataniel','Konieczny','28112364894','780412921','sagittis.semper@odioAliquam.ca'),
		   ('Patryk','Kozie�','39070956339','122329410','velit.egestas.lacinia@sitamet.edu'),
		   ('Przemys�aw','Kozie�','44072761632','240216717','Praesent@id.ca'),
		   ('David','Rutkowski','01262057290','415165453','nunc.sed@PraesentluctusCurabitur.ca')
GO

-- UZUPE�NIANIE TABELI �odzie podwodne

USE [Wypo�yczalnia�odziPodwodnych]
GO

INSERT INTO [dbo].[�odzie_podwodne]
           ([Nazwa],[Ilo��_os�b],[G��boko��_zanurzenia],[Pr�dko��],[Waga],[D�ugo��],[Wysoko��],[Cena],[Status])
     VALUES
           ('Nexus',6,240,22,2100,540,300,25000,'wolny'),
           ('DeepSwamp',5,1500,15,1500,480,310,42000,'wolny'),
           ('LittleCube',2,300,17,1100,440,240,10000,'zajety'),
           ('Spaceless',4,515,34,1800,520,280,17000,'wolny'),
           ('Vortex',5,150,54,1700,500,300,40000,'zajety');
GO

-- UZUPE�NIANIE TABELI Oddzia� --

USE [Wypo�yczalnia�odziPodwodnych]
GO

INSERT INTO [dbo].[Oddzial]
           ([Miasto]
           ,[Ulica]
           ,[Kod_Pocztowy]
           ,[Telefon])
     VALUES
           ('S�upsk','��kowa','15-377','689324154'),
		   ('Opole','Lipowa','58-580','865574753'),
		   ('Wroc�aw','Ko���taja','74-274','584310323')
GO




