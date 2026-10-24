-- SQL dialect: PostgreSQL
-- 12. Product contribution tiers (ABC-style, based on recorded sales share)
-- A >= 15%, B >= 5% and < 15%, C < 5%.
WITH product_sales AS (
    SELECT item, SUM(amount) AS recorded_sales, COUNT(*) AS order_count,
           SUM(quantity) AS units_sold
    FROM orders
    GROUP BY item
),
product_shares AS (
    SELECT *, 100.0 * recorded_sales /
           NULLIF(SUM(recorded_sales) OVER (), 0) AS contribution_pct
    FROM product_sales
)
SELECT item, order_count, units_sold, recorded_sales, contribution_pct,
       CASE
         WHEN contribution_pct >= 15 THEN 'A'
         WHEN contribution_pct >= 5 THEN 'B'
         ELSE 'C'
       END AS contribution_tier
FROM product_shares
ORDER BY recorded_sales DESC;
