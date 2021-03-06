Use [WypożyczalniaŁodziPodwodnych]
GO

DROP FUNCTION IF EXISTS raport_wydatki_klienta
GO

CREATE FUNCTION raport_wydatki_klienta()

RETURNS table
as

	return
	(SELECT  os.ID, os.Imie, os.Nazwisko, os.Pesel, SUM(u.Cena_całkowita) as 'Całkowite wydatki'
	FROM [dbo].[Umowa] as u, [dbo].[osoba] as os 
	WHERE os.ID = u.id
	GROUP BY os.ID, os.Imie, os.Nazwisko, os.Pesel);
go

--Wywołanie
select *
from raport_wydatki_klienta()