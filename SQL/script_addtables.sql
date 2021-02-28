USE [dbWorldCupBet]
GO

/****** Object:  Table [dbo].[ScoreBets]    Script Date: 6/18/2018 1:26:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ScoreBets](
	[ScoreBetId] [int] IDENTITY(1,1) NOT NULL,
	[MatchId] [int] NOT NULL,
	[ScoreId] [int] NOT NULL,
	[Score1] [int] NOT NULL,
	[Score2] [int] NOT NULL,
	[IsRightScore] [bit] NOT NULL,
	[PaidRate] [float] NOT NULL,
	[IsLocked] [bit] NOT NULL,
 CONSTRAINT [PK__ScoreBet__05FA3870338A5712] PRIMARY KEY CLUSTERED 
(
	[ScoreBetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[ActivityLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[MatchId] [int] NULL,
	[BetType] [int] NULL,
	[Content] [nvarchar](max) NULL,
	[Created] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[UnderOverBets](
	[UnderOverBetId] [int] IDENTITY(1,1) NOT NULL,
	[MatchId] [int] NOT NULL,
	[TotalGoalsBet] [float] NOT NULL,
	[Result] [int] NULL,
	[PaidRate] [float] NOT NULL,
	[IsLocked] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UnderOverBetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO