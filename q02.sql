-- SQL dialect: PostgreSQL
-- 2. Orders with missing amount
SELECT order_id, order_month, first_name, last_name, region, rep_name,
       item, quantity, status
FROM orders
WHERE amount IS NULL
ORDER BY order_id;
