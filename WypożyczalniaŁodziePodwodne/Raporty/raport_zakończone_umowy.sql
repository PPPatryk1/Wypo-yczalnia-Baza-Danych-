Use [Wypo¿yczalnia£odziPodwodnych]
GO

-- Raport Zakoñczonych umów
DROP FUNCTION IF EXISTS raport_zakoñczone_umowy
GO

CREATE FUNCTION raport_zakoñczone_umowy()

RETURNS table
as

	return
	(SELECT u.[ID], os.Imie + ' ' + os.Nazwisko as 'Imiê i nazwisko', os.Pesel, od.Miasto + ' ' + od.Ulica + ' ' + od.Kod_Pocztowy as 'Odzia³', pod.Nazwa as 'Model ³odzi podwodnej', u.Cena_ca³kowita, u.Dzieñ_rozpoczêcia, u.Dzieñ_zakoñczenia
	FROM [dbo].[Umowa] as u, [dbo].[osoba] as os , [dbo].[Oddzial] as od, [dbo].[£odzie_podwodne] as pod
	WHERE [Dzieñ_zakoñczenia] < GETDATE() AND u.[ID] = os.[ID] AND u.[ID£odziPodwodnej] = pod.[Id] AND u.[IDOddzia³u] = od.[ID]);

	
go

--Wywo³anie
select *
from raport_zakoñczone_umowy()