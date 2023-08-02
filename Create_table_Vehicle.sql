
CREATE TABLE [dbo].[Vehicle](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL,
	[Brand] [nvarchar](50) NULL,
	[PlateNr] [nvarchar](20) NULL,
	[OwnerPersonID] [int] NULL,
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Person] FOREIGN KEY([OwnerPersonID])
REFERENCES [dbo].[Person] ([ID])
GO

ALTER TABLE [dbo].[Vehicle] CHECK CONSTRAINT [FK_Person]
GO


