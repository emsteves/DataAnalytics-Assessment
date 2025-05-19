-- Q3  Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .


SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(sa.transaction_date) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE, MAX(sa.transaction_date)) AS inactivity_days
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount sa ON p.id = sa.plan_id
    AND sa.transaction_status = 'success'
    AND sa.transaction_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)
GROUP BY 
    p.id, p.owner_id, type
HAVING 
    last_transaction_date IS NULL  -- No transactions ever
    OR MAX(sa.transaction_date) < DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)
ORDER BY 
    inactivity_days DESC;