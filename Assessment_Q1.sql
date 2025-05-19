SELECT * FROM users_customuser ;

SELECT * FROM savings_savingsaccount ;

SELECT * FROM plans_plan

-- The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
-- Task:  a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
;

SELECT 
    p.owner_id,
     CONCAT(us.first_name, ' ',us.last_name) AS fullname,
    COUNT(p.is_a_fund) AS investment_count,
    COUNT(p.is_regular_savings) AS savings_count, 
    SUM(sa.amount) AS total_deposits 
FROM plans_plan p  

JOIN
users_customuser us 
ON
us.id = p.owner_id  

JOIN 
savings_savingsaccount sa 
ON 
sa.plan_id = p.id

WHERE 
sa.transaction_status = 'success'  
GROUP BY 
p.owner_id, CONCAT(us.first_name, ' ',us.last_name), p.is_a_fund, p.is_regular_savings

HAVING -- filtering the table
    SUM(p.is_a_fund >= 1)
    OR  
    SUM(p.is_regular_savings >= 1) 

ORDER BY 
total_deposits ASC 
LIMIT 0, 5000