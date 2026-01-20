CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '============================================';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.olist_customers'
		TRUNCATE TABLE bronze.olist_customers
		PRINT '>> Inserting Data Into: bronze.olist_customers'
		BULK INSERT bronze.olist_customers
		FROM 'C:\Users\EM\Project\datawarehouse-project-sql\datasets\olist_customers_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDQUOTE = '"',
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.olist_geolocation'
		TRUNCATE TABLE bronze.olist_geolocation
		PRINT '>> Inserting Data Into: bronze.olist_geolocation'
		BULK INSERT bronze.olist_geolocation
		FROM 'C:\Users\EM\Project\datawarehouse-project-sql\datasets\olist_geolocation_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDQUOTE = '"',
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.olist_order_items'
		TRUNCATE TABLE bronze.olist_order_items
		PRINT '>> Inserting Data Into: bronze.olist_order_items'
		BULK INSERT bronze.olist_order_items
		FROM 'C:\Users\EM\Project\datawarehouse-project-sql\datasets\olist_order_items_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDQUOTE = '"',
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.olist_order_payments'
		TRUNCATE TABLE bronze.olist_order_payments
		PRINT '>> Inserting Data Into: bronze.olist_order_payments'
		BULK INSERT bronze.olist_order_payments
		FROM 'C:\Users\EM\Project\datawarehouse-project-sql\datasets\olist_order_payments_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDQUOTE = '"',
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.olist_orders'
		TRUNCATE TABLE bronze.olist_orders
		PRINT '>> Inserting Data Into: bronze.olist_orders'
		BULK INSERT bronze.olist_orders
		FROM 'C:\Users\EM\Project\datawarehouse-project-sql\datasets\olist_orders_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDQUOTE = '"',
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.sellers'
		TRUNCATE TABLE bronze.sellers
		PRINT '>> Inserting Data Into: bronze.sellers'
		BULK INSERT bronze.sellers
		FROM 'C:\Users\EM\Project\datawarehouse-project-sql\datasets\olist_sellers_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDQUOTE = '"',
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.product_name_translation'
		TRUNCATE TABLE bronze.product_name_translation
		PRINT '>> Inserting Data Into: bronze.product_name_translation'
		BULK INSERT bronze.product_name_translation
		FROM 'C:\Users\EM\Project\datawarehouse-project-sql\datasets\product_category_name_translation.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDQUOTE = '"',
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.olist_order_reviews'
		TRUNCATE TABLE bronze.olist_order_reviews
		PRINT '>> Inserting Data Into: bronze.olist_order_reviews'
		BULK INSERT bronze.olist_order_reviews
		FROM 'C:\Users\EM\Project\datawarehouse-project-sql\datasets\olist_order_reviews_dataset.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			CODEPAGE = '65001',
			KEEPNULLS,
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.olist_products'
		TRUNCATE TABLE bronze.olist_products
		PRINT '>> Inserting Data Into: bronze.olist_products'
		BULK INSERT bronze.olist_products
		FROM 'C:\Users\EM\Project\datawarehouse-project-sql\datasets\olist_products_dataset.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT'>> ----------------------';
		
		SET @batch_end_time = GETDATE();
		PRINT '====================================='
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '<< -- Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=======================================';

	END TRY
	BEGIN CATCH
		PRINT '========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_MESSAGE() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '========================================='
	END CATCH
END