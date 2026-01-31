SELECT 
    [review_id],
    [order_id],
    [review_score],
    [review_comment_title],
    
    -- Use CONCAT instead of + to safely handle NULLs
    CONCAT([review_comment_message], ' ', 
           CASE WHEN [review_answer_timestamp] LIKE '%,%' THEN [review_creation_date] ELSE '' END
    ) AS [stg_review_message],

    -- Keep as strings for now to avoid conversion errors
    CASE
        WHEN [review_answer_timestamp] LIKE '%,%'
        THEN LEFT([review_answer_timestamp], CHARINDEX(',', [review_answer_timestamp]) - 1)
        ELSE [review_creation_date]
    END AS [stg_creation_date],

    CASE
        WHEN [review_answer_timestamp] LIKE '%,%'
        THEN LTRIM(SUBSTRING([review_answer_timestamp], CHARINDEX(',', [review_answer_timestamp]) + 1, 100))
        ELSE [review_answer_timestamp]
    END AS [stg_answer_timestamp]
INTO stg_order_reviews
FROM [DataWarehouse].[bronze].[olist_order_reviews];