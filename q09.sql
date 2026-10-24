-- SQL dialect: PostgreSQL
-- 9. Order-level fact table (one row per order)
-- This query keeps the original order grain and normalizes customer name display.
SELECT order_id, order_month,
       TRIM(CONCAT(first_name, ' ', last_name)) AS customer_name,
       region, rep_name, item, quantity, amount, status
FROM orders
ORDER BY order_id;
