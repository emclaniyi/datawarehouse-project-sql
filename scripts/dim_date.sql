WITH DateRange AS (
    SELECT CAST('2016-09-04' AS DATE) AS DateValue
    UNION ALL
    SELECT DATEADD(day, 1, DateValue)
    FROM DateRange
    WHERE DateValue <= '2018-10-17'
)
SELECT 
    CAST(FORMAT(DateValue, 'yyyyMMdd') AS INT) AS date_key,
    DateValue AS full_date,
    YEAR(DateValue) AS year,
    DATEPART(quarter, DateValue) AS quarter,
    MONTH(DateValue) AS month,
    DATENAME(month, DateValue) AS month_name,
    DAY(DateValue) AS day,
    DATENAME(weekday, DateValue) AS day_name,
    CASE WHEN DATEPART(weekday, DateValue) IN (1, 7) THEN 1 ELSE 0 END AS is_weekend
INTO silver.dim_date
FROM DateRange
OPTION (MAXRECURSION 0);

--DROP TABLE gold.dim_date