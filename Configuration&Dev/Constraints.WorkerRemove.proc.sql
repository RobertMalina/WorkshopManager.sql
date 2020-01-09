IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkerConstraintsRemove]'))
	DROP PROCEDURE [dbo].[WorkerConstraintsRemove]
GO
CREATE PROCEDURE [dbo].[WorkerConstraintsRemove]
AS
BEGIN
	--Order to Worker (Supervisor)
	BEGIN TRY
		ALTER TABLE [dbo].[Order]
		DROP CONSTRAINT [FK_Order_Worker_SupervisorId];
	END TRY
	BEGIN CATCH
		--SELECT '[FK_Order_Worker_SupervisorId] was already deleted.' AS CollisionDetectedInfo;
	END CATCH

	--OrderToWorker (junction table) to Worker
	BEGIN TRY
		ALTER TABLE [OrderToWorker]
		DROP CONSTRAINT [FK_OrderToWorker_Worker_WorkerId];
	END TRY
	BEGIN CATCH
		--SELECT '[FK_OrderToWorker_Worker_WorkerId] was already deleted.' AS CollisionDetectedInfo;
	END CATCH

	
	--TimeLog to Worker
	BEGIN TRY
		ALTER TABLE [TimeLog]
		DROP CONSTRAINT [FK_TimeLog_Worker_WorkerId];
	END TRY
	BEGIN CATCH
		--SELECT '[FK_TimeLog_Worker_WorkerId] was already deleted.' AS CollisionDetectedInfo;
	END CATCH

	--Trainee to Worker
	BEGIN TRY
		ALTER TABLE [Trainee]
		DROP CONSTRAINT [FK_Trainee_Worker_SupervisorId];
	END TRY
	BEGIN CATCH
		--SELECT '[FK_Trainee_Worker_SupervisorId] was already deleted.' AS CollisionDetectedInfo;
	END CATCH
END