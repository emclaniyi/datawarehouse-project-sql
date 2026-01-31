/*
=====================================================================
DDL Script: Create Gold Views
=====================================================================
Script Purpose:
	This script creates views for the Gold layer in the data warehouse.
	The Gold layer represents the final dimension and fact tables (Star Schema)

	Each view performs transformations and combines data from the Silver layer
	to produce a clean, enriched, and business-ready dataset.
Usage:
	- These views can be queried directly for anlaytics and reporting.
*/


-- =============================================================================
-- Create Dimension: gold.fact_sales
-- =============================================================================

-- sales
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
	DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS 
SELECT 
	o.order_id,
	i.order_item_id,
	o.customer_id,
	i.product_id,
	i.seller_id,
	i.price,
	i.freight_value,
	CAST(o.order_purchase_timestamp AS DATE) order_date,
	o.order_status,
	o.flag_late_delivery is_late
FROM silver.olist_orders o
LEFT JOIN silver.olist_order_items i
ON o.order_id = i.order_id
GO

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
	DROP VIEW gold.dim_customers;
GO
-- customers
CREATE VIEW gold.dim_customers AS
SELECT 
	  customer_id,
      [customer_unique_id],
      [customer_zip_code_prefix],
      [customer_city],
      [customer_state]
  FROM [DataWarehouse].[silver].[olist_customers]
GO

-- =============================================================================
-- Create Dimension: gold.dim_sellers
-- =============================================================================
IF OBJECT_ID('gold.dim_sellers', 'V') IS NOT NULL
	DROP VIEW gold.dim_sellers;
GO
-- sellers
CREATE VIEW gold.dim_sellers AS 
SELECT [seller_id]
      ,[seller_zip_code_prefix]
      ,[seller_city]
      ,[seller_state]
FROM [DataWarehouse].[silver].[sellers]
GO

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
	DROP VIEW gold.dim_products;
GO
CREATE VIEW gold.dim_products AS
SELECT 
	p.product_id,
	COALESCE(pt.[product_category_name_english], p.product_category_name, 'Unknown') product_category_name,
	p.product_weight_g,
	p.product_length_cm,
    p.product_height_cm

FROM [DataWarehouse].[silver].[olist_products] p
LEFT JOIN [DataWarehouse].[silver].[product_name_translation] pt
ON p.product_category_name = pt.product_category_name
GO

-- =============================================================================
-- Create Dimension: gold.dim_dates
-- =============================================================================
IF OBJECT_ID('gold.dim_dates', 'V') IS NOT NULL
	DROP VIEW gold.dim_dates;
GO
CREATE VIEW gold.dim_dates AS
SELECT 
	date_key,
	full_date,
	[year],
	month_name,
	is_weekend
	
FROM silver.dim_date
GO
