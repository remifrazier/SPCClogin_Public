/*
The following code will build (but not populate) the membership database which
the SPCC login site prototype is configured to authenticate against.

This database can also (and probably should) be created using the aspnet_regsql.exe
configuration utility.  From a Visual Studio command prompt, run the following command
and accept the default options at each step:

aspnet_regsql.exe -w

*/

USE [master]
GO

/****** Object:  Database [aspnetdb]    Script Date: 11/08/2013 10:06:36 ******/
CREATE DATABASE [aspnetdb] ON  PRIMARY 
( NAME = N'aspnetdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\aspnetdb.mdf' , SIZE = 2304KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'aspnetdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\aspnetdb_log.LDF' , SIZE = 768KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [aspnetdb] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [aspnetdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [aspnetdb] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [aspnetdb] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [aspnetdb] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [aspnetdb] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [aspnetdb] SET ARITHABORT OFF 
GO

ALTER DATABASE [aspnetdb] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [aspnetdb] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [aspnetdb] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [aspnetdb] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [aspnetdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [aspnetdb] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [aspnetdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [aspnetdb] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [aspnetdb] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [aspnetdb] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [aspnetdb] SET  ENABLE_BROKER 
GO

ALTER DATABASE [aspnetdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [aspnetdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [aspnetdb] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [aspnetdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [aspnetdb] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [aspnetdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [aspnetdb] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [aspnetdb] SET  READ_WRITE 
GO

ALTER DATABASE [aspnetdb] SET RECOVERY FULL 
GO

ALTER DATABASE [aspnetdb] SET  MULTI_USER 
GO

ALTER DATABASE [aspnetdb] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [aspnetdb] SET DB_CHAINING OFF 
GO


