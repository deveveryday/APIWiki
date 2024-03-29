CREATE TABLE [Pages](
	[Slug] [nvarchar](100) NOT NULL,
	[Version] [datetime] NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[IpAddress] [nvarchar](40) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[Comment] [nvarchar](max) NULL,
	CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED ([Slug] ASC, [Version] ASC )
)
INSERT INTO Pages VALUES ('home-page', GETDATE(), 'administrator', '::1', 'Home Page', 'This page is empty', NULL)