USE [master]
GO
/****** Object:  Database [TaskTrackerDB]    Script Date: 08.02.2024 14:40:50 ******/
CREATE DATABASE [TaskTrackerDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TaskTrackerDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TaskTrackerDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TaskTrackerDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TaskTrackerDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TaskTrackerDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TaskTrackerDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TaskTrackerDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TaskTrackerDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TaskTrackerDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TaskTrackerDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TaskTrackerDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET RECOVERY FULL 
GO
ALTER DATABASE [TaskTrackerDB] SET  MULTI_USER 
GO
ALTER DATABASE [TaskTrackerDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TaskTrackerDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TaskTrackerDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TaskTrackerDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TaskTrackerDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TaskTrackerDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TaskTrackerDB', N'ON'
GO
ALTER DATABASE [TaskTrackerDB] SET QUERY_STORE = OFF
GO
USE [TaskTrackerDB]
GO
/****** Object:  Table [dbo].[Project]    Script Date: 08.02.2024 14:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[StartDate] [date] NULL,
	[CompletionDate] [date] NULL,
	[StatusProjectId] [int] NOT NULL,
	[Priority] [int] NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusProject]    Script Date: 08.02.2024 14:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusProject](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NULL,
 CONSTRAINT [PK_StatusProject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusTask]    Script Date: 08.02.2024 14:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusTask](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NULL,
 CONSTRAINT [PK_StatusTask] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task]    Script Date: 08.02.2024 14:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Description] [nvarchar](max) NULL,
	[Priority] [int] NULL,
	[ProjectId] [int] NOT NULL,
	[StatusTaskId] [int] NOT NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_StatusProject] FOREIGN KEY([StatusProjectId])
REFERENCES [dbo].[StatusProject] ([Id])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_StatusProject]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Project]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_StatusTask] FOREIGN KEY([StatusTaskId])
REFERENCES [dbo].[StatusTask] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_StatusTask]
GO
USE [master]
GO
ALTER DATABASE [TaskTrackerDB] SET  READ_WRITE 
GO
