-- Q4 For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
		-- Account tenure (months since signup)
		-- Total transactions
		-- Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
		-- Order by estimated CLV from highest to lowest


-- Common Table Expression (CTE) to gather transaction data for each customer
WITH TransactionData AS (
    SELECT 
        u.id AS customer_id,  
        CONCAT(u.first_name, ' ', u.last_name) AS name, 
        TIMESTAMPDIFF(MONTH, u.date_joined, NOW()) AS tenure_months,  -- Calculate account tenure in months
        COUNT(sa.id) AS total_transactions,  -- Count total successful transactions for the customer
        SUM(sa.amount) AS total_transaction_value  -- Sum of all successful transaction values
    FROM 
        users_customuser u  
    LEFT JOIN 
        savings_savingsaccount sa ON sa.id = u.id  
    WHERE 
        sa.transaction_status = 'success'  
    GROUP BY 
        u.id  
),

-- CTE to calculate estimated Customer Lifetime Value (CLV) for each customer
EstimatedCLV AS (
    SELECT 
        customer_id, 
        name, 
        tenure_months, 
        total_transactions, 
        
        -- Calculating estimated CLV using the formula provided
        (total_transactions / NULLIF(tenure_months, 0)) * 12 * (0.001 * total_transaction_value) AS estimated_clv
        -- NULLIF is used to prevent division by zero if tenure_months is 0
    FROM 
        TransactionData 
)

-- Final selection of results
SELECT 
    customer_id, 
    name, 
    tenure_months, 
    total_transactions,  
    estimated_clv  
FROM 
    EstimatedCLV 
ORDER BY 
    estimated_clv DESC; 