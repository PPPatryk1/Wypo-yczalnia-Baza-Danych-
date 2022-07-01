Use [Wypo¿yczalnia£odziPodwodnych]
BEGIN
	IF exists (select * from sys.procedures where name='Dodawanie_oddzialu') 
		DROP PROC dbo.Dodawanie_oddzialu;
END;
GO
CREATE PROC dbo.Dodawanie_oddzialu
--Input
@ID AS int,
@Miasto as varchar(50),
@Ulica as varchar(50),
@Kod_Pocztowy as varchar(6),
@Telefon as char(9)

AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE
		@error_kod nvarchar(6) = '',
		@error_opis nvarchar(200) = '';
	
		IF @Miasto= ''
		BEGIN
			SET @error_kod = 'XYZ001';
			SET @error_opis = 'Nie podano nazwy miasta';
			RAISERROR(@error_opis,15,1);
		END
		IF @Ulica = ''
		BEGIN
			SET @error_kod = 'XYZ002';
			SET @error_opis = 'Nie podano ulicy';
			RAISERROR(@error_opis,15,1);
		END
		IF @Kod_Pocztowy = ''
		BEGIN
			SET @error_kod = 'XYZ003';
			SET @error_opis = 'Nie podano kodu pocztowego';
			RAISERROR(@error_opis,15,1);
		END
		IF @Telefon = ''
		BEGIN
			SET @error_kod = 'XYZ004';
			SET @error_opis = 'Nie podano numeru telefonu';
			RAISERROR(@error_opis,15,1);
		END
		BEGIN TRY
				Set identity_insert [dbo].[Oddzial] on
				Insert into [dbo].[Oddzial](Id, Miasto ,Ulica ,Kod_Pocztowy, Telefon)
				values((Select Max(Oddzial.ID)+1 from Oddzial), @Miasto ,@Ulica ,@Kod_Pocztowy,@Telefon)
				Set identity_insert [dbo].[Oddzial] off
			END TRY
			BEGIN CATCH
				SET @error_kod = 'XYZ010';
				SET @error_opis = 'B³¹d podczas dodawania nowego oddzia³u.';
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
exec Dodawanie_oddzialu 4,'Sydney','Midway','55-555','845745987'