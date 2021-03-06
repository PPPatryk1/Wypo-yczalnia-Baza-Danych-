Use [WypożyczalniaŁodziPodwodnych]
GO

-- Raport Zakończonych umów
DROP FUNCTION IF EXISTS raport_umowy
GO

CREATE FUNCTION raport_umowy()

RETURNS table
as

	return
	(SELECT u.[ID], os.Imie + ' ' + os.Nazwisko as 'Imię i nazwisko', os.Pesel, od.Miasto + ' ' + od.Ulica + ' ' + od.Kod_Pocztowy as 'Odział', pod.Nazwa as 'Model łodzi podwodnej', u.Cena_całkowita, u.Dzień_rozpoczęcia, u.Dzień_zakończenia
	FROM [dbo].[Umowa] as u, [dbo].[osoba] as os , [dbo].[Oddzial] as od, [dbo].[Łodzie_podwodne] as pod
	WHERE u.[ID] = os.[ID] AND u.[IDŁodziPodwodnej] = pod.[Id] AND u.[IDOddziału] = od.[ID]);

	
go

--Wywołanie
select *
from raport_umowy()