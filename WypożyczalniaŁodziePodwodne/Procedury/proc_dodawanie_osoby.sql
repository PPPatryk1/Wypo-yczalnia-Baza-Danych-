Use [Wypo¿yczalnia£odziPodwodnych]
BEGIN
	IF exists (select * from sys.procedures where name='Dodawanie_osoby') 
		DROP PROC dbo.Dodawanie_osoby;
END;
GO
CREATE PROC dbo.Dodawanie_osoby
--Input
@ID AS int,
@Imie as varchar(50),
@Nazwisko as varchar(50),
@Pesel as char(11),
@Telefon as char(9),
@Adres_Email varchar(50)

AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE
		@error_kod nvarchar(6) = '',
		@error_opis nvarchar(200) = '';
	
		IF @Imie= ''
		BEGIN
			SET @error_kod = 'XYZ001';
			SET @error_opis = 'Nie podano imienia';
			RAISERROR(@error_opis,15,1);
		END
		IF @Nazwisko = ''
		BEGIN
			SET @error_kod = 'XYZ002';
			SET @error_opis = 'Nie podano nazwiska';
			RAISERROR(@error_opis,15,1);
		END
		IF @Pesel = ''
		BEGIN
			SET @error_kod = 'XYZ003';
			SET @error_opis = 'Nie podano Peselu';
			RAISERROR(@error_opis,15,1);
		END
		IF @Telefon = ''
		BEGIN
			SET @error_kod = 'XYZ004';
			SET @error_opis = 'Nie podano numeru telefonu';
			RAISERROR(@error_opis,15,1);
		END
		IF @Adres_Email = ''
		BEGIN
			SET @error_kod = 'XYZ005';
			SET @error_opis = 'Nie podano adresu email';
			RAISERROR(@error_opis,15,1);
		END
		BEGIN TRY
				Set identity_insert [dbo].[osoba] on
				Insert into [dbo].[osoba](ID, Imie ,Nazwisko ,Pesel, Telefon, Adres_Email)
				values((Select Max(osoba.ID)+1 from osoba), @Imie ,@Nazwisko ,@Pesel,@Telefon,@Adres_Email)
				Set identity_insert [dbo].[osoba] off
			END TRY
			BEGIN CATCH
				SET @error_kod = 'XYZ010';
				SET @error_opis = 'B³¹d podczas dodawania nowej osoby.';
				RAISERROR(@error_opis,15,1)
		END CATCH;
		
END TRY
BEGIN CATCH
	PRINT 'B³¹d:' + @error_kod;
	PRINT 'Opis:' + @error_opis;
END CATCH
end;
go

--Wywo³anie
exec Dodawanie_osoby 8,'Mieczys³aw','Wieczys³aw','44121126985','548745154','whereismybrain@gmail.com'