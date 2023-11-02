USE [DWH Spread]
GO
/****** Object:  Table [dbo].[dw_dim_currency_rates]    Script Date: 8/18/2023 12:48:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dw_dim_currency_rates](
	[Date] [varchar](50) NOT NULL,
	[Currency] [varchar](15) NOT NULL,
	[ExchangeRate] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dw_dim_date]    Script Date: 8/18/2023 12:48:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dw_dim_date](
	[TheDate] [date] NULL,
	[TheDay] [int] NULL,
	[TheDayName] [nvarchar](30) NULL,
	[TheWeek] [int] NULL,
	[TheISOWeek] [int] NULL,
	[TheDayOfWeek] [int] NULL,
	[TheMonth] [int] NULL,
	[TheMonthName] [nvarchar](30) NULL,
	[TheQuarter] [int] NULL,
	[TheYear] [int] NULL,
	[TheFirstOfMonth] [date] NULL,
	[TheLastOfYear] [date] NULL,
	[TheDayOfYear] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dw_dim_product_groups]    Script Date: 8/18/2023 12:48:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dw_dim_product_groups](
	[ID] [int] NOT NULL,
	[name] [varchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dw_dim_products]    Script Date: 8/18/2023 12:48:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dw_dim_products](
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
/****** Object:  Table [dbo].[dw_dim_regions]    Script Date: 8/18/2023 12:48:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dw_dim_regions](
	[ID] [int] NOT NULL,
	[country_code] [char](2) NOT NULL,
	[country_name] [varchar](255) NOT NULL,
	[region] [varchar](255) NOT NULL,
	[region_group] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dw_fac_order_informations]    Script Date: 8/18/2023 12:48:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dw_fac_order_informations](
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
/****** Object:  Table [dbo].[dw_fac_order_items]    Script Date: 8/18/2023 12:48:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dw_fac_order_items](
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
/****** Object:  Table [dbo].[dw_metadata_additional_price_rates]    Script Date: 8/18/2023 12:48:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dw_metadata_additional_price_rates](
	[type] [varchar](25) NULL,
	[price] [numeric](10, 2) NULL
) ON [PRIMARY]
GO
