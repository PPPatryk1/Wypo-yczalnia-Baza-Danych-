USE [WypożyczalniaŁodziPodwodnych]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF exists (select * from sys.objects where name='trigger_zmiana_statusu')
BEGIN
	DROP trigger trigger_zmiana_statusu
END;
GO

create TRIGGER [dbo].trigger_zmiana_statusu ON [dbo].[Łodzie_podwodne]
after UPDATE,insert
AS ​
BEGIN
  Declare @status varchar(10)
  SET @status = (Select ​status from inserted)

  IF @status = 'zajety'
	Update [dbo].[Łodzie_podwodne] Set [Status] = 'wolny' where Łodzie_podwodne.Id=(Select Id from inserted)
	else if
	@status = 'wolny'
	Update [dbo].[Łodzie_podwodne] Set [Status] = 'zajety' where Łodzie_podwodne.Id=(Select Id from inserted)
END​


