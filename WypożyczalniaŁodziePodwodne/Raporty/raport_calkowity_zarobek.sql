Use [Wypo�yczalnia�odziPodwodnych]
GO

DROP FUNCTION IF EXISTS raport_calkowity_zarobek
GO

CREATE FUNCTION raport_calkowity_zarobek()

RETURNS table
as

	return
	(SELECT SUM(u.Cena_ca�kowita) as 'Ca�kowita kwota'
	FROM [dbo].[Umowa] as u);
go

--Wywo�anie
select *
from raport_calkowity_zarobek()