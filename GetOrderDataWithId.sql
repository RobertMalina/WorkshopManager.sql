CREATE PROCEDURE GetOrderDataWithId @orderId int
AS
SELECT O.Id, 
      O.SupervisorId, 
      O.Title, 
      O.VehicleDescription, 
      O.Description, 
      O.DateRegister, 
      O.DateStart,
      O.DateEnd, 
      O.Cost,
      O.EstimatedTime, 
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
GO

--EXEC GetOrderDataWithId @orderId = 9;