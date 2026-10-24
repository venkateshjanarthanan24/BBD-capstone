-- SQL dialect: PostgreSQL
-- 11. Region and month report
SELECT order_month, region,
       COUNT(*) AS order_count,
       SUM(amount) AS recorded_sales,
       SUM(quantity) AS units_ordered
FROM orders
GROUP BY order_month, region
ORDER BY order_month, region;
