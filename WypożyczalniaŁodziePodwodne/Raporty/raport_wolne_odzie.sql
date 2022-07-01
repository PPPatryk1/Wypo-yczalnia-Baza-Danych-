Use [Wypo�yczalnia�odziPodwodnych]
IF exists (select * from sys.objects where name='funkcja_wolne_�odzie')
begin
DROP function dbo.raport_wolne_�odzie;
end
go

CREATE FUNCTION raport_wolne_�odzie()

RETURNS table
as

	return
	(SELECT [Nazwa], [Ilo��_os�b],[G��boko��_zanurzenia],[Pr�dko��],[Waga],[D�ugo��],[Wysoko��],[Cena],[Status] FROM [dbo].[�odzie_podwodne]
	WHERE [Status] ='wolny');

	
go

--Wywo�anie
select *
from raport_wolne_�odzie()