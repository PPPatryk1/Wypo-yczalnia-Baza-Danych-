Use [Wypo¿yczalnia£odziPodwodnych]
IF exists (select * from sys.objects where name='funkcja_zajete_³odzie')
begin
DROP function dbo.raport_zajete_³odzie;
end
go

CREATE FUNCTION raport_zajete_³odzie()

RETURNS table
as

	return
	(SELECT [Nazwa], [Iloœæ_osób],[G³êbokoœæ_zanurzenia],[Prêdkoœæ],[Waga],[D³ugoœæ],[Wysokoœæ],[Cena],[Status] FROM [dbo].[£odzie_podwodne]
	WHERE [Status] ='zajete');

	
go

--Wywo³anie
select *
from raport_zajete_³odzie()