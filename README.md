# 🛍️ Retail Sales Analysis Using SQL

This project involves analyzing a retail sales dataset using **SQL Server (SSMS)**. It includes database creation, data cleaning, exploratory analysis, and business-focused SQL queries to uncover key insights into customer behavior, product sales, and revenue trends.

---

## 📂 Project Structure

- `retails_sales_analysis.sql` → Full SQL script
  - Database creation
  - Table setup
  - Data import via `BULK INSERT`
  - Data cleaning
  - Business problem-solving using SQL

---

## 🧠 Objectives

- Clean and prepare retail sales data
- Use SQL queries to solve business questions
- Generate insights about customers, products, and performance
- Practice real-world SQL use cases (aggregations, filtering, ranking, date-time functions, etc.)

---

## 🛠️ Tools & Technologies

| Tool              | Usage                                  |
|-------------------|-----------------------------------------|
| SQL Server (SSMS) | Querying and data analysis              |
| T-SQL             | SQL dialect used for writing queries    |
| CSV File          | Source of retail transaction data       |

---

## 🧾 Dataset Fields

- `transactions_id` – Unique transaction ID  
- `sale_date` – Date of sale  
- `sale_time` – Time of sale  
- `customer_id` – Unique customer identifier  
- `gender` – Customer gender  
- `age` – Customer age  
- `category` – Product category (Clothing, Beauty, Electronics)  
- `quantity` – Quantity sold  
- `price_per_unit` – Selling price per item  
- `cogs` – Cost of goods sold  
- `total_sale` – Final total sale value  

---

## 🧹 Data Preparation

- Created a new database: `retails_sales_analysis`
- Defined table structure for `retails_sale`
- Imported CSV data using `BULK INSERT`
- Handled missing values by deleting rows with `NULL` in critical columns
- Validated uniqueness of customers and categories

---

## 📊 Business Questions Solved

### Q1: Retrieve all sales made on `'2022-11-05'`
```sql
SELECT * FROM retails_sale WHERE sale_date = '2022-11-05';

✅ Q2: Transactions of category 'Clothing' with quantity ≥ 4 in November 2022
SELECT transactions_id 
FROM retails_sale 
WHERE category = 'Clothing' AND quantity >= 4 
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

✅ Q3: Total sales (total_sale) for each category
SELECT category, SUM(total_sale) AS total_sales
FROM retails_sale
GROUP BY category;

✅ Q4: Average age of customers who purchased from 'Beauty' category
SELECT AVG(age) AS avg_age 
FROM retails_sale 
WHERE category = 'Beauty';

✅ Q5: Transactions where total_sale > 1000
SELECT transactions_id 
FROM retails_sale 
WHERE total_sale > 1000;

✅ Q6: Number of transactions by gender in each category
SELECT gender, category, COUNT(transactions_id) AS total_transactions
FROM retails_sale
GROUP BY category, gender
ORDER BY total_transactions DESC;

✅ Q7: Best selling month (by average sale) in each year
SELECT year_, month_, avg_sale 
FROM (
  SELECT 
    YEAR(sale_date) AS year_, 
    MONTH(sale_date) AS month_, 
    AVG(total_sale) AS avg_sale,
    RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS monthly_rank
  FROM retails_sale
  GROUP BY YEAR(sale_date), MONTH(sale_date)
) T1
WHERE monthly_rank = 1;

✅ Q8: Top 5 customers based on total sales
SELECT customer_id, SUM(total_sale) AS total_sale 
FROM retails_sale 
GROUP BY customer_id 
ORDER BY total_sale DESC 
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

✅ Q9: Number of unique customers per category
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retails_sale
GROUP BY category;

✅ Q10: Order shift distribution by sale time (Morning, Afternoon, Evening)
SELECT 
  CASE 
    WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
    WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS Shift_,
  COUNT(transactions_id) AS total_orders
FROM retails_sale
GROUP BY 
  CASE 
    WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
    WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END;


