-- stored procedure that returns all of the orders of mechanician with given id
-- in which that mechanician was engaged (NOT just assigned) within last N days
-- result conforms to Order entity type
-- takes:	{	mechanicianId: long,	daysPeriod: int		}

 IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOrdersOfMechanicianWithin]'))
	DROP PROCEDURE [dbo].[GetOrdersOfMechanicianWithin]
GO
CREATE PROCEDURE [dbo].[GetOrdersOfMechanicianWithin] 
	@mechanicianId bigint,
	@daysPeriod int
AS

GO