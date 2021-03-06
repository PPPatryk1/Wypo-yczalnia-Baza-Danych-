USE [WypożyczalniaŁodziPodwodnych]
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

	set @cenaLodzi = (SELECT pod.[Cena] FROM [dbo].[Łodzie_podwodne] as pod, inserted as u WHERE pod.[Id] = u.[IDŁodziPodwodnej]);

	set @dni = (SELECT DATEDIFF(day, [Dzień_zakończenia], [Dzień_rozpoczęcia]) FROM inserted);

	set @ogolnaCena = (@cenaLodzi * @dni);

	if @ogolnaCena < 0
	BEGIN 
		set @ogolnaCena = @ogolnaCena * (-1)
	END

	UPDATE [dbo].[Umowa] set [Cena_całkowita] = @ogolnaCena WHERE [ID] = (SELECT ID FROM inserted)
END