CREATE TABLE #stg_order_reviews AS 
SELECT 
	[review_id]
      ,[order_id]
      ,[review_score]
      ,[review_comment_title]
      --,[review_comment_message]
	  , review_comment_message + ' ' + review_creation_date AS review_comment_message
      --,[review_creation_date]
	  ,CASE
		WHEN [review_answer_timestamp] LIKE '%,%'
		THEN LEFT([review_answer_timestamp], CHARINDEX(',', [review_answer_timestamp]) -1)
		ELSE review_creation_date
	  END review_creation_date
      --,[review_answer_timestamp]
	  , CASE
			WHEN [review_answer_timestamp] LIKE '%,%'
			THEN LTRIM(SUBSTRING([review_answer_timestamp], CHARINDEX(',', [review_answer_timestamp]) + 1, LEN([review_answer_timestamp])))
			ELSE [review_answer_timestamp]
		END [review_answer_timestamp]
  FROM [DataWarehouse].[bronze].[olist_order_reviews]
--WHERE [review_answer_timestamp] LIKE '%,%' OR LEN(review_creation_date) > 20
