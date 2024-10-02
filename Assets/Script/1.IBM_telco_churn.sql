create schema sql_portfolio_project;

use sql_portfolio_project;

CREATE TABLE telco_churn (
    customer_id VARCHAR(255),
    number_of_referrals INT,
    tenure_in_months INT,
    offer VARCHAR(255),
    phone_service VARCHAR(3),  -- Assuming it's a string like 'Yes' or 'No'
    avg_monthly_long_distance_charges FLOAT,
    multiple_lines VARCHAR(3),  -- Assuming it's a string like 'Yes' or 'No'
    internet_type VARCHAR(255),
    avg_monthly_gb_download INT,
    online_security VARCHAR(3),  -- Assuming it's a string like 'Yes' or 'No'
    online_backup VARCHAR(3),    -- Assuming it's a string like 'Yes' or 'No'
    device_protection_plan VARCHAR(3),  -- Assuming it's a string like 'Yes' or 'No'
    premium_tech_support VARCHAR(3),    -- Assuming it's a string like 'Yes' or 'No'
    streaming_tv VARCHAR(3),    -- Assuming it's a string like 'Yes' or 'No'
    streaming_movies VARCHAR(3), -- Assuming it's a string like 'Yes' or 'No'
    streaming_music VARCHAR(3),  -- Assuming it's a string like 'Yes' or 'No'
    unlimited_data VARCHAR(3),   -- Assuming it's a string like 'Yes' or 'No'
    contract VARCHAR(255),
    paperless_billing VARCHAR(3),  -- Assuming it's a string like 'Yes' or 'No'
    payment_method VARCHAR(255),
    monthly_charge FLOAT,  -- Assuming it's a monetary value
    total_charges FLOAT,
    total_refunds FLOAT,
    total_extra_data_charges INT,
    total_long_distance_charges FLOAT,
    total_revenue FLOAT,
    city VARCHAR(255),
    zip_code VARCHAR(255),
    latitude VARCHAR(65),
    longitude VARCHAR(65),
    population INT,
    gender VARCHAR(6),  
    age INT,
    married VARCHAR(3),  -- Assuming it's a string like 'Yes' or 'No'
    number_of_dependents INT,
    satisfaction_score INT,
    customer_status VARCHAR(255),
    churn_label VARCHAR(3),
    churn_score INT,
    cltv INT,
    churn_category VARCHAR(255),
    churn_reason VARCHAR(255)
);

-- Query 1: Considering the top 5 groups with the highest average monthly charges among churned customers, how can personalized offers be tailored based on age, gender, and contract type to potentially improve customer retention rates?

select round(avg(monthly_charge), 2) as average_monthly_charges , age, gender, contract
from telco_churn
where churn_label = 'Yes'
group by age, gender, contract
order by average_monthly_charges desc
limit 5;

-- Query 2: What are the feedback or complaints from those churned customers

select churn_category, churn_reason, count(*) as number_of_customers
from telco_churn
where churn_label = 'Yes'
group by churn_category, churn_reason
order by number_of_customers desc
limit 10;

-- Query 3: How does the payment method influence churn behavior?

select payment_method, round(avg(monthly_charge), 2) as average_monthly_charge, count(*) as number_of_customers
from telco_churn
where churn_label = 'Yes'
group by payment_method
order by number_of_customers desc;

-- Query 4: Which Internet Type Has the Highest Churn Rate?

SELECT 
    internet_type, 
    COUNT(*) AS total_customers, 
    SUM(churn_label = 'Yes') AS churned_customers,
    (SUM(churn_label = 'Yes') / COUNT(*)) * 100 AS churn_rate
FROM telco_churn
GROUP BY internet_type
ORDER BY churn_rate DESC;

-- Query 5: How Do Contract Types Affect Churn Rates?
	
SELECT 
    contract, 
    COUNT(*) AS total_customers, 
    SUM(churn_label = 'Yes') AS churned_customers,
    (SUM(churn_label = 'Yes') / COUNT(*)) * 100 AS churn_rate
FROM telco_churn
GROUP BY contract
ORDER BY churn_rate DESC;

-- Query 6: Is There a Correlation Between Satisfaction Score and Churn?

SELECT 
    satisfaction_score, 
    COUNT(*) AS total_customers, 
    SUM(churn_label = 'Yes') AS churned_customers,
    (SUM(churn_label = 'Yes') / COUNT(*)) * 100 AS churn_rate
FROM telco_churn
GROUP BY satisfaction_score
ORDER BY churn_rate DESC, satisfaction_score;

