IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClearDatabaseTran]'))
	DROP PROCEDURE [dbo].[ClearDatabaseTran]
GO
CREATE PROCEDURE [dbo].[ClearDatabaseTran]
AS
BEGIN
	SET XACT_ABORT ON;
	BEGIN TRY
		BEGIN TRANSACTION;
			EXEC [dbo].[OrderConstraintsRemove];
			EXEC [dbo].[WorkerConstraintsRemove];

				BEGIN TRY
					TRUNCATE TABLE [Order];
					TRUNCATE TABLE [Worker];
					TRUNCATE TABLE [TimeLog];
					TRUNCATE TABLE [OrderToWorker];	
					TRUNCATE TABLE [Client];
				END TRY
				BEGIN CATCH
					SELECT
					'failure' as [Status],
					ERROR_PROCEDURE() AS [Procedure], 
					ERROR_MESSAGE() AS ErrorMessage;
				END CATCH
					
			EXEC [dbo].[OrderConstraintsAdd];
			EXEC [dbo].[WorkerConstraintsAdd];
		COMMIT TRANSACTION;
	END TRY		
	BEGIN CATCH
		IF (XACT_STATE()) = -1
			BEGIN  
				PRINT 'The transaction is in an uncommittable state.' +  
					  ' Rolling back transaction.'  
				ROLLBACK TRANSACTION;  
			END;  
	    IF (XACT_STATE()) = 1  
			BEGIN  
				PRINT 'The transaction is committable.' +   
					  ' Committing transaction.'
				COMMIT TRANSACTION;     
			END; 	
	END CATCH;
END;
GO