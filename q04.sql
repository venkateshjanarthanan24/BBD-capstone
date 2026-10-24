-- SQL dialect: PostgreSQL
-- 4. Customer segments by total recorded spend
-- Assumed segmentation thresholds: High >= 40000; Medium >= 25000; Low < 25000.
WITH customer_totals AS (
    SELECT first_name, last_name,
           COUNT(*) AS order_count,
           SUM(quantity) AS units_ordered,
           SUM(amount) AS recorded_spend
    FROM orders
    GROUP BY first_name, last_name
)
SELECT first_name, last_name, order_count, units_ordered, recorded_spend,
       CASE
         WHEN recorded_spend >= 40000 THEN 'High'
         WHEN recorded_spend >= 25000 THEN 'Medium'
         ELSE 'Low'
       END AS customer_segment
FROM customer_totals
ORDER BY recorded_spend DESC;
