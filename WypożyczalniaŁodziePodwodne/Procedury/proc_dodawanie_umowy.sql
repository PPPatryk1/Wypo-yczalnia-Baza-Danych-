Use [Wypo¿yczalnia£odziPodwodnych]
BEGIN
	IF exists (select * from sys.procedures where name='Dodawanie_umowy') 
		DROP PROC dbo.Dodawanie_umowy;
END;
GO
CREATE PROC dbo.Dodawanie_umowy
--Input
@ID AS int,
@IDlodzi as int,
@IDosoby as int,
@IDoddzialu as int,
@Dzien_roz as date,
@Dzien_zak as date

AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE
		@error_kod nvarchar(6) = '',
		@error_opis nvarchar(200) = '';
	
		IF @IDlodzi= ''
		BEGIN
			SET @error_kod = 'XYZ001';
			SET @error_opis = 'Nie podano id lodzi';
			RAISERROR(@error_opis,15,1);
		END
		IF @IDoddzialu = ''
		BEGIN
			SET @error_kod = 'XYZ002';
			SET @error_opis = 'Nie podano id oddzialu';
			RAISERROR(@error_opis,15,1);
		END
		IF @IDosoby = ''
		BEGIN
			SET @error_kod = 'XYZ003';
			SET @error_opis = 'Nie podano id osoby';
			RAISERROR(@error_opis,15,1);
		END
		IF @Dzien_roz = ''
		BEGIN
			SET @error_kod = 'XYZ004';
			SET @error_opis = 'Nie podano daty rozpoczêcia';
			RAISERROR(@error_opis,15,1);
		END
		IF @Dzien_zak = ''
		BEGIN
			SET @error_kod = 'XYZ005';
			SET @error_opis = 'Nie podano daty zakoñczenia';
			RAISERROR(@error_opis,15,1);
		END
		BEGIN TRY
				Set identity_insert [dbo].[Umowa] on
				Insert into [dbo].[Umowa](ID, ID£odziPodwodnej ,IDOddzia³u ,IDOsoby, Dzieñ_rozpoczêcia, Dzieñ_zakoñczenia)
				values((Select Max(Umowa.ID)+1 from Umowa), @IDlodzi ,@IDoddzialu ,@IDosoby,@Dzien_roz,@Dzien_zak)
				Set identity_insert [dbo].[Umowa] off
			END TRY
			BEGIN CATCH
				SET @error_kod = 'XYZ010';
				SET @error_opis = 'B³¹d podczas dodawania nowej umowy.';
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
exec Dodawanie_umowy 1,4,3,3,'2022-03-01','2022-03-15'