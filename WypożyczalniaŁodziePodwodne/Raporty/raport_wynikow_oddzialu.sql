Use [Wypo�yczalnia�odziPodwodnych]
GO

DROP FUNCTION IF EXISTS raport_wynikow_oddzialu
GO

CREATE FUNCTION raport_wynikow_oddzialu()

RETURNS table
as

	return
	(SELECT od.Miasto, od.Ulica, od.Kod_Pocztowy, SUM(u.Cena_ca�kowita) as 'Ca�kowita kwota', COUNT(u.IDOddzia�u) as 'Ilo�� wypo�ycze�'
	FROM [dbo].[Umowa] as u, [dbo].[Oddzial] as od
	WHERE u.IDOddzia�u = od.ID
	GROUP BY od.Miasto, od.Ulica, od.Kod_Pocztowy);
go

--Wywo�anie
select *
from raport_wynikow_oddzialu()