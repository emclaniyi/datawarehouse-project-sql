IF OBJECT_ID ('silver.olist_customers', 'U') IS NOT NULL
	DROP TABLE silver.olist_customers;
CREATE TABLE silver.olist_customers(
	customer_id	NVARCHAR(250),
	customer_unique_id	NVARCHAR(250),
	customer_zip_code_prefix	INT,
	customer_city	NVARCHAR(250),
	customer_state NVARCHAR(250),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.olist_geolocation', 'U') IS NOT NULL
	DROP TABLE silver.olist_geolocation;
CREATE TABLE silver.olist_geolocation(
	geolocation_zip_code_prefix	INT,
	geolocation_lat	DECIMAL(9,6),
	geolocation_lng	DECIMAL(9,6),
	geolocation_city	NVARCHAR(250),
	geolocation_state NVARCHAR(250),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.olist_order_items', 'U') IS NOT NULL
	DROP TABLE silver.olist_order_items;
CREATE TABLE silver.olist_order_items(
	order_id NVARCHAR(250),
	order_item_id	INT,
	product_id	NVARCHAR(250),
	seller_id NVARCHAR(250),
	shipping_limit_date DATETIME,
	price DECIMAL(19, 4),
	freight_value DECIMAL(19, 4),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.olist_order_payments', 'U') IS NOT NULL
	DROP TABLE silver.olist_order_payments;
CREATE TABLE silver.olist_order_payments(
	order_id NVARCHAR(250),
	payment_sequential	INT,
	payment_type	NVARCHAR(250),
	payment_installments INT,
	payment_value DECIMAL(19, 2),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.olist_order_reviews', 'U') IS NOT NULL
	DROP TABLE silver.olist_order_reviews;
CREATE TABLE silver.olist_order_reviews(
	review_id NVARCHAR(250),
	order_id NVARCHAR(250),
	review_score	NVARCHAR(250),
	review_comment_title	NVARCHAR(MAX),
	review_comment_message NVARCHAR(MAX),
	review_creation_date NVARCHAR(255),
	review_answer_timestamp NVARCHAR(255),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);			

IF OBJECT_ID ('silver.olist_orders', 'U') IS NOT NULL
	DROP TABLE silver.olist_orders;		
CREATE TABLE silver.olist_orders(
	order_id NVARCHAR(250),
	customer_id NVARCHAR(250),
	order_status	NVARCHAR(250),
	order_purchase_timestamp	DATETIME,
	order_approved_at DATETIME,
	order_delivered_carrier_date DATETIME,
	order_delivered_customer_date DATETIME,
	order_estimated_delivery_date DATETIME,
	flag_late_delivery NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);	

IF OBJECT_ID ('silver.olist_products', 'U') IS NOT NULL
	DROP TABLE silver.olist_products;		
CREATE TABLE silver.olist_products(
	product_id NVARCHAR(250),
	product_category_name NVARCHAR(250),
	product_name_lenght	INT,
	product_description_lenght	INT,
	product_photos_qty INT,
	product_weight_g INT,
	product_length_cm INT,
	product_height_cm NVARCHAR(250),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);	

IF OBJECT_ID ('silver.sellers', 'U') IS NOT NULL
	DROP TABLE silver.sellers;
CREATE TABLE silver.sellers(
	seller_id NVARCHAR(250),
	seller_zip_code_prefix	INT,
	seller_city	NVARCHAR(250),
	seller_state NVARCHAR(250),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
	
);	

IF OBJECT_ID ('silver.product_name_translation', 'U') IS NOT NULL
	DROP TABLE silver.product_name_translation;
CREATE TABLE silver.product_name_translation(
	product_category_name NVARCHAR(250),
	product_category_name_english NVARCHAR(250),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
	
);


	
