--	WARNING!
--	Will remove Orders entites too (!) 
--		-> because Order have non nullable reference to Client...
--	Will remove OrderToWorker junction table entites too (!)
--		-> because OrderToWorker have non nullable reference to Order (and Worker)...
--	Will remove TimeLog entites too (!)
--		-> because TimeLog have non nullable reference to Order (and Worker)...

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClearClients]'))
	DROP PROCEDURE [dbo].[ClearClients]
GO
CREATE PROCEDURE [dbo].[ClearClients]
AS
BEGIN

	EXEC [dbo].[OrderConstraintsRemove];

	TRUNCATE TABLE [Order];

	TRUNCATE TABLE [OrderToWorker];
	
	TRUNCATE TABLE [Client];

	EXEC [dbo].[OrderConstraintsAdd];
	
END