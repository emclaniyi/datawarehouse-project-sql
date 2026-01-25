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