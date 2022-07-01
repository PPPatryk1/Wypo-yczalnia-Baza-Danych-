Use [Wypo�yczalnia�odziPodwodnych]
BEGIN
	IF exists (select * from sys.procedures where name='Dodawanie_lodzi') 
		DROP PROC dbo.Dodawanie_lodzi;
END;
GO
CREATE PROC dbo.Dodawanie_lodzi
--Input
@Id AS int,
@Nazwa as varchar(30),
@Ilo��_os�b as int,
@G��boko��_zanurzenia as int,
@Pr�dko�� as int,
@Waga as int,
@D�ugo�� as int,
@Wysoko�� as int,
@Cena as int,
@Status as varchar(10)

AS
BEGIN
SET NOCOUNT ON;
BEGIN TRY
	DECLARE
		@error_kod nvarchar(6) = '',
		@error_opis nvarchar(200) = '';
	
		IF @Nazwa = ''
		BEGIN
			SET @error_kod = 'XYZ001';
			SET @error_opis = 'Nie podano nazwy';
			RAISERROR(@error_opis,15,1);
		END
		IF @Ilo��_os�b = ''
		BEGIN
			SET @error_kod = 'XYZ002';
			SET @error_opis = 'Nie podano ilo�ci os�b';
			RAISERROR(@error_opis,15,1);
		END
		IF @G��boko��_zanurzenia = ''
		BEGIN
			SET @error_kod = 'XYZ003';
			SET @error_opis = 'Nie podano g��boko�ci zanurzenia';
			RAISERROR(@error_opis,15,1);
		END
		IF @Pr�dko�� = ''
		BEGIN
			SET @error_kod = 'XYZ004';
			SET @error_opis = 'Nie podano pr�dko�ci';
			RAISERROR(@error_opis,15,1);
		END
		IF @Waga = ''
		BEGIN
			SET @error_kod = 'XYZ005';
			SET @error_opis = 'Nie podano wagi';
			RAISERROR(@error_opis,15,1);
		END
		IF @D�ugo�� = ''
		BEGIN
			SET @error_kod = 'XYZ006';
			SET @error_opis = 'Nie podano d�ugo�ci';
			RAISERROR(@error_opis,15,1);
		END
		IF @Wysoko�� = ''
		BEGIN
			SET @error_kod = 'XYZ007';
			SET @error_opis = 'Nie podano wysoko�ci';
			RAISERROR(@error_opis,15,1);
		END
		IF @Cena = ''
		BEGIN
			SET @error_kod = 'XYZ008';
			SET @error_opis = 'Nie podano ceny';
			RAISERROR(@error_opis,15,1);
		END
		IF @Status = ''
		BEGIN
			SET @error_kod = 'XYZ009';
			SET @error_opis = 'Nie podano statusu';
			RAISERROR(@error_opis,15,1);
		END
		BEGIN TRY
				Set identity_insert [dbo].[�odzie_podwodne] on
				Insert into [dbo].[�odzie_podwodne](Id, Nazwa ,Ilo��_os�b ,G��boko��_zanurzenia,Pr�dko��,Waga,D�ugo��,Wysoko��,Cena,Status)
				values((Select Max(�odzie_podwodne.Id)+1 from �odzie_podwodne), @Nazwa ,@Ilo��_os�b ,@G��boko��_zanurzenia,@Pr�dko��,@Waga,@D�ugo��,@Wysoko��,@Cena,@Status)
				Set identity_insert [dbo].[�odzie_podwodne] off
			END TRY
			BEGIN CATCH
				SET @error_kod = 'XYZ010';
				SET @error_opis = 'B��d podczas dodawania nowej �odzi.';
				RAISERROR(@error_opis,15,1)
		END CATCH;
		
END TRY
BEGIN CATCH
	PRINT 'B��d:' + @error_kod;
	PRINT 'Opis:' + @error_opis;
END CATCH
end;
go

--Wywo�anie
exec Dodawanie_lodzi 1,'Pike',3,300,22,1700,400,260,12500,'zajety'