-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;


-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- Data cleaning
SELECT
	*
FROM sales;


-- Add the time_of_day column
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;


ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

-- For this to work turn off safe mode for update
-- Edit > Preferences > SQL Edito > scroll down and toggle safe mode
-- Reconnect to MySQL: Query > Reconnect to server
UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);


-- Add day_name column
SELECT
	date,
	DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);


-- Add month_name column
SELECT
	date,
	MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
Sales and Revenue Analysis

-- What are the top-performing product lines in terms of revenue and quantity sold?
select product_line, round(sum(total),2) total_revenue,
    sum(quantity) total_quantity 
  from walmart 
   group by product_line 
        order by total_quantity desc;

-- How does sales performance vary between different branches?
select branch,round(sum(total),2) total_revenue 
          from walmart group by branch;

-- Which city contributes the most to our revenue, and what are the popular product lines in that city?
select country, product_line,round(sum(total),2) total_revenue 
      from walmart 
              group by country, product_line order by total_revenue desc;

-- Is there a correlation between the day of the week/month and sales performance?
SELECT
    day_name,COUNT(*) AS transaction_count, SUM(total) AS total_sales 
            FROM walmart 
                    GROUP BY day_name order by total_sales desc;
-- or 
SELECT month_name,COUNT(*) AS transaction_count,round(SUM(total),2) AS total_sales 
        FROM walmart GROUP BY month_name;

-- How do sales trends differ between customer types (member vs. normal)?
select customer_type,round(sum(total),2) total_revenue 
            from walmart group by customer_type;
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
Customer behavior analysis

-- Does customer type influence the choice of payment method?
 select 
  customer_type,payment,
        round(sum(total),2)total_revenue ,count(*) transection 
          from walmart group by customer_type,payment ;

-- Are there gender-specific preferences in product lines or shopping patterns?
 select
   gender, product_line ,count(*) most_gender 
   from walmart group by gender,product_line;

-- What are the peak shopping times across different cities or branches?
 select
       country,branch,time_of_day, count(*) tran 
         from walmart group by
   country,branch,time_of_day; 

-- How does the average transaction value vary between members and non-members?
select
  customer_type,country, branch,avg(total) avg_revenue  
      from walmart group by
          customer_type,country,branch;
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
Product and Inventory Analysis

-- Which product lines have the highest and lowest ratings, and does this affect sales?
-- (A) To find the product line with the highest sales:
SELECT 
    product_line, ROUND(SUM(total), 2) AS total_sales
FROM
    walmart
GROUP BY product_line
ORDER BY total_sales DESC
LIMIT 1;
-- (B) To find the product line with the lowest sales:
SELECT product_line, round(SUM(total),2) AS total_sales
FROM walmart
GROUP BY product_line
ORDER BY total_sales ASC
LIMIT 1;

-- Are there any product lines that perform significantly better in specific country or branches?
SELECT
  country,branch,product_line,round(AVG(total),2) AS average_sales,COUNT(*) AS total_transactions
FROM walmart
GROUP BY country, branch, product_line
ORDER BY average_sales DESC;

-- How does the product line preference vary by gender?
 select 
   product_line,gender,count(*) most_gender 
   from walmart group by
   product_line,gender order by most_gender desc;
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
Payment Method Analysis

-- What is the most preferred payment method across cities/branches, and why might that be?
   select 
  country,branch, payment ,count(*) most_transection 
            from walmart group by 
                country,branch,payment order by  
                    most_transection desc;

-- Is there a relationship between payment method and product line or purchase size?
select
        product_line,sum(quantity) purchase_size,
              count(payment) transection 
                    from walmart group by product_line;

Temporal Analysis

-- Identify sales trends over time — are there specific months or days with significantly higher sales?
  select
  branch,month_name,round(sum(total),2)revenue
  from walmart group by
  branch,month_name order by revenue;

-- How do shopping patterns vary during the weekend compared to weekdays?
select
  day_name,product_line,round(sum(total),2) revenue 
  from walmart group by
      day_name,product_line having day_name in
          ('sunday','saturday') order by revenue desc;
-- or 
select 
      day_name,product_line,round(sum(total),2) revenue 
        from walmart group by
            day_name,product_line 
                having not day_name in ('sunday','saturday');
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
Miscellaneous Analysis

-- 1. Are there specific product lines that attract more new (normal) customers than members?
SELECT
    product_line,
    customer_type,
    COUNT(*) AS total_customers
FROM
    walmart
WHERE
    customer_type IN ('normal', 'member')
GROUP BY
    product_line, customer_type;
    
   -- 2. How does the sales performance of gender-specific products vary across different country or branches?
SELECT
    product_line,
    customer_type,
    branch,
    country,
    SUM(total) AS total_sales
FROM walmart
GROUP BY
    product_line,
    customer_type,
    branch,
    country;

-- 3. Investigate the impact of different branches on the sales of specific product lines — are there any branches that underperform or outperform others consistently?
SELECT
    branch,
    product_line,
    round(AVG(total),2) AS avg_sales,
    round(MAX(total),2) AS max_sales,
    round(MIN(total),2) AS min_sales
FROM
    walmart
GROUP BY
    branch, product_line
ORDER BY
    branch, product_line;
