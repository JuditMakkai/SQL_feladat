
CREATE TABLE [dbo].[Refueling](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PersonID] [int] NULL,
	[VehicleID] [int] NULL,
	[RefuelingDate] [date] NOT NULL,
	[Amount] [money] NOT NULL,
 CONSTRAINT [PK_RefuelingID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Refueling] ADD  DEFAULT (sysdatetime()) FOR [RefuelingDate]
GO

ALTER TABLE [dbo].[Refueling] ADD  DEFAULT ((0)) FOR [Amount]
GO

ALTER TABLE [dbo].[Refueling]  WITH CHECK ADD  CONSTRAINT [FK_Refueling_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([ID])
GO

ALTER TABLE [dbo].[Refueling] CHECK CONSTRAINT [FK_Refueling_PersonID]
GO

ALTER TABLE [dbo].[Refueling]  WITH CHECK ADD  CONSTRAINT [FK_Refueling_VehicleID] FOREIGN KEY([VehicleID])
REFERENCES [dbo].[Vehicle] ([ID])
GO

ALTER TABLE [dbo].[Refueling] CHECK CONSTRAINT [FK_Refueling_VehicleID]
GO


