IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[GetNonArchivedOrdersCount]') AND type in (N'FN'))  
	DROP FUNCTION [dbo].[GetNonArchivedOrdersCount]
GO
CREATE FUNCTION [dbo].[GetNonArchivedOrdersCount]()
RETURNS INT
AS
BEGIN
	RETURN (SELECT COUNT(o.Id) FROM [Order] o WHERE o.Archived = 0) 
END

--SELECT [dbo].[GetNonArchivedOrdersCount]();
