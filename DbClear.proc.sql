IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClearDatabase]'))
	DROP PROCEDURE [dbo].[ClearDatabase]
GO
CREATE PROCEDURE [dbo].[ClearDatabase]
AS
BEGIN
	BEGIN TRY
		EXEC [dbo].[OrderConstraintsRemove];
		EXEC [dbo].[WorkerConstraintsRemove];
		TRUNCATE TABLE [dbo].[Order];
		TRUNCATE TABLE [dbo].[Worker];
		TRUNCATE TABLE [dbo].[Part];

		DELETE FROM [dbo].[AppUserToAppRole];
		DBCC CHECKIDENT ('[AppUserToAppRole]', RESEED, 0);
		DELETE FROM [dbo].[AppUser];
		DBCC CHECKIDENT ('[AppUser]', RESEED, 0);

		TRUNCATE TABLE [dbo].[TimeLog];
		TRUNCATE TABLE [dbo].[OrderToWorker];	
		TRUNCATE TABLE [dbo].[Client];
		EXEC [dbo].[OrderConstraintsAdd];
		EXEC [dbo].[WorkerConstraintsAdd];
	END TRY		
	BEGIN CATCH
		SELECT 
		'failure' as [Status],
		ERROR_PROCEDURE() AS [Procedure], 
		ERROR_MESSAGE() AS ErrorMessage;
	END CATCH;
END;
GO