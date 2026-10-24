-- SQL dialect: PostgreSQL
-- 5. Headline KPIs
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT CONCAT(first_name, ' ', last_name)) AS unique_customers,
    SUM(quantity) AS total_units,
    SUM(amount) AS recorded_order_value,
    AVG(amount) AS average_recorded_order_value,
    SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed_orders,
    SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN status = 'disputed' THEN 1 ELSE 0 END) AS disputed_orders,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS missing_amount_orders
FROM orders;
