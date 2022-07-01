USE [Wypo�yczalnia�odziPodwodnych]
GO

DROP TRIGGER IF EXISTS trigger_oblicz_cene_umowy
GO

CREATE TRIGGER trigger_oblicz_cene_umowy ON [dbo].[Umowa]
after UPDATE, INSERT
AS
BEGIN
	DECLARE @cenaLodzi int;

	DECLARE @dni int;
	DECLARE @ogolnaCena int;

	set @cenaLodzi = (SELECT pod.[Cena] FROM [dbo].[�odzie_podwodne] as pod, inserted as u WHERE pod.[Id] = u.[ID�odziPodwodnej]);

	set @dni = (SELECT DATEDIFF(day, [Dzie�_zako�czenia], [Dzie�_rozpocz�cia]) FROM inserted);

	set @ogolnaCena = (@cenaLodzi * @dni);

	if @ogolnaCena < 0
	BEGIN 
		set @ogolnaCena = @ogolnaCena * (-1)
	END

	UPDATE [dbo].[Umowa] set [Cena_ca�kowita] = @ogolnaCena WHERE [ID] = (SELECT ID FROM inserted)
END