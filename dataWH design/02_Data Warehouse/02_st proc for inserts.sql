USE [DWH Spread]
GO
/****** Object:  StoredProcedure [dbo].[sp_dwh_insert]    Script Date: 8/18/2023 12:45:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_dwh_insert] AS

Begin

---------------------------------------Reset Tables--------------------------------------------------------

Truncate table [dbo].[dw_dim_currency_rates];
Truncate table [dbo].[dw_dim_product_groups];
Truncate table [dbo].[dw_dim_products];
Truncate table [dbo].[dw_dim_regions];
Truncate table [dbo].[dw_metadata_additional_price_rates];
Truncate table [dbo].[dw_fac_order_informations];
Truncate table [dbo].[dw_fac_order_items];

-----------------------------------------metadata_additional_price_rates---------------------------------------------
Insert into [dbo].[dw_metadata_additional_price_rates]
		(
		[type]
       ,[price]
		)
		SELECT [type]
			  ,[price]
		FROM  [dbo].[stg_metadata_additional_price_rates] WITH (NOLOCK);

-----------------------------------------regions---------------------------------------------
Insert into [dbo].[dw_dim_regions]
	(
	   [ID]
      ,[country_code]
      ,[country_name]
      ,[region]
      ,[region_group]
		)
	SELECT  [ID]
      ,[country_code]
      ,[country_name]
      ,[region]
      ,[region_group]
  FROM [DWH Spread].[dbo].[stg_regions] WITH (NOLOCK);

-----------------------------------------product_groups---------------------------------------------
Insert into [dbo].[dw_dim_product_groups]
	(
	   [ID]
      ,[name]
		)
SELECT  [ID]
      ,[name]
  FROM [DWH Spread].[dbo].[stg_product_groups] WITH (NOLOCK);

-----------------------------------------products---------------------------------------------
Insert into [dbo].[dw_dim_products]
	(
	   [ID]
      ,[name]
      ,[product_group_ID]
      ,[price]
		)
SELECT [ID]
      ,[name]
      ,[product_group_ID]
      ,[price]
  FROM [DWH Spread].[dbo].[stg_products] WITH (NOLOCK);

-----------------------------------------curency_rate---------------------------------------------
Insert into [dbo].[dw_dim_currency_rates]
	(
	   [Date]
      ,[Currency]
      ,[ExchangeRate]
		)
SELECT [Date]
      ,[Currency]
      ,[ExchangeRate]
  FROM [DWH Spread].[dbo].[stg_currency_rates] WITH (NOLOCK);

-----------------------------------------order_info---------------------------------------------
Insert into [dbo].[dw_fac_order_informations]
	(
	   [order_ID]
      ,[order_date]
      ,[order_status]
      ,[order_country_ID]
      ,[shipping_country_ID]
      ,[basket_size]
      ,[basket_size_class]
      ,[basket_size_group]
      ,[is_gift_order]
      ,[shipping_costs]
		)
SELECT [order_ID]
      ,[order_date]
      ,[order_status]
      ,[order_country_ID]
      ,[shipping_country_ID]
      ,[basket_size]
      ,[basket_size_class]
      ,[basket_size_group]
      ,[is_gift_order]
      ,[shipping_costs]
  FROM [DWH Spread].[dbo].[stg_order_informations] WITH (NOLOCK);

-----------------------------------------order_items---------------------------------------------
Insert into [dbo].[dw_fac_order_items]
	(
	   [order_ID]
      ,[item_ID]
      ,[product_ID]
      ,[currency]
      ,[costs]
      ,[item_quantity]
		)
SELECT [order_ID]
      ,[item_ID]
      ,[product_ID]
      ,[currency]
      ,[costs]
      ,[item_quantity]
  FROM [DWH Spread].[dbo].[stg_order_items];

--------------------------------------Generate Date Dimension----------------------------------------------
drop table if exists dw_dim_date;

DECLARE @StartDate  date = (select min([order_date]) from [dbo].[stg_order_informations]);
DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 3, @StartDate));

WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheDay          = DATEPART(DAY,       d),
    TheDayName      = DATENAME(WEEKDAY,   d),
    TheWeek         = DATEPART(WEEK,      d),
    TheISOWeek      = DATEPART(ISO_WEEK,  d),
    TheDayOfWeek    = DATEPART(WEEKDAY,   d),
    TheMonth        = DATEPART(MONTH,     d),
    TheMonthName    = DATENAME(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d),
    TheFirstOfMonth = DATEFROMPARTS(YEAR(d), MONTH(d), 1),
    TheLastOfYear   = DATEFROMPARTS(YEAR(d), 12, 31),
    TheDayOfYear    = DATEPART(DAYOFYEAR, d)
  FROM d
)
SELECT * into dw_dim_date 
  FROM src
  ORDER BY TheDate
  OPTION (MAXRECURSION 0);


End




GO

-- [dbo].[sp_dwh_insert]