-- D1 corrected: report rep performance without inventing unavailable targets.
-- The source dataset has no approved target amounts. Target-related outputs remain NULL.
SELECT
    o.rep_name,
    COUNT(*) AS order_count,
    SUM(o.amount) AS recorded_sales,
    SUM(CASE WHEN o.status = 'completed' THEN 1 ELSE 0 END) AS completed_orders,
    SUM(CASE WHEN o.status = 'pending' THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN o.status = 'disputed' THEN 1 ELSE 0 END) AS disputed_orders,
    CAST(NULL AS NUMERIC(12,2)) AS target_amount,
    CAST(NULL AS NUMERIC(12,2)) AS variance_to_target,
    CAST(NULL AS NUMERIC(7,2)) AS target_attainment_pct
FROM orders AS o
GROUP BY o.rep_name
ORDER BY recorded_sales DESC, o.rep_name;
