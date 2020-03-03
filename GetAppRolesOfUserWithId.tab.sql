IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRolesOfUserWithId]'))
	DROP FUNCTION [dbo].[GetRolesOfUserWithId]
GO
CREATE FUNCTION [GetRolesOfUserWithId] (
    @mechanicianId INT
)
RETURNS
@RolesOfUser TABLE (
	[UserId] bigint,
	[RoleName] nvarchar(64))
AS
BEGIN
	INSERT INTO @RolesOfUser
		SELECT @mechanicianId, ar.[Name] from AppRole ar
		INNER JOIN AppUserToAppRole bound ON
		ar.Id = bound.RoleId
		WHERE bound.UserId = @mechanicianId;
	RETURN
END