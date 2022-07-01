Use [Wypo¿yczalnia£odziPodwodnych]
GO

DROP PROC IF EXISTS up_Zmiana_danych_oddzia³u
GO

CREATE PROC up_Zmiana_danych_oddzia³u
-- Input
@Id as int,
@Miasto as varchar(50),
@Ulica as varchar(50),
@KodPocztowy as char(6),
@Telefon as char(9)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE
			@error_kod nvarchar(6) = '',
			@error_opis nvarchar(200) = '';

		IF @Miasto = ''
			BEGIN
				set @Miasto = (SELECT [Miasto] FROM [dbo].[Oddzial] WHERE [ID] = @Id);
			END

		IF @Ulica = ''
			BEGIN
				set @Ulica = (SELECT [Ulica] FROM [dbo].[Oddzial] WHERE [ID] = @Id);
			END

		IF @KodPocztowy = ''
			BEGIN
				set @KodPocztowy = (SELECT [Kod_Pocztowy] FROM [dbo].[Oddzial] WHERE [ID] = @Id);
			END

		IF @Telefon = ''
			BEGIN
				set @Telefon = (SELECT [Telefon] FROM [dbo].[Oddzial] WHERE [ID] = @Id);
			END
		
		IF LEN(@Telefon) < 9
			BEGIN
				SET @error_kod = 'XYZ001';
				SET @error_opis = 'Niepoprawny numer telefonu';
				RAISERROR(@error_opis,15,1);
			END

		BEGIN TRY

			UPDATE [dbo].[Oddzial]
			   SET [Miasto] = @Miasto
				  ,[Ulica] = @Ulica
				  ,[Kod_Pocztowy] = @KodPocztowy
				  ,[Telefon] = @Telefon
			 WHERE [ID] = @Id

		END TRY
		BEGIN CATCH
			SET @error_kod = 'XYZ002';
			SET @error_opis = 'B³¹d podczas aktualizacji danych oddzia³u.';
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
exec up_Zmiana_danych_oddzia³u 2, '£ódŸ', '', '', ''