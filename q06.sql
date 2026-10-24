-- SQL dialect: PostgreSQL
-- 6. Orders and recorded value by status
SELECT status, COUNT(*) AS order_count,
       SUM(amount) AS recorded_amount,
       AVG(amount) AS average_recorded_amount
FROM orders
GROUP BY status
ORDER BY order_count DESC;
