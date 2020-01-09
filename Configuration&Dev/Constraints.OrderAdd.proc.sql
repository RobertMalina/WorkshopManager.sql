IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderConstraintsAdd]'))
	DROP PROCEDURE [dbo].[OrderConstraintsAdd]
GO
CREATE PROCEDURE [dbo].[OrderConstraintsAdd]
AS
BEGIN
	--Order to Client FK key restore
	ALTER TABLE [Order]
	WITH CHECK ADD CONSTRAINT [FK_Order_Client_ClientId] FOREIGN KEY ([ClientId]) 
	REFERENCES [dbo].[Client] ([Id])
	ON DELETE CASCADE;

	--Order to Worker (Supervisor) FK key restore
	ALTER TABLE [Order]
	WITH CHECK ADD CONSTRAINT [FK_Order_Worker_SupervisorId] FOREIGN KEY ([SupervisorId]) 	
	REFERENCES [dbo].[Worker] ([Id])
	ON DELETE SET NULL;

	--Part to Order FK key restore
	ALTER TABLE [dbo].[Part]  
	WITH CHECK ADD CONSTRAINT [FK_Part_Order_OrderId] FOREIGN KEY([OrderId])
	REFERENCES [dbo].[Order] ([Id])
	ON DELETE CASCADE

	--TimeLog to Order FK key restore
	ALTER TABLE [dbo].[TimeLog] 
	WITH CHECK ADD  CONSTRAINT [FK_TimeLog_Order_OrderId] FOREIGN KEY([WorkerId])
	REFERENCES [dbo].[Order] ([Id])
	ON DELETE CASCADE;

	--OrderToWorker to Order FK key removal
	ALTER TABLE [dbo].[OrderToWorker]  
	WITH CHECK ADD  CONSTRAINT [FK_OrderToWorker_Order_OrderId] FOREIGN KEY([OrderId])
	REFERENCES [dbo].[Order] ([Id])
	ON DELETE CASCADE
END