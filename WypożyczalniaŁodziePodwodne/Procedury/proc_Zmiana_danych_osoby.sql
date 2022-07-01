Use [Wypo¿yczalnia£odziPodwodnych]
GO

DROP PROC IF EXISTS up_Zmiana_danych_osoby
GO

CREATE PROC up_Zmiana_danych_osoby
-- Input
@Id as int,
@Imie as nvarchar(50),
@Nazwisko as nvarchar(50),
@Telefon as char(9),
@Email as nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE
			@error_kod nvarchar(6) = '',
			@error_opis nvarchar(200) = '';

		IF @Imie = ''
			BEGIN
				set @Imie = (SELECT [Imie] FROM [dbo].[osoba] WHERE [ID] = @Id);
			END

		IF @Nazwisko = ''
			BEGIN
				set @Nazwisko = (SELECT [Nazwisko] FROM [dbo].[osoba] WHERE [ID] = @Id);
			END

		IF @Telefon = ''
			BEGIN
				set @Telefon = (SELECT [Telefon] FROM [dbo].[osoba] WHERE [ID] = @Id);
			END

		IF LEN(@Telefon) < 9
			BEGIN
				SET @error_kod = 'XYZ001';
				SET @error_opis = 'Niepoprawny numer telefonu';
				RAISERROR(@error_opis,15,1);
			END

		IF @Email = ''
			BEGIN
				set @Email = (SELECT [Adres_Email] FROM [dbo].[osoba] WHERE [ID] = @Id);
			END

		BEGIN TRY
			UPDATE [dbo].[osoba]
			   SET [Imie] = @Imie
				  ,[Nazwisko] = @Nazwisko
				  ,[Telefon] = @Telefon
				  ,[Adres_Email] = @Email
			 WHERE [ID] = @Id

		END TRY
		BEGIN CATCH
			SET @error_kod = 'XYZ002';
			SET @error_opis = 'B³¹d podczas aktualizacji danych osobowych.';
			RAISERROR(@error_opis,15,1)
		END CATCH
	END TRY
	BEGIN CATCH
		PRINT 'B³¹d:' + @error_kod;
		PRINT 'Opis:' + @error_opis;
	END CATCH
END
GO

--Wywo³anie
exec up_Zmiana_danych_osoby 2, 'Janusz', 'Miroczk³awicz', '123456789', 'testerower@gmail.com'