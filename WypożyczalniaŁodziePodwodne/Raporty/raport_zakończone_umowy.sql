Use [Wypo�yczalnia�odziPodwodnych]
GO

-- Raport Zako�czonych um�w
DROP FUNCTION IF EXISTS raport_zako�czone_umowy
GO

CREATE FUNCTION raport_zako�czone_umowy()

RETURNS table
as

	return
	(SELECT u.[ID], os.Imie + ' ' + os.Nazwisko as 'Imi� i nazwisko', os.Pesel, od.Miasto + ' ' + od.Ulica + ' ' + od.Kod_Pocztowy as 'Odzia�', pod.Nazwa as 'Model �odzi podwodnej', u.Cena_ca�kowita, u.Dzie�_rozpocz�cia, u.Dzie�_zako�czenia
	FROM [dbo].[Umowa] as u, [dbo].[osoba] as os , [dbo].[Oddzial] as od, [dbo].[�odzie_podwodne] as pod
	WHERE [Dzie�_zako�czenia] < GETDATE() AND u.[ID] = os.[ID] AND u.[ID�odziPodwodnej] = pod.[Id] AND u.[IDOddzia�u] = od.[ID]);

	
go

--Wywo�anie
select *
from raport_zako�czone_umowy()