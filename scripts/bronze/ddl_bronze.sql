IF OBJECT_ID ('bronze.olist_customers', 'U') IS NOT NULL
	DROP TABLE bronze.olist_customers;
CREATE TABLE bronze.olist_customers(
	customer_id	NVARCHAR(250),
	customer_unique_id	NVARCHAR(250),
	customer_zip_code_prefix	INT,
	customer_city	NVARCHAR(250),
	customer_state NVARCHAR(250)
);

IF OBJECT_ID ('bronze.olist_geolocation', 'U') IS NOT NULL
	DROP TABLE bronze.olist_geolocation;
CREATE TABLE bronze.olist_geolocation(
	geolocation_zip_code_prefix	INT,
	geolocation_lat	DECIMAL(9,6),
	geolocation_lng	DECIMAL(9,6),
	geolocation_city	NVARCHAR(250),
	geolocation_state NVARCHAR(250)
);

IF OBJECT_ID ('bronze.olist_order_items', 'U') IS NOT NULL
	DROP TABLE bronze.olist_order_items;
CREATE TABLE bronze.olist_order_items(
	order_id NVARCHAR(250),
	order_item_id	INT,
	product_id	INT,
	seller_id INT,
	shipping_limit_date DATETIME,
	price DECIMAL(19, 4),
	freight_value DECIMAL(19, 4)
);

IF OBJECT_ID ('bronze.olist_order_payments', 'U') IS NOT NULL
	DROP TABLE bronze.olist_order_payments;
CREATE TABLE bronze.olist_order_payments(
	order_id NVARCHAR(250),
	payment_sequential	INT,
	payment_type	NVARCHAR(250),
	payment_installments INT,
	payment_value DECIMAL(19, 4)
);

IF OBJECT_ID ('bronze.olist_order_reviews', 'U') IS NOT NULL
	DROP TABLE bronze.olist_order_reviews;
CREATE TABLE bronze.olist_order_reviews(
	review_id NVARCHAR(250),
	order_id NVARCHAR(250),
	review_score	INT,
	review_comment_title	NVARCHAR(250),
	review_comment_message NVARCHAR(250),
	review_creation_date DATETIME,
	review_answer_timestamp DATETIME
);			

IF OBJECT_ID ('bronze.olist_orders', 'U') IS NOT NULL
	DROP TABLE bronze.olist_orders;		
CREATE TABLE bronze.olist_orders(
	order_id NVARCHAR(250),
	customer_id NVARCHAR(250),
	order_status	NVARCHAR(250),
	order_purchase_timestamp	DATETIME,
	order_approved_at DATETIME,
	order_delivered_carrier_date DATETIME,
	order_delivered_customer_date DATETIME,
	order_estimated_delivery_date DATETIME
);	

IF OBJECT_ID ('bronze.olist_products', 'U') IS NOT NULL
	DROP TABLE bronze.olist_products;		
CREATE TABLE bronze.olist_products(
	product_id NVARCHAR(250),
	product_category_name NVARCHAR(250),
	product_name_lenght	INT,
	product_description_lenght	INT,
	product_photos_qty INT,
	product_weight_g INT,
	product_length_cm INT,
	product_height_cm INT,
);	

IF OBJECT_ID ('bronze.sellers', 'U') IS NOT NULL
	DROP TABLE bronze.sellers;
CREATE TABLE bronze.sellers(
	seller_id NVARCHAR(250),
	seller_zip_code_prefix	INT,
	seller_city	NVARCHAR(250),
	seller_state NVARCHAR(250)
	
);	

IF OBJECT_ID ('bronze.product_name_translation', 'U') IS NOT NULL
	DROP TABLE bronze.product_name_translation;
CREATE TABLE bronze.product_name_translation(
	product_category_name NVARCHAR(250),
	product_category_name_english NVARCHAR(250)
	
);
	
