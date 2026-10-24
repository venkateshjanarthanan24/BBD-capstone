-- Q13: representative performance snapshot.
-- The source has no target values, so actual target attainment cannot be calculated.
SELECT rep_name,
       COUNT(*) AS order_count,
       SUM(amount) AS recorded_sales,
       SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed_orders,
       SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) AS pending_orders,
       SUM(CASE WHEN status = 'disputed' THEN 1 ELSE 0 END) AS disputed_orders,
       CAST(NULL AS NUMERIC(12,2)) AS target_amount,
       CAST(NULL AS NUMERIC(12,2)) AS variance_to_target,
       CAST(NULL AS NUMERIC(7,2)) AS target_attainment_pct
FROM orders
GROUP BY rep_name
ORDER BY recorded_sales DESC, rep_name;
