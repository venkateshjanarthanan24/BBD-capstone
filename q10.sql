-- SQL dialect: PostgreSQL
-- 10. Customer-level order summary (including most frequent customers)
SELECT first_name, last_name,
       COUNT(*) AS order_count,
       SUM(quantity) AS units_ordered,
       SUM(amount) AS recorded_spend,
       AVG(amount) AS average_recorded_order_value,
       SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed_orders
FROM orders
GROUP BY first_name, last_name
ORDER BY order_count DESC, recorded_spend DESC;
