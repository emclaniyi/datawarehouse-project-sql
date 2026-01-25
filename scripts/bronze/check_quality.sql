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

