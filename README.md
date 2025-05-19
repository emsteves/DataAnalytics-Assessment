# DataAnalytics-Assessment
An Assessment for Cowries

Q 1- Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
Solution: First off, I checked out the three tables needed for the analysis, which include:
i. users_customuser
ii. savings_savingsaccount
iii. plans_plan
Checking tables gave me a view of the columns in the tables and columns needed for the analysis including the primary and foreign keys for joining the tables. 
I selected the appropriate columns from the plans_plan table and summed the amount column from the savings_savingaccount table and later joined the tables. After which I used case statement to specify what I wanted from the plan table.
Challenge: Initially I couldn't find the right column for the investment and savings, I keep getting errors till I read the instructions again and saw the hint.

Q2- Calculate the average number of transactions per customer per month and categorize them:
"High Frequency" (≥10 transactions/month)
"Medium Frequency" (3-9 transactions/month)
"Low Frequency" (≤2 transactions/month)
Solution: I did 3 CTEs, for monthly transactions, average transactions and frequency categories. After which I did the final selection that gave me final result as specified by the instruction.
Chellenge: joining the tables was a bit tricky as I didn't trust the id on the savings table, I kept using savings_id and kept getting empty rows, till I changed to id.

Q3-  Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)
Solution: In order to specify the type of account, I used CASE statements, then called on the transaction dates, joined the savings and plan table and lastly filtered the transaction by last transaction using HAVING
Challenge: initially had issues with the type of account but eventually figured it out.

Q4-  For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
Account tenure (months since signup)
Total transactions
Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
Order by estimated CLV from highest to lowest
Solution: I did CTE to gather transaction data and customer livetime value (CLV), calculated the CLV using the formula given.
Challenge: None
