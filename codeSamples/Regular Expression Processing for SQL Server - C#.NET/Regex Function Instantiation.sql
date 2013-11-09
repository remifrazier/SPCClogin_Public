/*
Deploys a C#.NET assembly to the local MSSQL engine which provides
standardized regular expression processing for strings.

The underlying assemblies for this system modify and update, but borrow heavily 
from a 2007 publication by David Banister.
*/
sp_configure 'clr enabled', 1
go
reconfigure
go

DROP ASSEMBLY SqlRegex
DROP FUNCTION dbo.RegexMatch
DROP FUNCTION dbo.RegexMatches
DROP FUNCTION dbo.RegexGroup
DROP FUNCTION dbo.RegexGroups
DROP FUNCTION dbo.RegexReplace
DROP FUNCTION dbo.RegexReplaceRecursive

CREATE ASSEMBLY SqlRegex
FROM 'PATH\regex\bin\Release\regex.dll'
WITH PERMISSION_SET=SAFE;


CREATE FUNCTION [dbo].[RegexMatch] (@strInput nvarchar(4000),@strPattern nvarchar(4000))
RETURNS bit
AS EXTERNAL NAME [SqlRegex].[UserDefinedFunctions].[RegexMatch]

CREATE FUNCTION [dbo].[RegexMatches] (@strInput nvarchar(4000),@strPattern nvarchar(4000))
RETURNS TABLE([Index] int,[Text] nvarchar(4000))
AS EXTERNAL NAME [SqlRegex].[UserDefinedFunctions].[RegexMatches]

CREATE FUNCTION [dbo].[RegexGroup] (@strInput nvarchar(4000),@strPattern nvarchar(4000),@strName nvarchar(4000))
RETURNS nvarchar(4000)
AS EXTERNAL NAME [SqlRegex].[UserDefinedFunctions].[RegexGroup]

CREATE FUNCTION [dbo].[RegexGroups] (@strInput nvarchar(4000),@strPattern nvarchar(4000))
RETURNS table([Index] int,[Group] nvarchar(max),[Text] nvarchar(max))
AS EXTERNAL NAME [SqlRegex].[UserDefinedFunctions].[RegexGroups]

CREATE FUNCTION [dbo].[RegexReplace] (@strInput nvarchar(4000),@strPattern nvarchar(4000),@strReplacement nvarchar(4000))
RETURNS nvarchar(4000)
AS EXTERNAL NAME [SqlRegex].[UserDefinedFunctions].[RegexReplace]

CREATE FUNCTION [dbo].[RegexReplaceRecursive] (@strInput nvarchar(4000),@strPattern nvarchar(4000),@strReplacement nvarchar(4000))
RETURNS nvarchar(4000)
AS EXTERNAL NAME [SqlRegex].[UserDefinedFunctions].[RegexReplaceRecursive]

