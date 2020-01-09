IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkerConstraintsAdd]'))
	DROP PROCEDURE [dbo].[WorkerConstraintsAdd]
GO
CREATE PROCEDURE [dbo].[WorkerConstraintsAdd]
AS
BEGIN
	--Order to Worker (Supervisor)
	BEGIN TRY
		ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Worker_SupervisorId] FOREIGN KEY([SupervisorId])
		REFERENCES [dbo].[Worker] ([Id])
		ON DELETE SET NULL
	END TRY
	BEGIN CATCH
		--SELECT '[FK_Order_Worker_SupervisorId] already exists.' AS CollisionDetectedInfo;
	END CATCH

	--OrderToWorker (junction table) to Worker
	ALTER TABLE [dbo].[OrderToWorker]
	WITH CHECK ADD  CONSTRAINT [FK_OrderToWorker_Worker_WorkerId] FOREIGN KEY([WorkerId])
	REFERENCES [dbo].[Worker] ([Id])
	ON DELETE CASCADE;

	--TimeLog to Worker
	ALTER TABLE [dbo].[TimeLog]  
	WITH CHECK ADD  CONSTRAINT [FK_TimeLog_Worker_WorkerId] FOREIGN KEY([WorkerId])
	REFERENCES [dbo].[Worker] ([Id])
	ON DELETE CASCADE

	--Trainee to Worker
	ALTER TABLE [dbo].[Trainee]  
	WITH CHECK ADD  CONSTRAINT [FK_Trainee_Worker_SupervisorId] FOREIGN KEY([SupervisorId])
	REFERENCES [dbo].[Worker] ([Id])
	ON DELETE CASCADE

END