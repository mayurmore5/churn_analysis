USE telecom_churn_db; -- Make sure you are using the correct database

-- Query 1: Select all columns for the first 10 rows to get a quick look at the data
SELECT *
FROM telco_churn_data
LIMIT 10;

-- Query 2: Get the total number of customers
SELECT COUNT(customerID) AS total_customers
FROM telco_churn_data;

-- Query 3: Check the distribution of Churn (our target variable)
SELECT Churn, COUNT(customerID) AS num_customers,
       ROUND(COUNT(customerID) * 100.0 / (SELECT COUNT(*) FROM telco_churn_data), 2) AS percentage
FROM telco_churn_data
GROUP BY Churn;

-- Query 4: Find the average MonthlyCharges and TotalCharges
-- Handling potential non-numeric 'TotalCharges' (e.g., empty strings or spaces)
SELECT AVG(MonthlyCharges) AS average_monthly_charges,
       AVG(CASE
               WHEN TotalCharges REGEXP '^[0-9]+(\.[0-9]+)?$' THEN CAST(TotalCharges AS DECIMAL(10, 2))
               ELSE NULL
           END) AS average_total_charges
FROM telco_churn_data;
-- The REGEXP check is essential for `TotalCharges` if it contains non-numeric entries like spaces or empty strings.

-- Query 5: Distribution of customers by Contract type and Churn status
SELECT Contract, Churn, COUNT(customerID) AS num_customers
FROM telco_churn_data
GROUP BY Contract, Churn
ORDER BY Contract, Churn;

-- Query 6: Churn rate by InternetService type
SELECT InternetService,
       COUNT(customerID) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 2) AS churn_rate_percentage
FROM telco_churn_data
GROUP BY InternetService
ORDER BY churn_rate_percentage DESC;

-- Query 7: Identify customers with missing or problematic 'TotalCharges'
-- The IBM dataset typically has empty strings for new customers who haven't accumulated total charges yet.
SELECT customerID, TotalCharges, MonthlyCharges, tenure
FROM telco_churn_data
WHERE TotalCharges IS NULL OR TotalCharges = '' OR TotalCharges NOT REGEXP '^[0-9]+(\.[0-9]+)?$';

-- Query 8: Average tenure for churned vs. non-churned customers
SELECT Churn, AVG(tenure) AS average_tenure
FROM telco_churn_data
GROUP BY Churn;

-- Query 9 (New - for `SeniorCitizen`): Churn rate by SeniorCitizen status
SELECT SeniorCitizen,
       COUNT(customerID) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
       ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(customerID), 2) AS churn_rate_percentage
FROM telco_churn_data
GROUP BY SeniorCitizen
ORDER BY churn_rate_percentage DESC;