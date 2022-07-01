Use [Wypo�yczalnia�odziPodwodnych]
GO

DROP PROC IF EXISTS up_Zmiana_danych_�odzi_podwodnej
GO

CREATE PROC up_Zmiana_danych_�odzi_podwodnej
-- Input
@Id as int,
@Cena as int
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE
			@error_kod nvarchar(6) = '',
			@error_opis nvarchar(200) = '';

		IF @Cena = ''
			BEGIN
				SET @error_kod = 'XYZ001';
				SET @error_opis = 'Nieprawid�owa cena';
				RAISERROR(@error_opis,15,1);
			END
		BEGIN TRY

			UPDATE [dbo].[�odzie_podwodne]
			   SET [Cena] = @Cena
			 WHERE [ID] = @Id

		END TRY
		BEGIN CATCH
			SET @error_kod = 'XYZ002';
			SET @error_opis = 'B��d podczas aktualizacji danych �odzi.';
			RAISERROR(@error_opis,15,1)
		END CATCH
	END TRY
	BEGIN CATCH
		PRINT 'B��d:' + @error_kod;
		PRINT 'Opis:' + @error_opis;
	END CATCH
END
GO

--Wywo�anie
exec up_Zmiana_danych_�odzi_podwodnej 2, 50000