CREATE TABLE [Users](
	[UserName] [nvarchar](100) NOT NULL,
	[PasswordHash] [binary](64) NOT NULL,
	[PasswordSalt] [binary](128) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[IsApproved] [bit] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateLastLogin] [datetime] NULL,
	[DateLastActivity] [datetime] NULL,
	[DateLastPasswordChange] [datetime] NOT NULL,
	CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserName] ASC)
)
CREATE TABLE [Roles](
	[RoleName] [nvarchar](100) NOT NULL,
	CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([RoleName] ASC)
)
CREATE TABLE [RoleMemberships](
	[UserName] [nvarchar](100) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
	CONSTRAINT [PK_RoleMemberships] PRIMARY KEY CLUSTERED ([UserName] ASC, [RoleName] ASC),
	CONSTRAINT [FK_RoleMemberships_Roles] FOREIGN KEY([RoleName]) REFERENCES [Roles] ([RoleName]) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT [FK_RoleMemberships_Users] FOREIGN KEY([UserName]) REFERENCES [Users] ([UserName]) ON UPDATE CASCADE ON DELETE CASCADE
)
INSERT INTO [Roles] ([RoleName]) VALUES (N'administrators')