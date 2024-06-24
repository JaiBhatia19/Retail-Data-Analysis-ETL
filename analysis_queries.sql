-- Verify that the df_orders table is created
SELECT * FROM df_orders;

-- Drop table because we used 'replace' instead of 'append' while loading data in PostgreSQL. 
-- 'replace' cause pgadmin to include max possible data types
drop table df_orders;

-- Recreate table with correct datatypes
CREATE TABLE df_orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    ship_mode VARCHAR(20),
    segment VARCHAR(20),
    country VARCHAR(20),
    city VARCHAR(20),
    state VARCHAR(20),
    postal_code VARCHAR(20),
    region VARCHAR(20),
    category VARCHAR(20),
    sub_category VARCHAR(20),
    product_id VARCHAR(50),
    quantity INT,
    discount DECIMAL(7,2),
    sale_price DECIMAL(7,2),
    profit DECIMAL(7,2)
);

-- Use 'append' and load data to table using notebook
-- Verify if data has been loaded
SELECT * FROM df_orders;

-- Let us trends some questions that a retail business executive might want to analyze using the table

-- Find the top 10 products by profit
SELECT product_id, ROUND(CAST(SUM(profit) AS numeric), 2) AS total_profit
FROM df_orders
GROUP BY product_id
ORDER BY total_profit DESC
LIMIT 10;

-- Analyze sales performance by region and ship mode
WITH regional_sales AS (
    SELECT region, ship_mode, ROUND(CAST(SUM(sale_price) AS numeric), 2) AS total_sales
    FROM df_orders
    GROUP BY region, ship_mode
)
SELECT region, ship_mode, total_sales
FROM regional_sales
ORDER BY region, total_sales DESC;

-- Year-over-year sales growth by category
WITH yearly_sales AS (
    SELECT category, EXTRACT(YEAR FROM order_date) AS order_year, ROUND(CAST(SUM(sale_price) AS numeric), 2) AS total_sales
    FROM df_orders
    GROUP BY category, EXTRACT(YEAR FROM order_date)
)
SELECT category, 
       ROUND(SUM(CASE WHEN order_year = 2022 THEN total_sales ELSE 0 END), 2) AS sales_2022,
       ROUND(SUM(CASE WHEN order_year = 2023 THEN total_sales ELSE 0 END), 2) AS sales_2023,
       ROUND(SUM(CASE WHEN order_year = 2023 THEN total_sales ELSE 0 END) - SUM(CASE WHEN order_year = 2022 THEN total_sales ELSE 0 END), 2) AS sales_growth
FROM yearly_sales
GROUP BY category
ORDER BY sales_growth DESC;

-- Monthly sales trend by segment
WITH monthly_sales AS (
    SELECT segment, TO_CHAR(order_date, 'YYYY-MM') AS order_month, ROUND(CAST(SUM(sale_price) AS numeric), 2) AS total_sales
    FROM df_orders
    GROUP BY segment, TO_CHAR(order_date, 'YYYY-MM')
)
SELECT segment, order_month, total_sales
FROM monthly_sales
ORDER BY segment, order_month;

-- Identify the most profitable categories and their trends
WITH category_profit AS (
    SELECT category, EXTRACT(YEAR FROM order_date) AS order_year, ROUND(CAST(SUM(profit) AS numeric), 2) AS total_profit
    FROM df_orders
    GROUP BY category, EXTRACT(YEAR FROM order_date)
)
SELECT category,
       ROUND(SUM(CASE WHEN order_year = 2022 THEN total_profit ELSE 0 END), 2) AS profit_2022,
       ROUND(SUM(CASE WHEN order_year = 2023 THEN total_profit ELSE 0 END), 2) AS profit_2023,
       ROUND(SUM(CASE WHEN order_year = 2023 THEN total_profit ELSE 0 END) - SUM(CASE WHEN order_year = 2022 THEN total_profit ELSE 0 END), 2) AS profit_growth
FROM category_profit
GROUP BY category
ORDER BY profit_growth DESC;

-- Monthly profit analysis by country
WITH monthly_profit AS (
    SELECT country, TO_CHAR(order_date, 'YYYY-MM') AS order_month, ROUND(CAST(SUM(profit) AS numeric), 2) AS total_profit
    FROM df_orders
    GROUP BY country, TO_CHAR(order_date, 'YYYY-MM')
)
SELECT country, order_month, total_profit
FROM monthly_profit
ORDER BY country, order_month;

-- Monthly profit analysis by country
WITH monthly_profit AS (
    SELECT country, TO_CHAR(order_date, 'YYYY-MM') AS order_month, ROUND(CAST(SUM(profit) AS numeric), 2) AS total_profit
    FROM df_orders
    GROUP BY country, TO_CHAR(order_date, 'YYYY-MM')
)
SELECT country, order_month, total_profit
FROM monthly_profit
ORDER BY country, order_month;

-- Comparison of discounts given across different categories
SELECT category, ROUND(CAST(AVG(discount) AS numeric), 2) AS avg_discount
FROM df_orders
GROUP BY category
ORDER BY avg_discount DESC;

-- Top 5 cities by total sales
SELECT city, ROUND(CAST(SUM(sale_price) AS numeric), 2) AS total_sales
FROM df_orders
GROUP BY city
ORDER BY total_sales DESC
LIMIT 5;

-- Product sales analysis by segment and category
WITH product_sales AS (
    SELECT segment, category, product_id, ROUND(CAST(SUM(sale_price) AS numeric), 2) AS total_sales
    FROM df_orders
    GROUP BY segment, category, product_id
)
SELECT segment, category, product_id, total_sales
FROM product_sales
ORDER BY segment, category, total_sales DESC;

-- Seasonal analysis: sales comparison between Q1 and Q2
WITH seasonal_sales AS (
    SELECT product_id, 
           ROUND(CAST(SUM(CASE WHEN EXTRACT(QUARTER FROM order_date) = 1 THEN sale_price ELSE 0 END) AS numeric), 2) AS Q1_sales,
           ROUND(CAST(SUM(CASE WHEN EXTRACT(QUARTER FROM order_date) = 2 THEN sale_price ELSE 0 END) AS numeric), 2) AS Q2_sales
    FROM df_orders
    GROUP BY product_id
)
SELECT product_id, Q1_sales, Q2_sales, ROUND((Q2_sales - Q1_sales), 2) AS sales_difference
FROM seasonal_sales
ORDER BY sales_difference DESC;


