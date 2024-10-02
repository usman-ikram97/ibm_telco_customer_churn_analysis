# **IBM Telco Customer Churn Analysis Report**

## Introduction

This is the portfolio project for the SQL module in my data analytics boot camp at atomcamp. We were provided with a dataset to run various queries and perform analysis on it. I thoroughly enjoyed working on this project as it allowed me to enhance my SQL skills, develop an analytical mindset, and gain insights into business acumen.

I performed extra analyses and queries beyond the initial requirements to gain deeper insights into customer behavior and churn dynamics. These findings are presented below, showcasing the comprehensive nature of my investigation.

Moreover, as part of this project, I have written a detailed article on Medium. Check it out here:

**[Medium Article](https://medium.com/@usman97/how-sql-can-transform-customer-retention-strategies-8394b1ee4495)**

Let’s dive into the project!

## Dataset Overview

The dataset used for this analysis contains information about 7043 customers from a fictional telco company in California focusing on customer churn. Key variables include customer demographics (age, gender, and location), service information (types of services used, contract types, and monthly charges), payment methods (e.g. credit card and electronic check), and churn status indicating whether a customer has left the service.

The dataset was sourced from the **IBM Telco Customer Churn** dataset, which is available on GitHub. The preprocessing steps involved cleaning the data by handling missing values and removing unnecessary columns.

## Tool Used

I have used [MySQL Workbench](https://www.mysql.com/products/workbench/) for quering and analyzing data.

## SQL Queries and Analysis

### Query 1: How can personalized offers be tailored to potentially improve customer retention rates?

#### SQL Query

```sql
SELECT ROUND(AVG(monthly_charge), 2) AS average_monthly_charges, age, gender, contract
FROM telco_churn
WHERE churn_label = 'Yes'
GROUP BY age, gender, contract
ORDER BY average_monthly_charges DESC
LIMIT 5;
```

#### Query Result

| Average Monthly Charges | Age | Gender | Contract |
|-------------------------|-----|--------|----------|
| 113.15                  | 48  | Male   | Two Year |
| 111.40                  | 66  | Male   | One Year |
| 110.90                  | 69  | Male   | One Year |
| 110.15                  | 43  | Male   | One Year |
| 110.10                  | 25  | Male   | Two Year |

#### Analysis

The top 5 churned customers with the highest average monthly charges are all male aged between 25 and 69. Most had one-year contracts, with only two on two-year contracts. Older customers, especially those in their 60s, are likely paying more, possibly expecting better service or benefits. Younger customers on longer contracts may feel their needs aren't being met despite their commitment.

To reduce churn, offering loyalty rewards or discounts for older customers could help retain them. For one-year contracts, providing renewal incentives or discounted upgrades before their term ends could prevent churn. For younger customers, adding flexible services or entertainment bundles that align with their interests might increase satisfaction. Personalized offers based on age and contract type could significantly boost retention.

### Query 2: What are the feedback or complaints from those churned customers?

#### SQL Query

```sql
SELECT churn_category, churn_reason, COUNT(*) AS number_of_customers
FROM telco_churn
WHERE churn_label = 'Yes'
GROUP BY churn_category, churn_reason
ORDER BY number_of_customers DESC
LIMIT 10;
```

#### Query Result

| Churn Category | Churn Reason                      | Number of Customers |
|----------------|-----------------------------------|---------------------|
| Competitor     | Competitor had better devices     | 313                 |
| Competitor     | Competitor made better offer      | 311                 |
| Attitude       | Attitude of support person        | 220                 |
| Other          | Don't know                        | 130                 |
| Competitor     | Competitor offered more data      | 117                 |
| Competitor     | Competitor offered higher speeds  | 100                 |
| Attitude       | Attitude of service provider      | 94                  |
| Price          | Price too high                    | 78                  |
| Dissatisfaction| Product dissatisfaction           | 77                  |
| Dissatisfaction| Network reliability               | 72                  |

#### Analysis

The majority of churned customers cited competitor-related reasons, with 313 leaving due to better devices and 311 due to better offers. Additionally, many customers felt dissatisfied with support—220 mentioned the attitude of support personnel, and 94 cited the attitude of the service provider. Price and product dissatisfaction were also significant, with 78 leaving due to high prices and 77 because of dissatisfaction with the product.

To address these issues, improving customer support, offering competitive deals, and ensuring better device options or pricing plans could help reduce churn. Special focus on network reliability and service quality could also mitigate dissatisfaction.

### Query 3: How does the payment method influence churn behavior?

#### SQL Query

```sql
SELECT payment_method, ROUND(AVG(monthly_charge), 2) AS average_monthly_charge, COUNT(*) AS number_of_customers
FROM telco_churn
WHERE churn_label = 'Yes'
GROUP BY payment_method
ORDER BY number_of_customers DESC;
```

#### Query Result

| Payment Method | Average Monthly Charge | Number of Customers |
|----------------|------------------------|---------------------|
| Bank Withdrawal| 78.54                  | 1329                |
| Credit Card    | 68.01                  | 398                 |
| Mailed Check   | 54.11                  | 142                 |

#### Analysis

The data shows that customers using bank withdrawal as a payment method have the highest average monthly charge at $78.54 with 1329 customers. In contrast, those using credit cards pay an average of $68.01 (398 customers) while mailed checks have the lowest average charge at $54.11 (142 customers).

This suggests that customers who opt for bank withdrawal are willing to pay more, possibly indicating higher loyalty or satisfaction. Conversely, those using mailed checks who have the lowest average charges may be more price-sensitive or less engaged.

To improve retention, targeting promotions or personalized offers toward credit card and mailed check users could enhance their satisfaction and reduce churn. Additionally, reinforcing the benefits of automatic payments through bank withdrawals may help maintain their loyalty.

#### Query 4: Which Internet Type Has the Highest Churn Rate?

#### SQL Query

```sql
SELECT internet_type, COUNT(*) AS total_customers, 
       SUM(churn_label = 'Yes') AS churned_customers, 
       (SUM(churn_label = 'Yes') / COUNT(*)) * 100 AS churn_rate
FROM telco_churn
GROUP BY internet_type
ORDER BY churn_rate DESC;
```

#### Query Result

| Internet Type | Total Customers | Churned Customers | Churn Rate |
|---------------|-----------------|-------------------|------------|
| Fiber Optic   | 3035            | 1236              | 40.72%     |
| Cable         | 830             | 213               | 25.66%     |
| DSL           | 1652            | 307               | 18.58%     |
| None          | 1526            | 113               | 7.41%      |

#### Analysis

Fiber Optic has the highest churn rate at 40.72%. In comparison, Cable has a churn rate of 25.66%, and DSL and None show much lower rates. To reduce churn, the company should focus on improving Fiber Optic services, offering better pricing and reliability.

### Query 5: How Do Contract Types Affect Churn Rates?

#### SQL Query

```sql
SELECT contract, COUNT(*) AS total_customers, 
       SUM(churn_label = 'Yes') AS churned_customers, 
       (SUM(churn_label = 'Yes') / COUNT(*)) * 100 AS churn_rate
FROM telco_churn
GROUP BY contract
ORDER BY churn_rate DESC;
```

#### Query Result

| Contract     | Total Customers | Churned Customers | Churn Rate |
|--------------|-----------------|-------------------|------------|
| Month-to-Month| 3610            | 1655              | 45.84%     |
| One Year     | 1550            | 166               | 10.71%     |
| Two Year     | 1883            | 48                | 2.55%      |

#### Analysis

Month-to-Month contracts show the highest churn rate (45.84%). Longer contracts like One and Two Year exhibit lower churn rates. Offering incentives for long-term contracts can reduce churn.

### Query 6: Is There a Correlation Between Satisfaction Score and Churn?

#### SQL Query

```sql
SELECT satisfaction_score, COUNT(*) AS total_customers, 
       SUM(churn_label = 'Yes') AS churned_customers, 
       (SUM(churn_label = 'Yes') / COUNT(*)) * 100 AS churn_rate
FROM telco_churn
GROUP BY satisfaction_score
ORDER BY churn_rate DESC;
```

#### Query Result

| Satisfaction Score | Total Customers | Churned Customers | Churn Rate |
|--------------------|-----------------|-------------------|------------|
| 1                  | 922             | 922               | 100.00%    |
| 2                  | 518             | 518               | 100.00%    |
| 3                  | 2665            | 429               | 16.10%     |
| 4                  | 1789            | 0                 | 0.00%      |
| 5                  | 1149            | 0                 | 0.00%      |

#### Analysis

There is a strong correlation between satisfaction scores and churn. Customers with low satisfaction scores (1 and 2) exhibit 100% churn, while those with higher scores show no churn. Improving satisfaction scores can significantly reduce churn.

## Insights and Recommendations

- **Targeted Offers for High Spenders**: Focus on customers aged 43-69 who pay over $110 monthly, offering tailored loyalty programs or exclusive discounts.
- **Competitor Awareness**: Improve device offerings and make competitive pricing adjustments, especially in the Fiber Optic segment.
- **Enhancing Support Services**: Invest in customer support training to improve attitudes and responsiveness.
- **Payment Method Engagement**: Increase marketing efforts for bank withdrawals and engage credit card and mailed check users.
- **Fiber Optic Improvements**: Address Fiber Optic service issues to reduce the 40.72% churn rate.
- **Contract Value Propositions**: Create offers to incentivize Month-to-Month customers to switch to longer-term contracts.
- **Satisfaction Score Initiatives**: Develop a feedback loop with low-scoring customers to address their concerns and improve satisfaction.

## Conclusion

This project has greatly enhanced my understanding of SQL, critical analysis, and business acumen. By examining customer churn factors and developing targeted strategies for retention, I gained valuable insights into data-driven decision-making. The experience not only improved my analytical skills but also deepened my appreciation for the importance of customer satisfaction and strategic offerings. Overall, this analysis has been an invaluable learning opportunity that will benefit my future endeavors in data analytics.

