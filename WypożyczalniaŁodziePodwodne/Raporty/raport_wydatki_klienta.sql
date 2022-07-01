Use [Wypo�yczalnia�odziPodwodnych]
GO

DROP FUNCTION IF EXISTS raport_wydatki_klienta
GO

CREATE FUNCTION raport_wydatki_klienta()

RETURNS table
as

	return
	(SELECT  os.ID, os.Imie, os.Nazwisko, os.Pesel, SUM(u.Cena_ca�kowita) as 'Ca�kowite wydatki'
	FROM [dbo].[Umowa] as u, [dbo].[osoba] as os 
	WHERE os.ID = u.id
	GROUP BY os.ID, os.Imie, os.Nazwisko, os.Pesel);
go

--Wywo�anie
select *
from raport_wydatki_klienta()