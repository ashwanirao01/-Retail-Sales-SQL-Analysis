-- SQL RETAILS SALES  ANALYSIS PROJECT 

-- CREATE DATABASE 
CREATE DATABASE RETAILS_SALES ;

-- CREATE TABLE 
DROP TABLE IF EXISTS RETAILS_SALES;
CREATE TABLE RETAILS_SALES (
    TRANSACTION_ID INT PRIMARY KEY ,
	SALE_DATE DATE ,
	SALE_TIME TIME ,
	CUSTOMER_ID INT ,
	GENDER VARCHAR(100) , 
	AGE INT,
	CATEGORY VARCHAR(50),
	QUANTITY INT ,
	PRICE_PER_UNIT FLOAT ,
	COGS FLOAT ,
	TOTAL_SALE FLOAT 
);

SELECT * FROM RETAILS_SALES 
LIMIT 10 ;
-----------------------
--DATA CLEANING -----
-----------------------
SELECT COUNT(*) FROM RETAILS_SALES;

-- CHECK THE NULL VALUE 
SELECT COUNT(*) FROM RETAILS_SALES 
WHERE 
     TRANSACTION_ID IS NULL 
	 OR 
	 SALE_DATE IS NULL 
	 OR 
	 SALE_TIME IS NULL 
	 OR 
	 CUSTOMER_ID IS NULL 
	 OR 
	 GENDER IS NULL 
	 OR 
	 AGE IS NULL 
	 OR
	 CATEGORY IS NULL
	 OR 
	 QUANTITY IS NULL 
	 OR 
	 PRICE_PER_UNIT IS NULL 
	 OR 
	 COGS IS NULL 
	 OR 
	 TOTAL_SALE IS NULL ;

-- REMVOE THE NULL VALUES 
DELETE FROM RETAILS_SALES 
WHERE 
     TRANSACTION_ID IS NULL 
	 OR 
	 SALE_DATE IS NULL 
	 OR 
	 SALE_TIME IS NULL 
	 OR 
	 CUSTOMER_ID IS NULL
	 OR 
	 GENDER IS NULL 
	 OR 
	 AGE IS NULL 
	 OR 
	 CATEGORY IS NULL 
	 OR 
	 QUANTITY IS NULL 
	 OR 
	 PRICE_PER_UNIT IS NULL 
	 OR 
	 COGS IS NULL 
	 OR 
	 TOTAL_SALE IS NULL ;

-------------------------
--DATA EXPLORATION 
-------------------------

-- HOW MANY SALES WE HAVE 

SELECT  COUNT(*) AS TOTAL_SALES FROM RETAILS_SALES ;

--HOW MANY CUSTOMERS WE HAVE 
SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_CUSTOMERS FROM RETAILS_SALES ;

-- HOW MANY CATEGORY 
SELECT DISTINCT CATEGORY FROM RETAILS_SALES ;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM RETAILS_SALES ;

SELECT * FROM RETAILS_SALES WHERE SALE_DATE ='2022-11-05' ; 

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT * FROM RETAILS_SALES
WHERE 
      CATEGORY  = 'Clothing' 
	  AND QUANTITY >= 4 
	  AND SALE_DATE BETWEEN '2022-11-01' AND '2022-11-30' ; 
   -- AND TO_CHAR(SALE_DATE 'YYYY-MM') = '2022-11'

   
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT CATEGORY ,SUM(TOTAL_SALE) AS TOTAL_SALE , COUNT(*) AS TOTAL_ORDER 
FROM RETAILS_SALES 
GROUP BY 1 ; 

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT ROUND(AVG(AGE),2 )AS AVERAGE_AGE_OF_CUSTOMERS 
FROM RETAILS_SALES 
WHERE CATEGORY = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM RETAILS_SALES 
WHERE TOTAL_SALE > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT COUNT(TRANSACTION_ID) AS NUMBER_OF_TRANSACTIONS , GENDER , CATEGORY 
FROM RETAILS_SALES 
GROUP BY 2,3
ORDER BY 1 ;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
	YEAR ,
	MONTH ,
	AVERAGE_SALES

FROM
(
SELECT 
      EXTRACT(YEAR FROM SALE_DATE) AS YEAR,
	  EXTRACT(MONTH FROM SALE_DATE) AS MONTH,
	  AVG(TOTAL_SALE) AS AVERAGE_SALES ,
	  RANK() OVER(PARTITION BY EXTRACT (YEAR FROM SALE_DATE) ORDER BY AVG(TOTAL_SALE) DESC) AS RANK 
FROM RETAILS_SALES 
GROUP BY 1 , 2 ) AS T1 
WHERE RANK = 1 ;
-- ORDER BY 1 , 3 DESC;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT * FROM RETAILS_SALES ;
SELECT CUSTOMER_ID , SUM(TOTAL_SALE) AS TOTA_SALES 
FROM RETAILS_SALES 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 5  ; 

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT COUNT(DISTINCT CUSTOMER_ID) AS NUMBER_OF_CUSTOMERS  , CATEGORY 
FROM RETAILS_SALES 
GROUP BY 2  ;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift