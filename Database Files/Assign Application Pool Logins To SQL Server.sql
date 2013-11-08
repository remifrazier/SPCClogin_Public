/*
Because we're using a full SQL server (instead of an Express edition),
Visual Studio/IIS may not successfully implement access permissions for
the IIS application pool account.  

To resolve this, we have to add the login for the ASP application pool to the server.
The SQL below addresses this (for the SPCC login site prototype version which
is configured to run on ASP.NET 4.0). 
*/

USE [aspnetdb]
GO
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\ASP.NET v4.0]
GO
USE [aspnetdb]
GO
EXEC sp_addrolemember N'db_owner', N'IIS APPPOOL\ASP.NET v4.0'
GO
USE [master]
GO
CREATE LOGIN [IIS APPPOOL\ASP.NET v4.0] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO

/*
Previous versions of the .NET framework and Visual Studio sometimes defaulted to a
more generic application pool.  For these, the following code may work:
*/

/*
USE [aspnetdb]
GO
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool]
GO
USE [aspnetdb]
GO
EXEC sp_addrolemember N'db_owner', N'IIS APPPOOL\DefaultAppPool'
GO
USE [master]
GO
CREATE LOGIN [IIS APPPOOL\DefaultAppPool] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO
*/
