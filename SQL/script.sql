USE [master]
GO
/****** Object:  Database [dbWorldCupBet]    Script Date: 6/13/2018 3:37:23 PM ******/
CREATE DATABASE [dbWorldCupBet]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbWorldCupBet', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\dbWorldCupBet.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbWorldCupBet_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\dbWorldCupBet_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [dbWorldCupBet] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbWorldCupBet].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbWorldCupBet] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [dbWorldCupBet] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbWorldCupBet] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbWorldCupBet] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbWorldCupBet] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbWorldCupBet] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbWorldCupBet] SET  MULTI_USER 
GO
ALTER DATABASE [dbWorldCupBet] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbWorldCupBet] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbWorldCupBet] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbWorldCupBet] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbWorldCupBet] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbWorldCupBet] SET QUERY_STORE = OFF
GO
USE [dbWorldCupBet]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [dbWorldCupBet]
GO
/****** Object:  Table [dbo].[Bets]    Script Date: 6/13/2018 3:37:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BetId] [int] NOT NULL,
	[BetType] [int] NOT NULL,
	[MatchId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[BetTeam] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[IsLocked] [bit] NOT NULL,
	[Created] [datetime] NULL,
	[Updated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Credentials]    Script Date: 6/13/2018 3:37:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Credentials](
	[UserId] [int] NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Matches]    Script Date: 6/13/2018 3:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Matches](
	[MatchId] [int] IDENTITY(1,1) NOT NULL,
	[MatchRound] [varchar](10) NULL,
	[TeamCode1] [varchar](5) NOT NULL,
	[TeamCode2] [varchar](5) NOT NULL,
	[Score1] [int] NULL,
	[Score2] [int] NULL,
	[MatchTime] [datetime] NOT NULL,
	[IsStarted] [bit] NOT NULL,
	[IsFinished] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScoreBets]    Script Date: 6/13/2018 3:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScoreBets](
	[ScoreBetId] [int] IDENTITY(1,1) NOT NULL,
	[MatchId] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[Multiply] [int] NOT NULL,
	[IsValid] [bit] NOT NULL,
	[IsLocked] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ScoreBetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamBets]    Script Date: 6/13/2018 3:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamBets](
	[TeamBetId] [int] IDENTITY(1,1) NOT NULL,
	[MatchId] [int] NOT NULL,
	[Odds1] [float] NOT NULL,
	[Odds2] [float] NOT NULL,
	[PaidRate1] [int] NOT NULL,
	[PaidRate2] [int] NOT NULL,
	[WinTeam] [varchar](5) NULL,
	[IsLocked] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TeamBetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teams]    Script Date: 6/13/2018 3:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[TeamId] [int] IDENTITY(1,1) NOT NULL,
	[TeamCode] [varchar](5) NOT NULL,
	[TeamName] [nvarchar](50) NOT NULL,
	[Group] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccounts]    Script Date: 6/13/2018 3:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAccounts](
	[UserId] [int] NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Balance] [int] NOT NULL,
	[Created] [datetime] NULL,
	[Updated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/13/2018 3:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Fullname] [nvarchar](50) NULL,
	[UserRole] [int] NOT NULL,
	[IsFirstLogin] [bit] NOT NULL,
	[Created] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTransactions]    Script Date: 6/13/2018 3:37:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTransactions](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[TransactionType] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[Created] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bets] ON 

INSERT [dbo].[Bets] ([Id], [BetId], [BetType], [MatchId], [UserId], [BetTeam], [Amount], [Status], [IsLocked], [Created], [Updated]) VALUES (16, 2, 1, 2, 6, 1, 30000, 2, 0, CAST(N'2018-06-13T14:36:14.933' AS DateTime), CAST(N'2018-06-13T14:36:14.933' AS DateTime))
INSERT [dbo].[Bets] ([Id], [BetId], [BetType], [MatchId], [UserId], [BetTeam], [Amount], [Status], [IsLocked], [Created], [Updated]) VALUES (17, 3, 1, 3, 6, 1, 20000, 2, 0, CAST(N'2018-06-13T14:36:29.613' AS DateTime), CAST(N'2018-06-13T14:36:29.613' AS DateTime))
SET IDENTITY_INSERT [dbo].[Bets] OFF
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (6, N'LongNNB', N'Ok+VRlMg4YqRSYA59Zh68GtjqYvUc8o=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (7, N'VanNTN', N'qvJvKxuq38vcCM1SNHe7VfqBANV0+fM=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (8, N'LienTT', N'AsuuoRos0m9ushU4/PypUkuF++sqIHg=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (9, N'TamTTT', N'NszG4CXTIgmIPXq2NnxlFJUBl6BkOfw=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (10, N'huynvt', N'cqvU4UA06/e635T/xPgJ5ifJv1uKdgc=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (11, N'ThanhDD1', N'brDgx6iS0/Kfvw9WE7xAaWdyNoFojTY=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (12, N'Toantc1', N'OGBdKmHRhXau+isdEqDYYrKZlUreCYQ=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (13, N'DiemNTT', N'gSrbcitVEmb7cknDi1NNrss6Mzdn1RQ=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (14, N'ChungLTK', N'w4+7MnTQnVwwaJRGqxzLIPDQgrHgk38=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (15, N'KhoaHT1', N'QKckp4eXJ02hB5kCsKt23mck5G+W9UM=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (16, N'ThuyPTT', N'VDo+8s0bppjvsjDzv7Gz4TWMa/1fTjY=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (17, N'TungNV4', N'aaog7E4urTineUY3V2wmrZYIRWprVHo=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (18, N'TanHM1', N'Yf9TlZbjH94njL7ZpSbIhXR2z32gpzo=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (19, N'HangNT2', N'mnp1lhv3lkrNFm9rYCytUFer9oEJDXY=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (20, N'PhuongNNH1', N'pAc6HdtzhztJSxrYKMvDhZ0L0uTQRu0=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (21, N'KhanhPQ1', N'lIg8/4przGsqMJOttfyqx3BWjVBmh+o=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (22, N'MinhPC', N'XPd0sHbHz0ITzeEwYPzYiY6u9Bq8m54=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (23, N'ThanhDN3', N'jsCDrf4eWkixaJLH30dPPo5DGnTJe38=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (24, N'ManNM', N'WDi0IOildGSF0bWMwygWETfaI3CmxeM=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (25, N'TamNTP', N'jJNjdGuOt46hDjctOisPWeRd1fN6q00=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (26, N'ThongLD1', N'd0jielIEwJ+C5fkOnElDTVXFwK3m0rc=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (27, N'NoBT', N'pRHK+5Oaw6pLpmbRUNa1mJaZtpJTpj8=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (28, N'AnNV2', N'Uqxj31N0wyDbdI1l30T+Z1zFpk0MMGc=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (29, N'TienPTT', N'JPxJIvoGTw6FLm6I6RjdWkcnrDGv5WU=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (30, N'hungnp', N'H3/5OTy1+0JxGR/IuP4ESMeLQ0Bwdwo=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (31, N'KhanhLV2', N'POMOyzXAzu2OSdTjtXRMoucnrQHcoc4=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (32, N'DatDN', N'C2g69NmvAIUFrkrAGACzoUkylYmqJOU=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (33, N'HueNT6', N'Uo7hBCtAR4PSmkwI8QQ/SeZSgga6PWA=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (34, N'TungLT11', N'ut3gt5mUfTE2Y+6GtomEmY5l4DwrQVs=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (35, N'NgocPTA', N'kQq5brB607rMFgg4UQJT88cshvajzXw=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (36, N'PhuongNM4', N'QUVy9XISd18/GLkmC1lGCPO1CiDb7L0=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (37, N'MiTTT', N'yPN2JIeLQPSeezNVWUdbfOObjlwnHMI=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (38, N'ThuyTNT', N'Ekhx+1SwKBJAFo8fFNv6fVR+blZ03DA=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (39, N'ThuanNH2', N'BPA8UgQ05oUeSkJgNeUzyJXAMax08ME=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (40, N'TungNH4', N'4XYcTn+lvqG6pzaHZf9gmSPhUH58xOY=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (41, N'CuongTQ4', N'C6bKg5c6qW5/78rpmaUF9G/RvpUxoRw=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (42, N'HieuMT2', N'wHO+1iPE4AG1TTDMOkU3oWaPbIzgrbE=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (43, N'BuuDD2', N'jCokfkAdxL89oU0YlxlhkeQuaECKSBY=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (44, N'TuanNQ8', N'Hq5oXFdipAt661x9sKmXYhah8rSnfng=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (45, N'TrungTLA', N'aiWPDKlCjDv0qnmJksCkua+rhvXwJdo=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (46, N'VietHH2', N'9LuAyHlzuWt77I4tVxGGCGqi3R23h3Y=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (47, N'ThienNNT', N'YyIdUfEEkA1XrEMPvBCqHW2JQ7EnGW4=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (48, N'QuyNN2', N'Vaq36TlvPFpfwZWdgnyMDIYXzMzLf5U=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (49, N'HaoNTX', N'8sjvCOTjyF0zLYmvpETnnTh+qwNXjYo=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (50, N'LinhPTK1', N'EvYuk0ljTl4htpdozxZmp4NXpY1SL2o=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (51, N'NghiaNV4', N'5waIUr2xgK6Al6i6VfXnsrI9dOUKSh4=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (52, N'HangNTQ', N'ts1ZZ1IGwa1OKcspzt+i50pC6T2NZcY=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (53, N'TriL1', N'cI4JfKOqbmQlE9FC/HjHjds0FiwZxzg=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (54, N'DucNA19', N'I73iN8p3UOwY0ekdC0KfYT0HOSHJw/Q=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (55, N'LyNT4', N'S3YbHfvYLD9JRkIzT06rVYrym5Y5Ssk=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (56, N'HaiNDN', N'k7pTizdx3vcsWLwS929Ne0k4Evzlrnk=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (57, N'KhoaPC1', N'Zc+bGUdRlKSTZrgtvCqG7nZ69G9Lv/A=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (58, N'DuongNT33', N'3ZrhQWnX1LTSByaCSt4lAWPnf2+Uzdg=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (59, N'DungVT13', N'+78ybe/iGz/7FU3EPuy37DOXBWowMPY=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (60, N'HoangN7', N'8yVYMpY0KCnD0qOgiu3BTs+Pafvxpmo=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (61, N'VuongBV', N'be4nIQ0nM7F1VPpJYx+zZN7dgl9vY2w=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (62, N'AnhTCC', N'w63UGkTEIpruqroQei+pck7prwKLUZ0=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (63, N'TraNT', N'1C0Ex63VhXDEKLFUGd5ADcVdr2Woy6w=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (64, N'HuyDP2', N'iiwIgbNfzCBGluI0axk+Y4Q1/8OdAm8=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (65, N'DatNT59', N'XpYGocxQFbY0wyyp3sTfXJFjvjBZAP0=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (66, N'LocNV4', N'c65Z79eAimPYrnJzuVUAi/ynoQkpkZg=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (67, N'SinLQ1', N'lm9T64b33iCA2nynav8dqXnAOKuTTac=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (68, N'HuyenNL2', N'U/vRsERz9QyAigBoTAxiFOhYuOta5VM=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (69, N'ThuNTL4', N'TGyMWEigN3Z/sNBJzk+TBQb7oWFoqvk=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (70, N'HoangNQ', N'f7ni/tYkWUyEEblH40LtUZguSluKpSQ=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (71, N'TrungNQ21', N'IhxO+TX89x6W2peoZcOhta0784jGFU8=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (72, N'LuongNV2', N'9y0TKi28Bt/o/yO1IjdzBh6IFLC7tMs=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (73, N'HanhTTM4', N'7a9oBc72u/V8fArv0BfBRMiIF+HrMC8=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (74, N'LamVT7', N'JDZECNTe4qCGyyBNxMAb3x6bZqB7QNg=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (75, N'HoangNM18', N'pFu6YNrBvb0JuKMNj0Oi+MvHCg+xTMI=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (76, N'MinhNV22', N'BMzFCevVr7F7ycbuxduVwb9FOjN+1fs=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (77, N'ThuNTK1', N'sjUtzGU2sKhGPgPvF0Mh80a4B4c/crc=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (78, N'PhuongTM5', N'98SW5Rzjn6bm1zKxVW/4wjzGFTruw+4=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (79, N'NamNV10', N'6s+ACdgCBTBdCzohuMuIeJSQDQTYY6g=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (80, N'LiemBT2', N'39PC0ZdL3N+patTyG75+yu48pAGpCqg=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (81, N'ThuongPX', N'sB89mERYp2UnVG5kb2u5nk5GvsTKN5E=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (82, N'AnhNT90', N'LBAGjyecGZ0AQtiEHHV6PPfAHdpr8rs=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (83, N'AnNK1', N'iyqf9dYtsA9wlwIe3JW2XO/uTvK/2XY=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (84, N'TanNN4', N'wkoq6SQHDFLJQRLI1sYKxD8mbZvrcYM=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (85, N'NamNN10', N'/gZf/8rLCn87JTdKogXonGkMz6qHEZE=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (86, N'TienNTM', N'WaKNRERV/SBwQP5qfE29bGpHJEXINf4=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (87, N'TueTD', N'0l9CCep10e0t9fe1du9WeWuytdcUYl8=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (88, N'CuDV', N'5g0BwZXEA/pobSFLgUpZtjq3OcoKJMs=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (89, N'LinhTD3', N'bxXNrTGSy4WxBf5kP6ud3TOLG0Pq53o=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (90, N'HienLT13', N'vJAxSFeMnqU05RPf26fdvtM1q4QohEY=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (91, N'DucDM12', N'7NOK8JWJxqYeGRhaVyvKrMSotN41fjE=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (92, N'LongNP3', N'uUcNg0u4Aa2F3Wii+sDfLEHMwIPrjrg=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (93, N'ChauNTN1', N'k5HVf/+rAFEmUIa1AV7UhliyVoLHvFk=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (94, N'HaNTT34', N'e+zyouP4ek+bvK1hbARtDerpvwyUeCc=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (95, N'LamPTH', N'nepI0qZYEt/uHl2Ekwi2oGC0ZrNrejA=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (96, N'PhuongTTT7', N'skeR8XURkc3flQYVQkZuYK7HqtxfHdA=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (97, N'TrangLTM3', N'xefu4fLRY4K3yuLSSp5s9SMsILo8wd0=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (98, N'QuangNV14', N'z8cWfOFKSRsFLxCbNx9vsbL3Nopn1z4=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (99, N'NamTK1', N'8ToB3npg9e7iTC+wljwiRcnElvdZfZw=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (100, N'DanDN1', N'dye9+XI8PyIqxGLcY3ddxzfPInOoR/c=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (101, N'LuuHH', N'2mo+23tlLaA3V9MoMR0gu4ZhOHdZVCE=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (102, N'LienNTQ', N'QzQg2HA9QxFWzqgiksYqyDZ0NjH47IE=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (103, N'BaoPTL1', N'MdJboV80z81tFowo/6PRL52Wu2x5nDw=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (104, N'ThangNV27', N'g5mEJTnMz9HKvvqc1576ovXBZu16XCY=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (105, N'DucNV12', N'576LSkbc+AeYkN4qb0fG4ZMi3odB6Os=')
GO
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (106, N'ViPT', N'7J3qxfHLS2GHd76E/upy75AV4PJ22/M=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (107, N'ThangPT5', N'Z09GWClfRShmUgtJmHSTU+xdVnyJtXw=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (108, N'TuanNK', N'ldGgPEp+/VeP7KlW/IIqU44WkJ/Doc8=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (109, N'TuTC4', N'm3iAOmir8kX3g36gmfy6aRo6TGZ91ow=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (110, N'HueVT3', N'02HEv80pm7ThBTdfSwos1z9zW4m7B28=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (111, N'TienDV8', N'ImyXZbQiiDgFDYOG3ogSUnr3doTGn64=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (112, N'MinhHT7', N'aMW7H8k1HvfR3CYp7gdW8J4YEsVlzas=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (113, N'DatNT35', N'VW8gLMcK4x08bzZcFvgJudNlvQLRL80=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (114, N'KhanhDC', N'z++u6jz003W92/EOXrGObRjGPuF5Pq0=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (115, N'MinhTD15', N'VhJE/kxpYisoP8ASjxHtyRhqMePcVB8=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (116, N'TaVV', N'4sJSldUiriufAADvZhrXO2+UTxZ/vgE=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (117, N'QuanLX2', N'mQe2ymMBh3mI0x4DjZ6nSdDSGirBMdc=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (118, N'HienLD2', N'odcpwhnaNyNNMoc5ZYODc0ODjQlq7Lw=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (119, N'ThaoVTT4', N'ulWkHUlkaLyeBeU45blMlt/wTOEZbys=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (120, N'LuanNM5', N'PpPuiNPXtzO3iZU+u3UEBGhV8E6GEYY=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (121, N'SonNS', N'ihmreDLpA1pdFUcTTuDkiVBxJCdHnS0=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (122, N'QuyPT', N'+5o689OoQ1M3bXx/CuJdhS9lwhiMd5o=')
INSERT [dbo].[Credentials] ([UserId], [Username], [Password]) VALUES (123, N'PhuongTT22', N'+vBxPRn3WxvoZXI+KO8l6LNk1X4DKfs=')
SET IDENTITY_INSERT [dbo].[Matches] ON 

INSERT [dbo].[Matches] ([MatchId], [MatchRound], [TeamCode1], [TeamCode2], [Score1], [Score2], [MatchTime], [IsStarted], [IsFinished]) VALUES (1, N'A', N'RUS', N'SAU', NULL, NULL, CAST(N'2018-06-14T22:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Matches] ([MatchId], [MatchRound], [TeamCode1], [TeamCode2], [Score1], [Score2], [MatchTime], [IsStarted], [IsFinished]) VALUES (2, N'A', N'EGY', N'URY', NULL, NULL, CAST(N'2018-06-15T19:00:00.000' AS DateTime), 1, 0)
INSERT [dbo].[Matches] ([MatchId], [MatchRound], [TeamCode1], [TeamCode2], [Score1], [Score2], [MatchTime], [IsStarted], [IsFinished]) VALUES (3, N'B', N'MAR', N'IRN', NULL, NULL, CAST(N'2018-06-15T22:00:00.000' AS DateTime), 0, 0)
INSERT [dbo].[Matches] ([MatchId], [MatchRound], [TeamCode1], [TeamCode2], [Score1], [Score2], [MatchTime], [IsStarted], [IsFinished]) VALUES (4, N'B', N'PRT', N'ESP', NULL, NULL, CAST(N'2018-06-16T01:00:00.000' AS DateTime), 0, 0)
SET IDENTITY_INSERT [dbo].[Matches] OFF
SET IDENTITY_INSERT [dbo].[TeamBets] ON 

INSERT [dbo].[TeamBets] ([TeamBetId], [MatchId], [Odds1], [Odds2], [PaidRate1], [PaidRate2], [WinTeam], [IsLocked]) VALUES (1, 1, 0, 0.5, 0, 0, NULL, 0)
INSERT [dbo].[TeamBets] ([TeamBetId], [MatchId], [Odds1], [Odds2], [PaidRate1], [PaidRate2], [WinTeam], [IsLocked]) VALUES (2, 2, 0.75, 0, 0, 0, NULL, 0)
INSERT [dbo].[TeamBets] ([TeamBetId], [MatchId], [Odds1], [Odds2], [PaidRate1], [PaidRate2], [WinTeam], [IsLocked]) VALUES (3, 3, 0.5, 0, 0, 0, NULL, 0)
INSERT [dbo].[TeamBets] ([TeamBetId], [MatchId], [Odds1], [Odds2], [PaidRate1], [PaidRate2], [WinTeam], [IsLocked]) VALUES (4, 4, 0.5, 0, 0, 0, NULL, 1)
SET IDENTITY_INSERT [dbo].[TeamBets] OFF
SET IDENTITY_INSERT [dbo].[Teams] ON 

INSERT [dbo].[Teams] ([TeamId], [TeamCode], [TeamName], [Group]) VALUES (1, N'RUS', N'Nga', N'A')
INSERT [dbo].[Teams] ([TeamId], [TeamCode], [TeamName], [Group]) VALUES (2, N'SAU', N'Ả-rập Xê-út', N'A')
INSERT [dbo].[Teams] ([TeamId], [TeamCode], [TeamName], [Group]) VALUES (3, N'EGY', N'Ai Cập', N'A')
INSERT [dbo].[Teams] ([TeamId], [TeamCode], [TeamName], [Group]) VALUES (4, N'URY', N'Uruguay', N'A')
INSERT [dbo].[Teams] ([TeamId], [TeamCode], [TeamName], [Group]) VALUES (5, N'PRT', N'Bồ Đào Nha', N'B')
INSERT [dbo].[Teams] ([TeamId], [TeamCode], [TeamName], [Group]) VALUES (6, N'ESP', N'Tây Ban Nha', N'B')
INSERT [dbo].[Teams] ([TeamId], [TeamCode], [TeamName], [Group]) VALUES (7, N'MAR', N'Morocco', N'B')
INSERT [dbo].[Teams] ([TeamId], [TeamCode], [TeamName], [Group]) VALUES (8, N'IRN', N'Iran', N'B')
SET IDENTITY_INSERT [dbo].[Teams] OFF
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (6, N'LongNNB', 40000, CAST(N'2018-06-13T09:58:20.063' AS DateTime), CAST(N'2018-06-13T14:37:02.413' AS DateTime))
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (7, N'VanNTN', 0, CAST(N'2018-06-13T10:45:48.733' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (8, N'LienTT', 0, CAST(N'2018-06-13T10:45:48.753' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (9, N'TamTTT', 0, CAST(N'2018-06-13T10:45:48.770' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (10, N'huynvt', 0, CAST(N'2018-06-13T10:45:48.783' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (11, N'ThanhDD1', 0, CAST(N'2018-06-13T10:45:48.793' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (12, N'Toantc1', 0, CAST(N'2018-06-13T10:45:48.803' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (13, N'DiemNTT', 0, CAST(N'2018-06-13T10:45:48.813' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (14, N'ChungLTK', 0, CAST(N'2018-06-13T10:45:48.820' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (15, N'KhoaHT1', 0, CAST(N'2018-06-13T10:45:48.840' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (16, N'ThuyPTT', 0, CAST(N'2018-06-13T10:45:48.850' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (17, N'TungNV4', 0, CAST(N'2018-06-13T10:45:48.860' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (18, N'TanHM1', 0, CAST(N'2018-06-13T10:45:48.870' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (19, N'HangNT2', 0, CAST(N'2018-06-13T10:45:48.880' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (20, N'PhuongNNH1', 0, CAST(N'2018-06-13T10:45:48.887' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (21, N'KhanhPQ1', 0, CAST(N'2018-06-13T10:45:48.897' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (22, N'MinhPC', 0, CAST(N'2018-06-13T10:45:48.907' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (23, N'ThanhDN3', 0, CAST(N'2018-06-13T10:45:48.917' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (24, N'ManNM', 0, CAST(N'2018-06-13T10:45:48.927' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (25, N'TamNTP', 0, CAST(N'2018-06-13T10:45:48.937' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (26, N'ThongLD1', 0, CAST(N'2018-06-13T10:45:48.947' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (27, N'NoBT', 0, CAST(N'2018-06-13T10:45:48.957' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (28, N'AnNV2', 0, CAST(N'2018-06-13T10:45:48.967' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (29, N'TienPTT', 0, CAST(N'2018-06-13T10:45:48.980' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (30, N'hungnp', 0, CAST(N'2018-06-13T10:45:48.990' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (31, N'KhanhLV2', 0, CAST(N'2018-06-13T10:45:49.003' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (32, N'DatDN', 0, CAST(N'2018-06-13T10:45:49.013' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (33, N'HueNT6', 0, CAST(N'2018-06-13T10:45:49.023' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (34, N'TungLT11', 0, CAST(N'2018-06-13T10:45:49.033' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (35, N'NgocPTA', 0, CAST(N'2018-06-13T10:45:49.040' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (36, N'PhuongNM4', 0, CAST(N'2018-06-13T10:45:49.050' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (37, N'MiTTT', 0, CAST(N'2018-06-13T10:45:49.060' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (38, N'ThuyTNT', 0, CAST(N'2018-06-13T10:45:49.070' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (39, N'ThuanNH2', 0, CAST(N'2018-06-13T10:45:49.080' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (40, N'TungNH4', 0, CAST(N'2018-06-13T10:45:49.090' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (41, N'CuongTQ4', 0, CAST(N'2018-06-13T10:45:49.100' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (42, N'HieuMT2', 0, CAST(N'2018-06-13T10:45:49.110' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (43, N'BuuDD2', 0, CAST(N'2018-06-13T10:45:49.120' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (44, N'TuanNQ8', 0, CAST(N'2018-06-13T10:45:49.130' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (45, N'TrungTLA', 0, CAST(N'2018-06-13T10:45:49.140' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (46, N'VietHH2', 0, CAST(N'2018-06-13T10:45:49.150' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (47, N'ThienNNT', 0, CAST(N'2018-06-13T10:45:49.163' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (48, N'QuyNN2', 0, CAST(N'2018-06-13T10:45:49.173' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (49, N'HaoNTX', 0, CAST(N'2018-06-13T10:45:49.183' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (50, N'LinhPTK1', 0, CAST(N'2018-06-13T10:45:49.197' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (51, N'NghiaNV4', 0, CAST(N'2018-06-13T10:45:49.210' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (52, N'HangNTQ', 0, CAST(N'2018-06-13T10:45:49.220' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (53, N'TriL1', 0, CAST(N'2018-06-13T10:45:49.233' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (54, N'DucNA19', 0, CAST(N'2018-06-13T10:45:49.243' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (55, N'LyNT4', 0, CAST(N'2018-06-13T10:45:49.253' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (56, N'HaiNDN', 0, CAST(N'2018-06-13T10:45:49.263' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (57, N'KhoaPC1', 0, CAST(N'2018-06-13T10:45:49.273' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (58, N'DuongNT33', 0, CAST(N'2018-06-13T10:45:49.283' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (59, N'DungVT13', 0, CAST(N'2018-06-13T10:45:49.293' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (60, N'HoangN7', 0, CAST(N'2018-06-13T10:45:49.307' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (61, N'VuongBV', 0, CAST(N'2018-06-13T10:45:49.317' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (62, N'AnhTCC', 0, CAST(N'2018-06-13T10:45:49.327' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (63, N'TraNT', 0, CAST(N'2018-06-13T10:45:49.340' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (64, N'HuyDP2', 0, CAST(N'2018-06-13T10:45:49.350' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (65, N'DatNT59', 0, CAST(N'2018-06-13T10:45:49.360' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (66, N'LocNV4', 0, CAST(N'2018-06-13T10:45:49.383' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (67, N'SinLQ1', 0, CAST(N'2018-06-13T10:45:49.397' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (68, N'HuyenNL2', 0, CAST(N'2018-06-13T10:45:49.410' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (69, N'ThuNTL4', 0, CAST(N'2018-06-13T10:45:49.423' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (70, N'HoangNQ', 0, CAST(N'2018-06-13T10:45:49.440' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (71, N'TrungNQ21', 0, CAST(N'2018-06-13T10:45:49.450' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (72, N'LuongNV2', 0, CAST(N'2018-06-13T10:45:49.463' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (73, N'HanhTTM4', 0, CAST(N'2018-06-13T10:45:49.470' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (74, N'LamVT7', 0, CAST(N'2018-06-13T10:45:49.480' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (75, N'HoangNM18', 0, CAST(N'2018-06-13T10:45:49.490' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (76, N'MinhNV22', 0, CAST(N'2018-06-13T10:45:49.500' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (77, N'ThuNTK1', 0, CAST(N'2018-06-13T10:45:49.510' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (78, N'PhuongTM5', 0, CAST(N'2018-06-13T10:45:49.520' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (79, N'NamNV10', 0, CAST(N'2018-06-13T10:45:49.533' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (80, N'LiemBT2', 0, CAST(N'2018-06-13T10:45:49.543' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (81, N'ThuongPX', 0, CAST(N'2018-06-13T10:45:49.553' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (82, N'AnhNT90', 0, CAST(N'2018-06-13T10:45:49.563' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (83, N'AnNK1', 0, CAST(N'2018-06-13T10:45:49.573' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (84, N'TanNN4', 0, CAST(N'2018-06-13T10:45:49.583' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (85, N'NamNN10', 0, CAST(N'2018-06-13T10:45:49.593' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (86, N'TienNTM', 0, CAST(N'2018-06-13T10:45:49.607' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (87, N'TueTD', 0, CAST(N'2018-06-13T10:45:49.623' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (88, N'CuDV', 0, CAST(N'2018-06-13T10:45:49.637' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (89, N'LinhTD3', 0, CAST(N'2018-06-13T10:45:49.650' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (90, N'HienLT13', 0, CAST(N'2018-06-13T10:45:49.667' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (91, N'DucDM12', 0, CAST(N'2018-06-13T10:45:49.677' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (92, N'LongNP3', 0, CAST(N'2018-06-13T10:45:49.733' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (93, N'ChauNTN1', 0, CAST(N'2018-06-13T10:45:49.743' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (94, N'HaNTT34', 0, CAST(N'2018-06-13T10:45:49.753' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (95, N'LamPTH', 0, CAST(N'2018-06-13T10:45:49.763' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (96, N'PhuongTTT7', 0, CAST(N'2018-06-13T10:45:49.773' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (97, N'TrangLTM3', 0, CAST(N'2018-06-13T10:45:49.783' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (98, N'QuangNV14', 0, CAST(N'2018-06-13T10:45:49.793' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (99, N'NamTK1', 0, CAST(N'2018-06-13T10:45:49.803' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (100, N'DanDN1', 0, CAST(N'2018-06-13T10:45:49.827' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (101, N'LuuHH', 0, CAST(N'2018-06-13T10:45:49.840' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (102, N'LienNTQ', 0, CAST(N'2018-06-13T10:45:49.850' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (103, N'BaoPTL1', 0, CAST(N'2018-06-13T10:45:49.860' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (104, N'ThangNV27', 0, CAST(N'2018-06-13T10:45:49.870' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (105, N'DucNV12', 0, CAST(N'2018-06-13T10:45:49.880' AS DateTime), NULL)
GO
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (106, N'ViPT', 0, CAST(N'2018-06-13T10:45:49.890' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (107, N'ThangPT5', 0, CAST(N'2018-06-13T10:45:49.900' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (108, N'TuanNK', 0, CAST(N'2018-06-13T10:45:49.910' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (109, N'TuTC4', 0, CAST(N'2018-06-13T10:45:49.920' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (110, N'HueVT3', 0, CAST(N'2018-06-13T10:45:49.930' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (111, N'TienDV8', 0, CAST(N'2018-06-13T10:45:49.940' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (112, N'MinhHT7', 0, CAST(N'2018-06-13T10:45:49.953' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (113, N'DatNT35', 0, CAST(N'2018-06-13T10:45:49.963' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (114, N'KhanhDC', 0, CAST(N'2018-06-13T10:45:49.973' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (115, N'MinhTD15', 0, CAST(N'2018-06-13T10:45:49.983' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (116, N'TaVV', 0, CAST(N'2018-06-13T10:45:49.993' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (117, N'QuanLX2', 0, CAST(N'2018-06-13T10:45:50.003' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (118, N'HienLD2', 0, CAST(N'2018-06-13T10:45:50.013' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (119, N'ThaoVTT4', 0, CAST(N'2018-06-13T10:45:50.043' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (120, N'LuanNM5', 0, CAST(N'2018-06-13T10:45:50.053' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (121, N'SonNS', 0, CAST(N'2018-06-13T10:45:50.063' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (122, N'QuyPT', 0, CAST(N'2018-06-13T10:45:50.073' AS DateTime), NULL)
INSERT [dbo].[UserAccounts] ([UserId], [Username], [Balance], [Created], [Updated]) VALUES (123, N'PhuongTT22', 0, CAST(N'2018-06-13T10:45:50.083' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (6, N'LongNNB', N'Nguyễn Ngọc Bảo Long', 1, 0, CAST(N'2018-06-13T09:58:20.060' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (7, N'VanNTN', N'Nguyễn Thị Ngọc Vân', 2, 1, CAST(N'2018-06-13T10:45:48.717' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (8, N'LienTT', N'Trần Thùy Liên', 2, 1, CAST(N'2018-06-13T10:45:48.750' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (9, N'TamTTT', N'Trương Thị Thanh Tâm', 2, 1, CAST(N'2018-06-13T10:45:48.763' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (10, N'huynvt', N'Ngô Văn Tường Huy', 2, 1, CAST(N'2018-06-13T10:45:48.777' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (11, N'ThanhDD1', N'Đặng Duy Thành', 2, 1, CAST(N'2018-06-13T10:45:48.787' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (12, N'Toantc1', N'Trương Công Toàn', 2, 1, CAST(N'2018-06-13T10:45:48.797' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (13, N'DiemNTT', N'Nguyễn Thị Thu Diễm', 2, 1, CAST(N'2018-06-13T10:45:48.807' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (14, N'ChungLTK', N'Lê Thị Kim Chung', 2, 1, CAST(N'2018-06-13T10:45:48.817' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (15, N'KhoaHT1', N'Hồ Tấn Khoa', 2, 1, CAST(N'2018-06-13T10:45:48.823' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (16, N'ThuyPTT', N'Phạm Thị Thanh Thúy', 2, 1, CAST(N'2018-06-13T10:45:48.847' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (17, N'TungNV4', N'Nguyễn Viết Tùng', 2, 1, CAST(N'2018-06-13T10:45:48.853' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (18, N'TanHM1', N'Hoàng Minh Tấn', 2, 1, CAST(N'2018-06-13T10:45:48.863' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (19, N'HangNT2', N'Nguyễn Thu Hằng', 2, 1, CAST(N'2018-06-13T10:45:48.873' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (20, N'PhuongNNH1', N'Nguyễn Ngọc Hà Phương', 2, 1, CAST(N'2018-06-13T10:45:48.883' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (21, N'KhanhPQ1', N'Phạm Quốc Khánh', 2, 1, CAST(N'2018-06-13T10:45:48.893' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (22, N'MinhPC', N'Phan Công Minh', 2, 1, CAST(N'2018-06-13T10:45:48.903' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (23, N'ThanhDN3', N'Đào Ngọc Thành', 2, 1, CAST(N'2018-06-13T10:45:48.913' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (24, N'ManNM', N'Nguyễn Minh Mẩn', 2, 1, CAST(N'2018-06-13T10:45:48.923' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (25, N'TamNTP', N'Nguyễn Thị Phúc Tâm', 2, 1, CAST(N'2018-06-13T10:45:48.933' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (26, N'ThongLD1', N'Lê Duy Thống', 2, 1, CAST(N'2018-06-13T10:45:48.940' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (27, N'NoBT', N'Bùi Thị Nở', 2, 1, CAST(N'2018-06-13T10:45:48.950' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (28, N'AnNV2', N'Nguyễn Việt An', 2, 1, CAST(N'2018-06-13T10:45:48.963' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (29, N'TienPTT', N'Phạm Thị Thu Tiến', 2, 1, CAST(N'2018-06-13T10:45:48.973' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (30, N'hungnp', N'Nguyễn Phước Hùng', 2, 1, CAST(N'2018-06-13T10:45:48.983' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (31, N'KhanhLV2', N'Lê Viết Khánh', 2, 1, CAST(N'2018-06-13T10:45:48.997' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (32, N'DatDN', N'Đặng Ngọc Đạt', 2, 1, CAST(N'2018-06-13T10:45:49.007' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (33, N'HueNT6', N'Ngô Thị Huệ', 2, 1, CAST(N'2018-06-13T10:45:49.017' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (34, N'TungLT11', N'Lê Thanh Tùng', 2, 1, CAST(N'2018-06-13T10:45:49.027' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (35, N'NgocPTA', N'Phạm Thị Ánh Ngọc', 2, 1, CAST(N'2018-06-13T10:45:49.037' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (36, N'PhuongNM4', N'Ngô Minh Phương', 2, 1, CAST(N'2018-06-13T10:45:49.047' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (37, N'MiTTT', N'Tống Thị Trà Mi', 2, 1, CAST(N'2018-06-13T10:45:49.057' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (38, N'ThuyTNT', N'Trương Ngọc Thanh Thủy', 2, 1, CAST(N'2018-06-13T10:45:49.067' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (39, N'ThuanNH2', N'Nguyễn Hoàng Thuận', 2, 1, CAST(N'2018-06-13T10:45:49.077' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (40, N'TungNH4', N'Nguyễn Hoàng Tùng', 2, 1, CAST(N'2018-06-13T10:45:49.087' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (41, N'CuongTQ4', N'Thiều Quang Cường', 2, 1, CAST(N'2018-06-13T10:45:49.097' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (42, N'HieuMT2', N'Mai Trọng Hiếu', 2, 1, CAST(N'2018-06-13T10:45:49.107' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (43, N'BuuDD2', N'Dương Đình Bửu', 2, 1, CAST(N'2018-06-13T10:45:49.117' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (44, N'TuanNQ8', N'Nguyễn Quang Tuấn', 2, 1, CAST(N'2018-06-13T10:45:49.127' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (45, N'TrungTLA', N'Trần Lê Anh Trung', 2, 1, CAST(N'2018-06-13T10:45:49.137' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (46, N'VietHH2', N'Hoàng Hồng Việt', 2, 1, CAST(N'2018-06-13T10:45:49.147' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (47, N'ThienNNT', N'Nguyễn Như Tâm Thiên', 2, 1, CAST(N'2018-06-13T10:45:49.157' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (48, N'QuyNN2', N'Nguyễn Nhật Quý', 2, 1, CAST(N'2018-06-13T10:45:49.167' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (49, N'HaoNTX', N'Ngô Trần Xuân Hảo', 2, 1, CAST(N'2018-06-13T10:45:49.180' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (50, N'LinhPTK1', N'Phan Thị Khánh Linh', 2, 1, CAST(N'2018-06-13T10:45:49.193' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (51, N'NghiaNV4', N'Ngô Văn Nghĩa', 2, 1, CAST(N'2018-06-13T10:45:49.203' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (52, N'HangNTQ', N'Nguyễn Thị Quỳnh Hằng', 2, 1, CAST(N'2018-06-13T10:45:49.217' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (53, N'TriL1', N'Lương Trí', 2, 1, CAST(N'2018-06-13T10:45:49.227' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (54, N'DucNA19', N'Nguyễn Anh Đức', 2, 1, CAST(N'2018-06-13T10:45:49.237' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (55, N'LyNT4', N'Nguyễn Thị Lý', 2, 1, CAST(N'2018-06-13T10:45:49.247' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (56, N'HaiNDN', N'Nguyễn Đặng Ngọc Hải', 2, 1, CAST(N'2018-06-13T10:45:49.257' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (57, N'KhoaPC1', N'Phan Cao Khoa', 2, 0, CAST(N'2018-06-13T10:45:49.267' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (58, N'DuongNT33', N'Nguyễn Thái Dương', 2, 1, CAST(N'2018-06-13T10:45:49.280' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (59, N'DungVT13', N'Võ Tấn Dũng', 2, 1, CAST(N'2018-06-13T10:45:49.290' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (60, N'HoangN7', N'Ngô Hoàng', 2, 1, CAST(N'2018-06-13T10:45:49.303' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (61, N'VuongBV', N'Bùi Văn Vượng', 2, 1, CAST(N'2018-06-13T10:45:49.313' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (62, N'AnhTCC', N'Trầm Châu Cẩm Ánh', 2, 1, CAST(N'2018-06-13T10:45:49.323' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (63, N'TraNT', N'Nguyễn Thị Trà', 2, 1, CAST(N'2018-06-13T10:45:49.333' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (64, N'HuyDP2', N'Đỗ Phú Huy', 2, 1, CAST(N'2018-06-13T10:45:49.343' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (65, N'DatNT59', N'Nguyễn Tiến Đạt', 2, 1, CAST(N'2018-06-13T10:45:49.353' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (66, N'LocNV4', N'Nguyễn Văn Lộc', 2, 1, CAST(N'2018-06-13T10:45:49.367' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (67, N'SinLQ1', N'Lê Quốc Sin', 2, 1, CAST(N'2018-06-13T10:45:49.390' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (68, N'HuyenNL2', N'Nguyễn Lệ Huyền', 2, 1, CAST(N'2018-06-13T10:45:49.403' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (69, N'ThuNTL4', N'Ngô Thị Lệ Thu', 2, 1, CAST(N'2018-06-13T10:45:49.420' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (70, N'HoangNQ', N'Nguyễn Quốc Hoàng', 2, 1, CAST(N'2018-06-13T10:45:49.433' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (71, N'TrungNQ21', N'Nguyễn Quang Trung', 2, 1, CAST(N'2018-06-13T10:45:49.443' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (72, N'LuongNV2', N'Nguyễn Văn Lượng', 2, 1, CAST(N'2018-06-13T10:45:49.457' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (73, N'HanhTTM4', N'Trần Thị Mỹ Hạnh', 2, 1, CAST(N'2018-06-13T10:45:49.467' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (74, N'LamVT7', N'Võ Thế Lâm', 2, 1, CAST(N'2018-06-13T10:45:49.477' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (75, N'HoangNM18', N'Nguyễn Minh Hoàng', 2, 1, CAST(N'2018-06-13T10:45:49.487' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (76, N'MinhNV22', N'Nguyễn Văn Minh', 2, 1, CAST(N'2018-06-13T10:45:49.497' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (77, N'ThuNTK1', N'Nguyễn Thị Kiều Thu', 2, 1, CAST(N'2018-06-13T10:45:49.507' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (78, N'PhuongTM5', N'Trần Minh Phương', 2, 1, CAST(N'2018-06-13T10:45:49.517' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (79, N'NamNV10', N'Nguyễn Văn Nam', 2, 1, CAST(N'2018-06-13T10:45:49.527' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (80, N'LiemBT2', N'Bùi Thanh Liêm', 2, 1, CAST(N'2018-06-13T10:45:49.537' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (81, N'ThuongPX', N'Phùng Xuân Thương', 2, 1, CAST(N'2018-06-13T10:45:49.547' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (82, N'AnhNT90', N'Nguyễn Tuấn Anh', 2, 1, CAST(N'2018-06-13T10:45:49.560' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (83, N'AnNK1', N'Nguyễn Khắc Ẩn', 2, 1, CAST(N'2018-06-13T10:45:49.570' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (84, N'TanNN4', N'Nguyễn Ngọc Tấn', 2, 1, CAST(N'2018-06-13T10:45:49.580' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (85, N'NamNN10', N'Nguyễn Nhật Nam', 2, 1, CAST(N'2018-06-13T10:45:49.590' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (86, N'TienNTM', N'Nguyễn Thị Minh Tiền', 2, 1, CAST(N'2018-06-13T10:45:49.603' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (87, N'TueTD', N'Trần Duy Tuệ', 2, 1, CAST(N'2018-06-13T10:45:49.617' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (88, N'CuDV', N'Đoàn Văn Cự', 2, 1, CAST(N'2018-06-13T10:45:49.630' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (89, N'LinhTD3', N'Trần Đức Linh', 2, 1, CAST(N'2018-06-13T10:45:49.643' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (90, N'HienLT13', N'Lê Thị Hiển', 2, 1, CAST(N'2018-06-13T10:45:49.663' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (91, N'DucDM12', N'Đỗ Minh Đức', 2, 1, CAST(N'2018-06-13T10:45:49.673' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (92, N'LongNP3', N'Nguyễn Phi Long', 2, 1, CAST(N'2018-06-13T10:45:49.727' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (93, N'ChauNTN1', N'Nguyễn Thị Ngọc Châu', 2, 1, CAST(N'2018-06-13T10:45:49.740' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (94, N'HaNTT34', N'Nguyễn Thị Thúy Hà', 2, 1, CAST(N'2018-06-13T10:45:49.747' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (95, N'LamPTH', N'Phan Thị Hương Lam', 2, 1, CAST(N'2018-06-13T10:45:49.757' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (96, N'PhuongTTT7', N'Trần Thị Thanh Phương', 2, 1, CAST(N'2018-06-13T10:45:49.767' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (97, N'TrangLTM3', N'Lê Thị Mai Trang', 2, 1, CAST(N'2018-06-13T10:45:49.777' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (98, N'QuangNV14', N'Nguyễn Văn Quang', 2, 1, CAST(N'2018-06-13T10:45:49.787' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (99, N'NamTK1', N'Trương Kỳ Nam', 2, 1, CAST(N'2018-06-13T10:45:49.800' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (100, N'DanDN1', N'Đỗ Ngọc Dân', 2, 1, CAST(N'2018-06-13T10:45:49.817' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (101, N'LuuHH', N'Huỳnh Hoàng Lựu', 2, 1, CAST(N'2018-06-13T10:45:49.833' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (102, N'LienNTQ', N'Nguyễn Thị Quỳnh Liên', 2, 1, CAST(N'2018-06-13T10:45:49.843' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (103, N'BaoPTL1', N'Phan Trần Lê Bảo', 2, 1, CAST(N'2018-06-13T10:45:49.853' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (104, N'ThangNV27', N'Nguyễn Việt Thắng', 2, 1, CAST(N'2018-06-13T10:45:49.863' AS DateTime))
GO
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (105, N'DucNV12', N'Nguyễn Văn Đức', 2, 1, CAST(N'2018-06-13T10:45:49.873' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (106, N'ViPT', N'Phan Tuấn Vĩ', 2, 1, CAST(N'2018-06-13T10:45:49.883' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (107, N'ThangPT5', N'Phan Thanh Thắng', 2, 1, CAST(N'2018-06-13T10:45:49.893' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (108, N'TuanNK', N'Nguyễn Kim Tuấn', 2, 1, CAST(N'2018-06-13T10:45:49.903' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (109, N'TuTC4', N'Trần Công Tú', 2, 1, CAST(N'2018-06-13T10:45:49.913' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (110, N'HueVT3', N'Vũ Thị Huế', 2, 1, CAST(N'2018-06-13T10:45:49.927' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (111, N'TienDV8', N'Đào Văn Tiên', 2, 1, CAST(N'2018-06-13T10:45:49.937' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (112, N'MinhHT7', N'Hồ Thiện Minh', 2, 1, CAST(N'2018-06-13T10:45:49.947' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (113, N'DatNT35', N'Nguyễn Thành Đạt', 2, 1, CAST(N'2018-06-13T10:45:49.957' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (114, N'KhanhDC', N'Đoàn Công Khánh', 2, 1, CAST(N'2018-06-13T10:45:49.967' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (115, N'MinhTD15', N'Trần Đức Minh', 2, 1, CAST(N'2018-06-13T10:45:49.977' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (116, N'TaVV', N'Võ Văn Tá', 2, 1, CAST(N'2018-06-13T10:45:49.990' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (117, N'QuanLX2', N'Lê Xuân Quân', 2, 1, CAST(N'2018-06-13T10:45:50.000' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (118, N'HienLD2', N'La Đình Hiển', 2, 1, CAST(N'2018-06-13T10:45:50.010' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (119, N'ThaoVTT4', N'Võ Thị Thanh Thảo', 2, 1, CAST(N'2018-06-13T10:45:50.037' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (120, N'LuanNM5', N'Nguyễn Minh Luân', 2, 1, CAST(N'2018-06-13T10:45:50.050' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (121, N'SonNS', N'Nguyễn Sĩ Sơn', 2, 1, CAST(N'2018-06-13T10:45:50.060' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (122, N'QuyPT', N'Phan Thanh Quý', 2, 1, CAST(N'2018-06-13T10:45:50.070' AS DateTime))
INSERT [dbo].[Users] ([UserId], [Username], [Fullname], [UserRole], [IsFirstLogin], [Created]) VALUES (123, N'PhuongTT22', N'Trần Thanh Phương', 2, 1, CAST(N'2018-06-13T10:45:50.080' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[UserTransactions] ON 

INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (1, 2, 3, 55555, CAST(N'2018-06-12T16:20:13.223' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (2, 2, 3, 44444, CAST(N'2018-06-12T16:27:22.140' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (3, 2, 3, 32566, CAST(N'2018-06-12T16:29:47.760' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (4, 2, 3, 33333, CAST(N'2018-06-12T17:01:56.640' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (5, 3, 3, 50000, CAST(N'2018-06-12T17:04:59.533' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (6, 3, 3, 12345, CAST(N'2018-06-12T17:05:28.943' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (7, 4, 3, 50000, CAST(N'2018-06-12T17:25:59.153' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (8, 5, 3, 10000, CAST(N'2018-06-12T17:53:09.120' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (9, 6, 3, 50000, CAST(N'2018-06-13T10:51:08.467' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (10, 6, 3, 50000, CAST(N'2018-06-13T11:51:47.607' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (11, 6, 3, 40000, CAST(N'2018-06-13T12:24:23.693' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (12, 6, 3, 40000, CAST(N'2018-06-13T13:45:42.117' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (13, 6, 3, 30000, CAST(N'2018-06-13T13:46:26.070' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (14, 6, 3, 20000, CAST(N'2018-06-13T14:04:57.310' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (15, 6, 3, 20000, CAST(N'2018-06-13T14:08:16.753' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (16, 6, 3, 30000, CAST(N'2018-06-13T14:36:14.873' AS DateTime))
INSERT [dbo].[UserTransactions] ([TransactionId], [UserId], [TransactionType], [Amount], [Created]) VALUES (17, 6, 3, 20000, CAST(N'2018-06-13T14:37:02.413' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserTransactions] OFF
USE [master]
GO
ALTER DATABASE [dbWorldCupBet] SET  READ_WRITE 
GO
