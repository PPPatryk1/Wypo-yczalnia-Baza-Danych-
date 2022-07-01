Use [Wypo¿yczalnia£odziPodwodnych]
BEGIN
	IF exists (select * from sys.procedures where name='Dodawanie_lodzi') 
		DROP PROC dbo.Dodawanie_lodzi;
END;
GO
CREATE PROC dbo.Dodawanie_lodzi
--Input
@Id AS int,
@Nazwa as varchar(30),
@Iloœæ_osób as int,
@G³êbokoœæ_zanurzenia as int,
@Prêdkoœæ as int,
@Waga as int,
@D³ugoœæ as int,
@Wysokoœæ as int,
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
		IF @Iloœæ_osób = ''
		BEGIN
			SET @error_kod = 'XYZ002';
			SET @error_opis = 'Nie podano iloœci osób';
			RAISERROR(@error_opis,15,1);
		END
		IF @G³êbokoœæ_zanurzenia = ''
		BEGIN
			SET @error_kod = 'XYZ003';
			SET @error_opis = 'Nie podano g³êbokoœci zanurzenia';
			RAISERROR(@error_opis,15,1);
		END
		IF @Prêdkoœæ = ''
		BEGIN
			SET @error_kod = 'XYZ004';
			SET @error_opis = 'Nie podano prêdkoœci';
			RAISERROR(@error_opis,15,1);
		END
		IF @Waga = ''
		BEGIN
			SET @error_kod = 'XYZ005';
			SET @error_opis = 'Nie podano wagi';
			RAISERROR(@error_opis,15,1);
		END
		IF @D³ugoœæ = ''
		BEGIN
			SET @error_kod = 'XYZ006';
			SET @error_opis = 'Nie podano d³ugoœci';
			RAISERROR(@error_opis,15,1);
		END
		IF @Wysokoœæ = ''
		BEGIN
			SET @error_kod = 'XYZ007';
			SET @error_opis = 'Nie podano wysokoœci';
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
				Set identity_insert [dbo].[£odzie_podwodne] on
				Insert into [dbo].[£odzie_podwodne](Id, Nazwa ,Iloœæ_osób ,G³êbokoœæ_zanurzenia,Prêdkoœæ,Waga,D³ugoœæ,Wysokoœæ,Cena,Status)
				values((Select Max(£odzie_podwodne.Id)+1 from £odzie_podwodne), @Nazwa ,@Iloœæ_osób ,@G³êbokoœæ_zanurzenia,@Prêdkoœæ,@Waga,@D³ugoœæ,@Wysokoœæ,@Cena,@Status)
				Set identity_insert [dbo].[£odzie_podwodne] off
			END TRY
			BEGIN CATCH
				SET @error_kod = 'XYZ010';
				SET @error_opis = 'B³¹d podczas dodawania nowej ³odzi.';
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
exec Dodawanie_lodzi 1,'Pike',3,300,22,1700,400,260,12500,'zajety'