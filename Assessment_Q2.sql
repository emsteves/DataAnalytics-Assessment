-- Q2- Calculate the average number of transactions per customer per month and categorize them:
		-- "High Frequency" (≥10 transactions/month)
		-- "Medium Frequency" (3-9 transactions/month)
		-- "Low Frequency" (≤2 transactions/month)

-- CTE for monthly transactions
WITH Monthly_Transactions AS (
    SELECT 
        u.id, 
        COUNT(sa.id) AS trans_count, 
        DATE_FORMAT(sa.transaction_date, '%Y-%m') AS trans_monthly
    FROM 
        users_customuser u
    LEFT JOIN 
        savings_savingsaccount sa ON sa.id = u.id
    WHERE 
        sa.transaction_status = 'success'
    GROUP BY 
        u.id, trans_monthly
), 

-- CTE for Average Transactions
Average_Transactions AS (
    SELECT 
        id, 
        AVG(trans_count) AS avg_trans_per_month
    FROM 
        Monthly_Transactions
    GROUP BY 
        id
), 

-- CTE for frequency categories
Frequency_Categories AS (
    SELECT 
        CASE 
            WHEN avg_trans_per_month >= 10 THEN 'High Frequency'
            WHEN avg_trans_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        COUNT(id) AS customer_count,  
        AVG(avg_trans_per_month) AS avg_transactions_per_month
    FROM 
        Average_Transactions
    GROUP BY 
        frequency_category
)
-- Final Selection
SELECT 
    frequency_category,
    customer_count,
    avg_transactions_per_month
FROM 
    Frequency_Categories;