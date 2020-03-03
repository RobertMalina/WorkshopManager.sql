--GetOrdersRegisteredSinceTimePeriod
--Funkcja która zwróci wszystkie zlecenia zarejestrowane w ciągu ostatnich N dni

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOrdersRegisteredSince]'))
	DROP FUNCTION [dbo].[GetOrdersRegisteredSince];
GO
CREATE FUNCTION [dbo].[GetOrdersRegisteredSince](
	@days INT
)
RETURNS TABLE
AS
RETURN
    SELECT 
       [Id]
      ,[ClientId]
      ,[Title]
      ,[VehicleDescription]
      ,[Description]
      ,[DateStart]
      ,[DateEnd]
      ,[Cost]
      ,[Archived]
      ,[DateRegister]
      ,[EstimatedTimeInHours]
      ,[Status]
      ,[SupervisorId]
      ,[ComplexityClass]
    FROM
        [dbo].[Order] O
    WHERE
		DATEDIFF(DAY, O.DateRegister, GETDATE() ) < @days;