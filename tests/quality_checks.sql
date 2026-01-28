/*
==========================================================
Quality Checks
==========================================================
Script Purpose:
	This script performs various quality checks for data consistency, accuracy,
	and standardization across the 'silver' schemas. It includes checks for:
	- Null or duplicate primary keys.
	- Unwanted spaces in sring fields.
	- Data standardization and consistency.
	- Invalid date ranges and orders.
	- Data consustency between related fields
Usage Notes:
	- Run these checks after data loading Silver layer
	- investigate and resolve any discrepancies found during the checks.

*/


-- =================================================
-- Checking 'bronze.olist_customers'
-- ====================================================
-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT *
FROM bronze.olist_customers
WHERE customer_unique_id = '00172711b30d52eea8b313a7f2cced02'

SELECT 
	customer_unique_id,
	COUNT(*)
FROM bronze.olist_customers
GROUP BY customer_unique_id
HAVING COUNT(*) > 1 OR customer_unique_id IS NULL

-- If the columns are duplicated or null
SELECT *
FROM (
SELECT 
	*,
	ROW_NUMBER() OVER(PARTITION BY customer_unique_id ORDER BY (SELECT NULL) )  occurrence_rank
FROM bronze.olist_customers) t WHERE occurrence_rank = 1 

-- check for unwanted spaces
-- Expectation: No result
SELECT customer_city
FROM bronze.olist_customers
WHERE customer_city != TRIM(customer_city)

SELECT customer_state
FROM bronze.olist_customers
WHERE customer_state != TRIM(customer_state)

-- Data standardization & consistency
SELECT DISTINCT customer_state
FROM bronze.olist_customers



-- =================================================
-- Checking 'bronze.[olist_order_items]'
-- ====================================================
--- ORDER ITEM
SELECT TOP (1000) [order_id]
      ,[order_item_id]
      ,[product_id]
      ,[seller_id]
      ,[shipping_limit_date]
      ,[price]
      ,[freight_value]
  FROM [DataWarehouse].[bronze].[olist_order_items]

-- check for uniqueness
SELECT 
    order_id,
    order_item_id,
    COUNT(*) as duplicate_count
FROM [bronze].[olist_order_items]
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1 OR order_id IS NULL OR order_item_id IS NULL;

-- check for negative or null values
SELECT price
from [bronze].[olist_order_items]
WHERE price < 0 OR price IS NULL


-- =================================================
-- Checking 'bronze.[olist_orders]'
-- ====================================================
-- ORDER TABLE

SELECT [order_id]
      ,[customer_id]
      ,[order_status]
      ,[order_purchase_timestamp]
      ,CASE
			WHEN [order_approved_at] > [order_delivered_carrier_date] THEN [order_purchase_timestamp]
			ELSE [order_approved_at]
		END [order_approved_at]
      ,[order_delivered_carrier_date]
      ,[order_delivered_customer_date]
      ,[order_estimated_delivery_date]
	 
	  -- flag late deliveries
	  , CASE
			WHEN [order_delivered_customer_date] > [order_estimated_delivery_date] THEN 'late delivery'
			ELSE 'on time'
		END AS flag_late_delivery
  FROM [DataWarehouse].[bronze].[olist_orders]
  -- remove ouliers where shipped > delivered date
  WHERE order_delivered_carrier_date <= order_delivered_customer_date

-- data standardization and consistency
SELECT DISTINCT order_status
FROM [bronze].[olist_orders]

-- check for invalid date
SELECT *
FROM bronze.olist_orders
WHERE [order_approved_at] > [order_delivered_carrier_date]

SELECT *
FROM bronze.olist_orders
WHERE [order_delivered_carrier_date] > [order_delivered_customer_date]

SELECT *
FROM bronze.olist_orders
WHERE [order_delivered_customer_date] > [order_estimated_delivery_date]

--- check silver table
-- check for invalid date
SELECT *
FROM silver.olist_orders
WHERE [order_approved_at] > [order_delivered_carrier_date]

SELECT *
FROM silver.olist_orders
WHERE [order_delivered_carrier_date] > [order_delivered_customer_date]

SELECT *
FROM silver.olist_orders
WHERE [order_delivered_customer_date] > [order_estimated_delivery_date]