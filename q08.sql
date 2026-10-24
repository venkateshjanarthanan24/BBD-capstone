-- SQL dialect: PostgreSQL
-- 8. Customer profile by region
SELECT region,
       COUNT(*) AS order_count,
       COUNT(DISTINCT CONCAT(first_name, ' ', last_name)) AS unique_customers,
       SUM(quantity) AS units_ordered,
       SUM(amount) AS recorded_sales,
       AVG(amount) AS average_recorded_order_value,
       SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed_orders,
       SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) AS pending_orders,
       SUM(CASE WHEN status = 'disputed' THEN 1 ELSE 0 END) AS disputed_orders
FROM orders
GROUP BY region
ORDER BY recorded_sales DESC;
