# Walmart-Data-analysis

## About
This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized. The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition.

In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact.

## Purposes Of The Project
The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.
> I led a comprehensive data analysis project leveraging SQL within the retail sector, specifically focusing on a Walmart dataset.
> This initiative involved exploring various aspects of the business, ranging from product performance to customer behavior and payment methods. 
> Key insights were derived to inform strategic decision-making and optimize operational efficiency.
## About Data
The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition. This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| branch                  | Branch at which sales were made         | VARCHAR(5)     |
| city                    | The location of the branch              | VARCHAR(30)    |
| customer_type           | The type of the customer                | VARCHAR(30)    |
| gender                  | Gender of the customer making purchase  | VARCHAR(10)    |
| product_line            | Product line of the product solf        | VARCHAR(100)   |
| unit_price              | The price of each product               | DECIMAL(10, 2) |
| quantity                | The amount of the product sold          | INT            |
| VAT                 | The amount of tax on the purchase       | FLOAT(6, 4)    |
| total                   | The total cost of the purchase          | DECIMAL(10, 2) |
| date                    | The date on which the purchase was made | DATE           |
| time                    | The time at which the purchase was made | TIMESTAMP      |
| payment_method                 | The total amount paid                   | DECIMAL(10, 2) |
| cogs                    | Cost Of Goods sold                      | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(10, 2) |
| rating                  | Rating                                  | FLOAT(2, 1)    |



### Analysis List
1. Product Analysis

> Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

2. Sales Analysis

> This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

3. Customer Analysis

> This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.

## Approach Used

1. **Data Wrangling:** This is the first step where inspection of data is done to make sure **NULL** values and missing values are detected and data replacement methods are used to replace, missing or **NULL** values.

> 1. Build a database
> 2. Create table and insert the data.
> 3. Select columns with null values in them. There are no null values in our database as in creating the tables, we set **NOT NULL** for each field, hence null values are filtered out.

2. **Feature Engineering:** This will help use generate some new columns from existing ones.

> 1. Add a new column named `time_of_day` to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.

> 2. Add a new column named `day_name` that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.

> 3. Add a new column named `month_name` that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

2. **Exploratory Data Analysis (EDA):** Exploratory data analysis is done to answer the listed questions and aims of this project.

3. **Conclusion:**

## Business Questions To Answer

#### Each question aims to delve into different aspects of sales performance, customer behavior, product popularity, and operational efficiency, providing a comprehensive view of the business dynamics within Walmart's dataset.

#### Sales and Revenue Analysis

1. What are the top-performing product lines in terms of revenue and quantity sold?
2. How does sales performance vary between different branches?
3. Which country contributes the most to our revenue, and what are the popular product lines in that city?
4. Is there a correlation between the day of the week/month and sales performance?
5. How do sales trends differ between customer types (member vs. normal)?

#### Customer Behavior Analysis

1. Does customer type influence the choice of payment method?
2. Are there gender-specific preferences in product lines or shopping patterns?
3. What are the peak shopping times across different country or branches?
4. How does the average transaction value vary between members and non-members?

#### Product and Inventory Analysis

1. Which product lines have the highest and lowest ratings, and does this affect sales?
2. Are there any product lines that perform significantly better in specific country or branches?
3. How does the product line preference vary by gender?

#### Payment Method Analysis

1. What is the most preferred payment method across country/branches, and why might that be?
2. Is there a relationship between payment method and product line or purchase size?

#### Temporal Analysis

1. Identify sales trends over time — are there specific months or days with significantly higher sales?
2. How do shopping patterns vary during the weekend compared to weekdays?

#### Miscellaneous Analysis

1. Are there specific product lines that attract more new (normal) customers than members?
2. How does the sales performance of gender-specific products vary across different country or branches?
3. Investigate the impact of different branches on the sales of specific product lines — are there any branches that underperform or outperform others 
   consistently?
   
## Code

```sql
-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    Country VARCHAR(30) NOT NULL,
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
```
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- For Dashboard,simply check this link.
https://public.tableau.com/views/walmartanalysis_17084409541240/Dashboard1?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
