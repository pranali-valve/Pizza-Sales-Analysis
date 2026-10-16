
--Create table pizza_sales
create table pizza_sales(
pizza_id INT,
order_id INT,
pizza_name_id varchar(100),
quantity INT,
order_date date,
order_time time,
unit_price float,
total_price float,
pizza_size varchar(50),
pizza_category varchar(50),
pizza_ingredients varchar(500),
pizza_name varchar(500)
);

--View table data
select * from pizza_sales;


--Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;


--Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales


--Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales


--Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales


-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales


--Daily Trend for Total Orders
SELECT
    TO_CHAR(order_date, 'FMDay') AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'FMDay');


--Hourly Trend for Orders
SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)


-- % of Sales by Pizza Category
SELECT
    EXTRACT(HOUR FROM order_time) AS order_hours,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY EXTRACT(HOUR FROM order_time);


--% of Sales by Pizza Size
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category


--Total Pizzas Sold by Pizza Category
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size


--Top 5 Best Sellers by Total Pizzas Sold
SELECT
    pizza_category,
    SUM(quantity) AS total_quantity_sold
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 2
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC;


--Bottom 5 Best Sellers by Total Pizzas Sold
SELECT
    pizza_name,
    SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizza_sold DESC
LIMIT 5;

SELECT
    pizza_name,
    SUM(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_name
LIMIT 5;

select * from pizza_sales;