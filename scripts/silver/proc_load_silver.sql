/*
===========================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===========================================================================
Script Purpose:
	This stored procedure cleans& transforms data into the 'silver' schema from 'bronze'.
	It performs the following actions:
	- Truncates the silver tables before loading data
	- Uses the `INSERT INTO` command to load data from bronze tables into the silver tables after transformation.

Parameters:
	None.
	This stored procedure does not accept any parameters or return any values.

Usage Example:
	Exec bronze.load_silver;
*/


EXEC silver.load_silver

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '============================================';
		PRINT 'Loading Silver Layer';
		PRINT '============================================';

		-- customers
		SET @start_time = GETDATE();
		PRINT '>> Truncating Data: silver.olist_customers';
		TRUNCATE TABLE silver.olist_customers;
		PRINT '>> Inserting Data into: silver.olist_customers';
		INSERT INTO silver.olist_customers (
			customer_id,
			customer_unique_id,
			customer_zip_code_prefix,
			customer_city,
			customer_state
	
		)
		SELECT 
			customer_id,
			customer_unique_id,
			customer_zip_code_prefix,
			TRIM(customer_city) customer_city,
			TRIM(customer_state) customer_state

		FROM (
		SELECT 
			*,
			ROW_NUMBER() OVER(PARTITION BY customer_unique_id ORDER BY (SELECT NULL) )  occurrence_rank
		FROM bronze.olist_customers) t WHERE occurrence_rank = 1 ;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';

		-- product 
		SET @start_time = GETDATE();
		PRINT '>> Truncating Data: silver.olist_products';
		TRUNCATE TABLE silver.olist_products;
		PRINT '>> Inserting Data into: silver.olist_products';
		INSERT INTO silver.olist_products( [product_id]
			  ,[product_category_name]
			  ,[product_name_lenght]
			  ,[product_description_lenght]
			  ,[product_photos_qty]
			  ,[product_weight_g]
			  ,[product_length_cm]
			  ,[product_height_cm]
			  )
		SELECT 
			[product_id],
			COALESCE([product_category_name], 'unknown') [product_category_name],
			COALESCE([product_name_lenght], 0) [product_name_lenght],
			COALESCE([product_description_lenght], 0) [product_description_lenght],
			COALESCE([product_photos_qty], 0) [product_photos_qty],
			COALESCE([product_weight_g], 0) [product_weight_g],
			COALESCE([product_length_cm], 0) [product_length_cm],
			[product_height_cm]
		FROM [bronze].[olist_products]
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';


		-- geolocation 
		SET @start_time = GETDATE();
		PRINT '>> Truncating Data: silver.[olist_geolocation]';
		TRUNCATE TABLE silver.[olist_geolocation];
		PRINT '>> Inserting Data into: silver.olist_geolocation';
		INSERT INTO silver.[olist_geolocation] (
			[geolocation_zip_code_prefix]
			  ,[geolocation_lat]
			  ,[geolocation_lng]
			  ,[geolocation_city]
			  ,[geolocation_state]
		)

		SELECT [geolocation_zip_code_prefix]
			  ,[geolocation_lat]
			  ,[geolocation_lng]
			  ,[geolocation_city]
			  ,[geolocation_state]
		FROM [DataWarehouse].[bronze].[olist_geolocation]
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Data: silver.[product_name_translation]';
		TRUNCATE TABLE silver.[product_name_translation];
		PRINT '>> Inserting Data into: silver.[product_name_translation]';
		INSERT INTO silver.[product_name_translation] (
			[product_category_name]
			,[product_category_name_english]
		)
		SELECT
			TRIM([product_category_name]) product_category_name
			,TRIM([product_category_name_english]) product_category_name_english
		FROM [DataWarehouse].[bronze].[product_name_translation]
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';

		-- order item
		SET @start_time = GETDATE();
		PRINT '>> Truncating Data: silver.[olist_order_items]';
		TRUNCATE TABLE silver.[olist_order_items];
		PRINT '>> Inserting Data into: silver.[olist_order_items]';
		INSERT INTO silver.[olist_order_items] (
			[order_id]
			  ,[order_item_id]
			  ,[product_id]
			  ,[seller_id]
			  ,[shipping_limit_date]
			  ,[price]
			  ,[freight_value]
		)
		SELECT [order_id]
			  ,[order_item_id]
			  ,[product_id]
			  ,[seller_id]
			  ,[shipping_limit_date]
			  ,[price]
			  ,[freight_value]
		FROM [DataWarehouse].[bronze].[olist_order_items]
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';

		-- sellers
		SET @start_time = GETDATE();
		PRINT '>> Truncating Data: silver.sellers';
		TRUNCATE TABLE silver.sellers;
		PRINT '>> Inserting Data into: silver.sellers';
		INSERT INTO silver.sellers (
			   [seller_id]
			  ,[seller_zip_code_prefix]
			  ,[seller_city]
			  ,[seller_state]
		)
		SELECT [seller_id]
			  ,[seller_zip_code_prefix]
			  ,[seller_city]
			  ,[seller_state]
		FROM [DataWarehouse].[bronze].[sellers]
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';


		-- ORDER PAYMENT
		SET @start_time = GETDATE();
		PRINT '>> Truncating Data: silver.[olist_order_payments]';
		TRUNCATE TABLE silver.[olist_order_payments];
		PRINT '>> Inserting Data into: silver.[olist_order_items]';
		INSERT INTO silver.[olist_order_payments] (
			[order_id]
			,[payment_sequential]
			,[payment_type]
			,[payment_installments]
			,[payment_value]
		)

		SELECT [order_id]
			  ,[payment_sequential]
			  ,[payment_type]
			  ,[payment_installments]
			  ,[payment_value]
		FROM [DataWarehouse].[bronze].[olist_order_payments]
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';



		-- ORDER
		SET @start_time = GETDATE();
		PRINT '>> Truncating Data: silver.[olist_orders]';
		TRUNCATE TABLE silver.olist_orders;
		PRINT '>> Inserting Data into: silver.[olist_orders]';
		INSERT INTO silver.olist_orders (
			order_id,
			customer_id,
			order_status,
			order_purchase_timestamp,
			order_approved_at,
			order_delivered_carrier_date,
			order_delivered_customer_date,
			order_estimated_delivery_date,
			flag_late_delivery
		)
		SELECT [order_id]
			  ,[customer_id]
			  ,[order_status]
			  ,[order_purchase_timestamp]
			  ,CASE
					WHEN [order_approved_at] > [order_delivered_carrier_date] THEN [order_delivered_carrier_date]
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
		WHERE order_delivered_carrier_date <= order_delivered_customer_date OR order_delivered_customer_date IS NULL
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';

		SET @batch_end_time = GETDATE();
		PRINT '====================================='
		PRINT 'Loading Silver Layer is Completed';
		PRINT '<< -- Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=======================================';

	END TRY
	BEGIN CATCH
		PRINT '========================================='
		PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_MESSAGE() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '========================================='
	END CATCH
END