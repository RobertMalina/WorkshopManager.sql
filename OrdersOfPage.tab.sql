IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOrdersForPage]'))
	DROP FUNCTION [dbo].[GetOrdersForPage]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetOrdersForPage](
	@page int, 
	@ordersOnPage int, 
	@containsRegistered bit = 1,
	@containsInProgress bit = 1,
	@containsFinished bit = 1
	)
RETURNS
@OrdersOfPage TABLE (
	  [Id] bigint, 
      [SupervisorId] bigint, 
      [Title] nvarchar(128), 
      [VehicleDescription] nvarchar(128), 
      [Description] nvarchar(MAX), 
      [DateRegister] datetime2(7), 
      [DateStart] datetime2(7),
      [DateEnd] datetime2(7),
      [Cost] decimal(9, 2),
      [EstimatedTimeInHours] decimal(3, 1),
      [Status] nvarchar(128),
      [Client.Id] bigint,
      [Client.FirstName] nvarchar(64),
      [Client.LastName] nvarchar(64),
      [Client.PhoneNumber] char(10),
	  [Supervisor.FirstName] nvarchar(64),
      [Supervisor.LastName] nvarchar(64),
      [Supervisor.PhoneNumber] char(10)
)
AS
BEGIN
	DECLARE OrdersPagingIterator cursor
	FOR SELECT O.Id FROM [dbo].[OrdersRegardingStatuses]
	(@containsRegistered, @containsInProgress, @containsFinished ) O;
	
	OPEN OrdersPagingIterator
	DECLARE 
	@counter int, 
	@ordersCount int,
	@readStartIndex int,
	@readedRows int,
	@currentOrderId bigint;
	SET @counter = 0;
	SET @ordersCount = @@CURSOR_ROWS;

	SET @readStartIndex = @page * @ordersOnPage;
	SET @readedRows = 0;
	
	IF(@ordersCount <= @readStartIndex)
	BEGIN
		SET @readStartIndex = 0;
		-- could be: PRINT 'Requested page would not contain any data (range exceeded), first will be page returned instead...'
	END

	FETCH NEXT FROM OrdersPagingIterator into @currentOrderId
	while @@FETCH_STATUS=0
	BEGIN	
		IF(@counter >= @readStartIndex)
		BEGIN
			SET @readedRows = @readedRows + 1;
			INSERT INTO @OrdersOfPage
			SELECT O.Id, 
				O.SupervisorId, 
				O.Title, 
				O.VehicleDescription, 
				O.Description, 
				O.DateRegister, 
				O.DateStart,
				O.DateEnd, 
				O.Cost, 
				O.EstimatedTimeInHours, 
				O.Status,
				(Select C.Id from [Client] C where C.Id = O.ClientId) AS [Client.Id],
				(Select C.FirstName from [Client] C where C.Id = O.ClientId) AS [Client.FirstName],
				(Select C.LastName from [Client] C where C.Id = O.ClientId) AS [Client.LastName],
				(Select C.PhoneNumber from [Client] C where C.Id = O.ClientId) AS [Client.PhoneNumber],
				W.FirstName AS [Supervisor.FirstName],
				W.LastName AS [Supervisor.LastName],
				W.PhoneNumber AS [Supervisor.PhoneNumber]
				FROM [Order] O
				LEFT JOIN [Worker] W on O.SupervisorId = W.Id
				WHERE O.Id = @currentOrderId;
		END
		SET @counter = @counter + 1;

		IF(@readedRows = @ordersOnPage)
		BEGIN
			RETURN;
		END

		FETCH NEXT FROM OrdersPagingIterator into @currentOrderId
	END
	CLOSE OrdersPagingIterator
	DEALLOCATE OrdersPagingIterator
	RETURN;
END
GO
