Use [Wypo�yczalnia�odziPodwodnych]
IF exists (select * from sys.objects where name='funkcja_zajete_�odzie')
begin
DROP function dbo.raport_zajete_�odzie;
end
go

CREATE FUNCTION raport_zajete_�odzie()

RETURNS table
as

	return
	(SELECT [Nazwa], [Ilo��_os�b],[G��boko��_zanurzenia],[Pr�dko��],[Waga],[D�ugo��],[Wysoko��],[Cena],[Status] FROM [dbo].[�odzie_podwodne]
	WHERE [Status] ='zajete');

	
go

--Wywo�anie
select *
from raport_zajete_�odzie()