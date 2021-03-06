Use [WypożyczalniaŁodziPodwodnych]
GO

DROP FUNCTION IF EXISTS raport_wynikow_oddzialu
GO

CREATE FUNCTION raport_wynikow_oddzialu()

RETURNS table
as

	return
	(SELECT od.Miasto, od.Ulica, od.Kod_Pocztowy, SUM(u.Cena_całkowita) as 'Całkowita kwota', COUNT(u.IDOddziału) as 'Ilość wypożyczeń'
	FROM [dbo].[Umowa] as u, [dbo].[Oddzial] as od
	WHERE u.IDOddziału = od.ID
	GROUP BY od.Miasto, od.Ulica, od.Kod_Pocztowy);
go

--Wywołanie
select *
from raport_wynikow_oddzialu()