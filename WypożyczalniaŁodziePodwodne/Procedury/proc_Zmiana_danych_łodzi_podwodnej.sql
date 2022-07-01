Use [Wypo篡czalniaυdziPodwodnych]
GO

DROP PROC IF EXISTS up_Zmiana_danych_這dzi_podwodnej
GO

CREATE PROC up_Zmiana_danych_這dzi_podwodnej
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
				SET @error_opis = 'Nieprawid這wa cena';
				RAISERROR(@error_opis,15,1);
			END
		BEGIN TRY

			UPDATE [dbo].[υdzie_podwodne]
			   SET [Cena] = @Cena
			 WHERE [ID] = @Id

		END TRY
		BEGIN CATCH
			SET @error_kod = 'XYZ002';
			SET @error_opis = 'B章d podczas aktualizacji danych 這dzi.';
			RAISERROR(@error_opis,15,1)
		END CATCH
	END TRY
	BEGIN CATCH
		PRINT 'B章d:' + @error_kod;
		PRINT 'Opis:' + @error_opis;
	END CATCH
END
GO

--Wywo豉nie
exec up_Zmiana_danych_這dzi_podwodnej 2, 50000