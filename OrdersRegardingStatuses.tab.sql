IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrdersRegardingStatuses]'))
	DROP FUNCTION [dbo].[OrdersRegardingStatuses]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION OrdersRegardingStatuses( 
	@containsRegistered bit = 1,
	@containsInProgress bit = 1,
	@containsFinished bit = 1
	)
RETURNS 
@orders TABLE (
	  [Id] bigint,
	  [ClientId] bigint,
	  [Title] nvarchar(128), 
	  [VehicleDescription] nvarchar(128),
	  [Description] nvarchar(MAX), 
	  [DateStart] datetime2(7),
      [DateEnd] datetime2(7),
	  [Cost] decimal(9, 2),
	  [Archived] bit,
	  [DateRegister] datetime2(7), 
	  [EstimatedTimeInHours] decimal(3, 1),
	  [Status] nvarchar(128),
      [SupervisorId] bigint, 
      [ComplexityClass] nvarchar(128)
)
AS
BEGIN
	IF(@containsRegistered = 1)
	BEGIN
		INSERT INTO @orders
		SELECT * FROM [dbo].[Order] o WHERE o.[Status] = 'Registered';
	END
	IF(@containsInProgress = 1)
	BEGIN
		INSERT INTO @orders
		SELECT * FROM [dbo].[Order] o WHERE o.[Status] = 'InProgress';
	END
	IF(@containsFinished = 1)
	BEGIN
		INSERT INTO @orders
		SELECT * FROM [dbo].[Order] o WHERE o.[Status] = 'Finished';
	END
	RETURN
END
GO
