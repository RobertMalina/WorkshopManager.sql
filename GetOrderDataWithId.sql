IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[GetOrderDataWithId]') AND type in (N'P', N'PC'))  
	DROP PROCEDURE [dbo].[GetOrderDataWithId]
GO
CREATE PROCEDURE [dbo].[GetOrderDataWithId] @orderId int
AS
BEGIN
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
		  (SELECT C.Id FROM [Client] C where C.Id = O.ClientId) AS [Client.Id],
		  (SELECT C.FirstName FROM [Client] C where C.Id = O.ClientId) AS [Client.FirstName],
		  (SELECT C.LastName FROM [Client] C where C.Id = O.ClientId) AS [Client.LastName],
		  (SELECT C.PhoneNumber FROM [Client] C where C.Id = O.ClientId) AS [Client.PhoneNumber],
			W.FirstName AS [Supervisor.FirstName],
		  W.LastName AS [Supervisor.LastName],
		  W.PhoneNumber AS [Supervisor.PhoneNumber]
			FROM [Order] O
			INNER JOIN [Worker] W on O.SupervisorId = W.Id
			WHERE O.Id = @orderId;
END

--EXEC GetOrderDataWithId @orderId = 9;