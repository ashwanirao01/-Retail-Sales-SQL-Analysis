# 🛍️ Retail Sales SQL Analysis

This is a SQL-based retail sales analysis project where I worked with a retail sales dataset to understand sales performance, customer behavior, product categories, and different sales patterns.

I mainly used **PostgreSQL** for data cleaning, exploration, and analysis.

## 📌 Project Overview

The main purpose of this project was to practice SQL on a real-world type of sales dataset and answer some common business questions using SQL queries.

In this project, I worked on:

* Data cleaning
* Handling NULL values
* Basic data exploration
* Sales analysis by category
* Customer analysis
* Gender-wise sales analysis
* Monthly sales analysis
* Top customers
* Category-wise unique customers
* Sales analysis based on time/shift

## 🗂️ Dataset Columns

The dataset contains the following columns:

| Column           | Description                    |
| ---------------- | ------------------------------ |
| `TRANSACTION_ID` | Unique ID for each transaction |
| `SALE_DATE`      | Date of the sale               |
| `SALE_TIME`      | Time of the sale               |
| `CUSTOMER_ID`    | Customer ID                    |
| `GENDER`         | Customer gender                |
| `AGE`            | Customer age                   |
| `CATEGORY`       | Product category               |
| `QUANTITY`       | Quantity purchased             |
| `PRICE_PER_UNIT` | Price per unit                 |
| `COGS`           | Cost of goods sold             |
| `TOTAL_SALE`     | Total amount of the sale       |

## 🧹 Data Cleaning

Before starting the analysis, I checked the dataset for missing values.

I used SQL to:

* Check the total number of records
* Find NULL values in important columns
* Remove records containing NULL values

Example:

```sql
SELECT COUNT(*)
FROM RETAILS_SALES
WHERE TRANSACTION_ID IS NULL
   OR SALE_DATE IS NULL
   OR SALE_TIME IS NULL
   OR CUSTOMER_ID IS NULL
   OR GENDER IS NULL
   OR AGE IS NULL
   OR CATEGORY IS NULL
   OR QUANTITY IS NULL
   OR PRICE_PER_UNIT IS NULL
   OR COGS IS NULL
   OR TOTAL_SALE IS NULL;
```

## 🔎 Analysis Questions

I used SQL to answer the following questions:

1. Find all sales made on `2022-11-05`.
2. Find Clothing transactions where quantity sold was more than 4 during November 2022.
3. Calculate total sales for each category.
4. Find the average age of customers who purchased from the Beauty category.
5. Find transactions where total sales were greater than 1000.
6. Find the number of transactions made by each gender in each category.
7. Find the best-selling month for each year based on average sales.
8. Find the top 5 customers based on total sales.
9. Find the number of unique customers in each category.
10. Divide sales into Morning, Afternoon, and Evening shifts and find the number of orders in each shift.

## 💡 SQL Concepts Used

During this project, I practiced:

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `HAVING`
* `COUNT()`
* `SUM()`
* `AVG()`
* `COUNT(DISTINCT)`
* `CASE WHEN`
* `EXTRACT()`
* `RANK()`
* `PARTITION BY`
* `CTE`
* Subqueries
* Date and time functions

## 📊 Example Analysis

### Top 5 Customers

```sql
SELECT 
    CUSTOMER_ID,
    SUM(TOTAL_SALE) AS TOTAL_SALES
FROM RETAILS_SALES
GROUP BY CUSTOMER_ID
ORDER BY TOTAL_SALES DESC
LIMIT 5;
```

### Best Selling Month in Each Year

For this analysis, I used `RANK()` with `PARTITION BY` to compare the average sales of each month within the same year.

```sql
RANK() OVER(
    PARTITION BY EXTRACT(YEAR FROM SALE_DATE)
    ORDER BY AVG(TOTAL_SALE) DESC
)
```

### Sales by Shift

I divided the transactions into three shifts:

* **Morning:** Before 12 PM
* **Afternoon:** 12 PM to 5 PM
* **Evening:** After 5 PM

This helped me understand the number of orders received during different parts of the day.

## 🎯 What I Learned

This project helped me understand how SQL can be used not just to retrieve data, but also to answer business-related questions.

Some of the main things I practiced were:

* Filtering data using `WHERE`
* Grouping data using `GROUP BY`
* Sorting results using `ORDER BY`
* Using aggregate functions for analysis
* Filtering grouped results with `HAVING`
* Using window functions like `RANK()`
* Working with dates and times
* Using CTEs to make queries easier to understand

## 🛠️ Tools Used

* **PostgreSQL**
* **SQL**
* **GitHub**

## 📁 Project Structure

```text
Retail-Sales-SQL-Analysis/
│
├── retail_sales.sql
├── README.md
└── dataset/
    └── retail_sales.csv
```

## 🚀 Conclusion

This was one of my SQL practice projects where I tried to analyze a retail sales dataset and solve different business questions using SQL.

The project gave me more practice with **GROUP BY, ORDER BY, aggregate functions, CTEs, and window functions**, which are important concepts for SQL and data analysis.
