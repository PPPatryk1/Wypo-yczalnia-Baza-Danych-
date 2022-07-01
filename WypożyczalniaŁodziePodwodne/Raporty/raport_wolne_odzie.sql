Use [Wypo¿yczalnia£odziPodwodnych]
IF exists (select * from sys.objects where name='funkcja_wolne_³odzie')
begin
DROP function dbo.raport_wolne_³odzie;
end
go

CREATE FUNCTION raport_wolne_³odzie()

RETURNS table
as

	return
	(SELECT [Nazwa], [Iloœæ_osób],[G³êbokoœæ_zanurzenia],[Prêdkoœæ],[Waga],[D³ugoœæ],[Wysokoœæ],[Cena],[Status] FROM [dbo].[£odzie_podwodne]
	WHERE [Status] ='wolny');

	
go

--Wywo³anie
select *
from raport_wolne_³odzie()