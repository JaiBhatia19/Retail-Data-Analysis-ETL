# Retail Data ETL and Analysis Project

## Project Overview
End-to-end ETL process for retail order data, including data extraction from Kaggle, transformation and loading into PostgreSQL, and SQL-based analysis to derive business insights.

## Tools and Technologies
- Python
- PostgreSQL
- pgAdmin

## Dataset
The dataset used for this project can be found here:
- [Retail Orders on Kaggle](https://www.kaggle.com/datasets/ankitbansal06/retail-orders)

## ETL Process
The ETL process is performed in the following Jupyter Notebook:
- [etl_process.ipynb](etl_process.ipynb)

### ETL Steps:
1. **Data Extraction**: Downloading the dataset from Kaggle.
2. **Data Transformation**: Cleaning, renaming columns, deriving new columns (discount, sale_price, profit), and converting data types.
3. **Data Loading**: Uploading the transformed data to a PostgreSQL database.

### Configuration
A `config.ini` file is needed with parameters for database/server credentials:
[postgresql]
user = username
password = password
host = localhost
port = 5432 (or what your db port is)
database = dbname


## SQL Analysis
The SQL queries used for analysis can be found here:
- [analysis_queries.sql](analysis_queries.sql)

### Business Questions Addressed:
1. **Top 10 Products by Profit**: Identifying the most profitable products.
2. **Sales Performance by Region and Ship Mode**: Analyzing how sales vary across regions and shipping methods.
3. **Year-over-Year Sales Growth by Category**: Comparing sales growth across different categories over the years.
4. **Monthly Sales Trend by Segment**: Tracking sales trends for different customer segments.
5. **Most Profitable Categories and Their Trends**: Identifying which categories generate the most profit and how they trend over time.
6. **Monthly Profit Analysis by Country**: Examining profit trends on a monthly basis for different countries.
7. **Comparison of Discounts Across Categories**: Understanding how discounts vary across different product categories.
8. **Top 5 Cities by Total Sales**: Finding the cities with the highest sales.
9. **Product Sales Analysis by Segment and Category**: Analyzing sales performance for different products across segments and categories.
10. **Seasonal Sales Comparison**: Comparing sales between the first and second quarters.

## Instructions
1. Clone the repository.
2. Ensure the `config.ini` file is correctly set up with your PostgreSQL credentials.
3. Run the ETL process notebook to load data into PostgreSQL.
4. Use pgAdmin to connect to the PostgreSQL database and execute the SQL queries.
