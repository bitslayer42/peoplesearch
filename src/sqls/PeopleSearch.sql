USE Intranet
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC dbo.PeopleSearchNU (
	--PeopleSearch from Active Directory 
	@searchby varchar(100) = null,
	@id varchar(15) = null,
	@supv varchar(15) = null,
	@dept varchar(5) = null,
	@job varchar(6) = null,
	@MaxRowsReturn int = 0   -- zero will return all matching rows
	) AS
	-- PeopleSearchNU  'GUZY',NULL,NULL,NULL,NULL  
	-- PeopleSearchNU  NULL,'1026588',NULL,NULL,NULL 
	-- PeopleSearchNU  NULL,NULL,'1026956',NULL,NULL 
	-- PeopleSearchNU  NULL,NULL,NULL,'84730',NULL 
	-- PeopleSearchNU  NULL,NULL,NULL,NULL,'844820' 
	DECLARE @WithoutDashes varchar(100) = replace(@searchby,'-','')

	SET ROWCOUNT @MaxRowsReturn
	SELECT IsCarePartners,EmployeeID,FirstName,LastName,Name,PreferedName,Mobile,OfficePhone,Extension,Department,DepartmentName
	,JobCode,JobTitle,Pager,Email,StreetAddress,City,State,PostalCode,FileName,SupervisorID,SupervisorName,SupveeCount
	FROM dbo.PeopleSearchTable
	WHERE (
		(EmployeeID = @id)
		OR (FirstName+' '+LastName LIKE '%'+@searchby+'%') 
		OR (PreferedName LIKE '%'+@searchby+'%') 
		OR (LastName LIKE '%'+@searchby+'%') 
		OR (Name LIKE '%'+@searchby+'%')  
		--OR (Extension LIKE '%'+@searchby+'%')  
		--OR (JobTitle LIKE '%'+@searchby+'%')
		--OR (Mobile LIKE '%'+@WithoutDashes+'%')
		--OR (Extension LIKE '%'+@WithoutDashes+'%')
		OR SupervisorID = @supv
		OR Department = @dept
		OR JobCode = @job
	)
	ORDER BY IsCarePartners DESC, Name, FileName DESC
