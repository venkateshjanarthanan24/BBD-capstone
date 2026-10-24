-- SQL dialect: PostgreSQL
-- 1. Pending orders
SELECT order_id, order_month, first_name, last_name, region, rep_name,
       item, quantity, amount, status
FROM orders
WHERE status = 'pending'
ORDER BY order_month, order_id;
