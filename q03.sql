-- SQL dialect: PostgreSQL
-- 3. Five biggest completed orders
SELECT order_id, order_month, first_name, last_name, region, rep_name,
       item, quantity, amount
FROM orders
WHERE status = 'completed' AND amount IS NOT NULL
ORDER BY amount DESC, order_id
LIMIT 5;
