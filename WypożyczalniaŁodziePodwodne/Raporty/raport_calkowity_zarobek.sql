Use [WypożyczalniaŁodziPodwodnych]
GO

DROP FUNCTION IF EXISTS raport_calkowity_zarobek
GO

CREATE FUNCTION raport_calkowity_zarobek()

RETURNS table
as

	return
	(SELECT SUM(u.Cena_całkowita) as 'Całkowita kwota'
	FROM [dbo].[Umowa] as u);
go

--Wywołanie
select *
from raport_calkowity_zarobek()