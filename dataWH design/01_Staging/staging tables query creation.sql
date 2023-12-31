USE [DWH Spread]
GO

/****** Object:  Table [dbo].[stg_currency_rates]    Script Date: 8/17/2023 6:58:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_currency_rates](
	[Date] [varchar](50) NULL,
	[Currency] [varchar](50) NULL,
	[ExchangeRate] [varchar](50) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[stg_metadata_additional_price_rates]    Script Date: 8/17/2023 6:58:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_metadata_additional_price_rates](
	[type] [varchar](25) NULL,
	[price] [numeric](10, 2) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[stg_order_informations]    Script Date: 8/17/2023 6:58:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_order_informations](
	[order_ID] [int] NOT NULL,
	[order_date] [date] NOT NULL,
	[order_status] [varchar](25) NOT NULL,
	[order_country_ID] [int] NOT NULL,
	[shipping_country_ID] [int] NOT NULL,
	[basket_size] [int] NOT NULL,
	[basket_size_class] [varchar](25) NOT NULL,
	[basket_size_group] [varchar](25) NOT NULL,
	[is_gift_order] [tinyint] NOT NULL,
	[shipping_costs] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[stg_order_items]    Script Date: 8/17/2023 6:58:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_order_items](
	[order_ID] [int] NOT NULL,
	[item_ID] [int] NOT NULL,
	[product_ID] [int] NULL,
	[currency] [varchar](15) NOT NULL,
	[costs] [decimal](15, 2) NOT NULL,
	[item_quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[item_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[stg_product_groups]    Script Date: 8/17/2023 6:58:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_product_groups](
	[ID] [int] NOT NULL,
	[name] [varchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[stg_products]    Script Date: 8/17/2023 6:58:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_products](
	[ID] [int] NOT NULL,
	[name] [varchar](120) NULL,
	[product_group_ID] [int] NULL,
	[price] [decimal](15, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[stg_regions]    Script Date: 8/17/2023 6:58:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_regions](
	[ID] [int] NOT NULL,
	[country_code] [char](2) NOT NULL,
	[country_name] [varchar](255) NOT NULL,
	[region] [varchar](255) NOT NULL,
	[region_group] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[country_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stg_order_informations] ADD  DEFAULT ('0') FOR [order_ID]
GO
ALTER TABLE [dbo].[stg_order_informations] ADD  DEFAULT ('1001-01-01') FOR [order_date]
GO
ALTER TABLE [dbo].[stg_order_informations] ADD  DEFAULT ('Placed') FOR [order_status]
GO
ALTER TABLE [dbo].[stg_order_informations] ADD  DEFAULT ('0') FOR [order_country_ID]
GO
ALTER TABLE [dbo].[stg_order_informations] ADD  DEFAULT ('0') FOR [shipping_country_ID]
GO
ALTER TABLE [dbo].[stg_order_informations] ADD  DEFAULT ('0') FOR [basket_size]
GO
ALTER TABLE [dbo].[stg_order_informations] ADD  DEFAULT ('N/A') FOR [basket_size_class]
GO
ALTER TABLE [dbo].[stg_order_informations] ADD  DEFAULT ('N/A') FOR [basket_size_group]
GO
ALTER TABLE [dbo].[stg_order_informations] ADD  DEFAULT ('0') FOR [is_gift_order]
GO
ALTER TABLE [dbo].[stg_order_informations] ADD  DEFAULT ('5.00') FOR [shipping_costs]
GO
ALTER TABLE [dbo].[stg_order_items] ADD  DEFAULT ('0') FOR [order_ID]
GO
ALTER TABLE [dbo].[stg_order_items] ADD  DEFAULT ('0') FOR [item_ID]
GO
ALTER TABLE [dbo].[stg_order_items] ADD  DEFAULT ('0') FOR [product_ID]
GO
ALTER TABLE [dbo].[stg_order_items] ADD  DEFAULT ('N/A') FOR [currency]
GO
ALTER TABLE [dbo].[stg_order_items] ADD  DEFAULT ('0.00') FOR [costs]
GO
ALTER TABLE [dbo].[stg_order_items] ADD  DEFAULT ('0') FOR [item_quantity]
GO
ALTER TABLE [dbo].[stg_product_groups] ADD  DEFAULT ('N/A') FOR [name]
GO
ALTER TABLE [dbo].[stg_products] ADD  DEFAULT ('0') FOR [ID]
GO
ALTER TABLE [dbo].[stg_products] ADD  DEFAULT ('N/A') FOR [name]
GO
ALTER TABLE [dbo].[stg_products] ADD  DEFAULT (NULL) FOR [product_group_ID]
GO
ALTER TABLE [dbo].[stg_products] ADD  DEFAULT ('0.00') FOR [price]
GO
ALTER TABLE [dbo].[stg_regions] ADD  DEFAULT ('--') FOR [country_code]
GO
ALTER TABLE [dbo].[stg_regions] ADD  DEFAULT ('N/A') FOR [country_name]
GO
ALTER TABLE [dbo].[stg_regions] ADD  DEFAULT ('N/A') FOR [region]
GO
ALTER TABLE [dbo].[stg_regions] ADD  DEFAULT ('N/A') FOR [region_group]
GO

/****** Object:  Table [dbo].[stg_etl_log]    Script Date: 8/17/2023 6:58:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stg_etl_log](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ETL_Details] [nvarchar](256) NULL,
	[ScheduleTime] [datetime] NULL,
 CONSTRAINT [PK_LogID] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO