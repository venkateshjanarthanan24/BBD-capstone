-- SQL dialect: PostgreSQL
-- 7. Strong products: ranked by recorded sales amount
SELECT item, COUNT(*) AS order_count, SUM(quantity) AS units_sold,
       SUM(amount) AS recorded_sales,
       100.0 * SUM(amount) / NULLIF((SELECT SUM(amount) FROM orders), 0) AS sales_share_pct
FROM orders
GROUP BY item
ORDER BY recorded_sales DESC;
