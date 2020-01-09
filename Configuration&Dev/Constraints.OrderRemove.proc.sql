IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderConstraintsRemove]'))
	DROP PROCEDURE [dbo].[OrderConstraintsRemove]
GO
CREATE PROCEDURE [dbo].[OrderConstraintsRemove]
AS
BEGIN
	--Order to Client FK key removal
	BEGIN TRY
		ALTER TABLE [Order]
		DROP CONSTRAINT [FK_Order_Client_ClientId];		
	END TRY
	BEGIN CATCH
	END CATCH

	--Order to Worker FK key removal
	BEGIN TRY
			ALTER TABLE [dbo].[Order]
		DROP CONSTRAINT [FK_Order_Worker_SupervisorId];
	END TRY
	BEGIN CATCH
	END CATCH

	--Part to Order FK key removal
	BEGIN TRY
		ALTER TABLE [dbo].[Part]
		DROP CONSTRAINT [FK_Part_Order_OrderId];
	END TRY
	BEGIN CATCH
	END CATCH

	--TimeLog to Order FK key removal
	BEGIN TRY
		ALTER TABLE [dbo].[TimeLog]
		DROP CONSTRAINT [FK_TimeLog_Order_OrderId];		
	END TRY
	BEGIN CATCH
	END CATCH

	--OrderToWorker to Order FK key removal
	BEGIN TRY
		ALTER TABLE [dbo].[OrderToWorker]
		DROP CONSTRAINT [FK_OrderToWorker_Order_OrderId];		
	END TRY
	BEGIN CATCH
	END CATCH
END