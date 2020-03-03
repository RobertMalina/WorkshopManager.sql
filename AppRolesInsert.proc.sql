 IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SetAppRoles]'))
	DROP PROCEDURE [dbo].[SetAppRoles]
GO
CREATE PROCEDURE [dbo].[SetAppRoles]
AS
	DELETE FROM [dbo].[AppRole];
	DBCC CHECKIDENT ('[AppRole]', RESEED, 0)
	INSERT INTO [dbo].[AppRole] ([Name]) VALUES ('regular');
	INSERT INTO [dbo].[AppRole] ([Name]) VALUES ('supervisor');
	INSERT INTO [dbo].[AppRole] ([Name]) VALUES ('administrator');
	INSERT INTO [dbo].[AppRole] ([Name]) VALUES ('mechanician');
GO