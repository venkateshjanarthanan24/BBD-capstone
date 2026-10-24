# SQL Order Analysis — Query Results

**Source:** `data/orders enriched.csv`  
**Rows:** 90 · **Columns:** 11 · **SQL script:** `sql/q01.sql–q13.sql`

## Notes and assumptions

- `amount` is treated as recorded order value; it is not profit.
- Three rows have `NULL` amounts. Sums and averages exclude those missing values.
- Customer names are normalized to title case for reporting; source data may have inconsistent capitalization.
- Customer segments are illustrative spend bands: **High ≥ ₹40,000**, **Medium ₹25,000–₹39,999.99**, **Low < ₹25,000**. These are not supplied business rules.
- Product contribution tiers use each product's share of all recorded amount: **A ≥ 15%**, **B ≥ 5% and < 15%**, **C < 5%**.
- The CSV has no rep target data. Actual target attainment cannot be calculated until target values are provided.

## 1. Pending orders

```sql
SELECT order_id, order_month, first_name, last_name, region, rep_name,
       item, quantity, amount, status
FROM orders
WHERE status = 'pending'
ORDER BY order_month, order_id;
```

Found **19 pending orders**.

| order_id | order_month | customer_name | region | item | amount |
| --- | --- | --- | --- | --- | --- |
| 1001 | 2026-09 | Meera Patil | South | Bluetooth Speaker | NULL |
| 1002 | 2026-09 | Nisha Mishra | West | Smart Watch | 4,500 |
| 1004 | 2026-09 | Gaurav Yadav | East | Cotton Kurta | 2,800 |
| 1010 | 2026-09 | Gaurav Yadav | East | Wireless Earbuds | NULL |
| 1033 | 2026-10 | Swati Banerjee | South | Denim Jacket | 2,500 |
| 1035 | 2026-10 | Vikram Singh | North | Bluetooth Speaker | 2,800 |
| 1036 | 2026-10 | Tanvi Thakur | South | Denim Jacket | 5,000 |
| 1037 | 2026-10 | Rahul Verma | East | Bedsheet Set | 3,800 |
| 1042 | 2026-10 | Lakshmi Kapoor | South | Table Lamp | 1,100 |
| 1044 | 2026-10 | Meera Patil | South | Running Shoes | 3,600 |
| 1052 | 2026-10 | Aditya Rao | East | Smart Watch | 13,500 |
| 1057 | 2026-11 | Sneha Das | West | Bluetooth Speaker | 2,800 |
| 1058 | 2026-11 | Suresh Bose | North | Bedsheet Set | 1,900 |
| 1063 | 2026-11 | Meera Patil | South | Air Fryer | 5,200 |
| 1064 | 2026-11 | Isha Pillai | West | Bluetooth Speaker | NULL |
| 1068 | 2026-11 | Harsh Chopra | East | Air Fryer | 5,200 |
| 1071 | 2026-11 | Tanvi Thakur | South | Air Fryer | 5,200 |
| 1075 | 2026-11 | Sneha Das | West | Running Shoes | 3,600 |
| 1078 | 2026-11 | Rahul Verma | East | Cotton Kurta | 1,400 |

## 2. Missing amounts

```sql
SELECT order_id, first_name, last_name, item, status
FROM orders
WHERE amount IS NULL;
```

Found **3 orders** with missing amounts.

| order_id | customer_name | item | status |
| --- | --- | --- | --- |
| 1001 | Meera Patil | Bluetooth Speaker | pending |
| 1010 | Gaurav Yadav | Wireless Earbuds | pending |
| 1064 | Isha Pillai | Bluetooth Speaker | pending |

## 3. Five biggest completed orders

```sql
SELECT order_id, order_month, first_name, last_name, item, amount
FROM orders
WHERE status = 'completed' AND amount IS NOT NULL
ORDER BY amount DESC, order_id
LIMIT 5;
```

| order_id | order_month | customer_name | item | amount |
| --- | --- | --- | --- | --- |
| 1061 | 2026-11 | Nisha Mishra | Air Fryer | 15,600 |
| 1065 | 2026-11 | Tanvi Thakur | Air Fryer | 15,600 |
| 1069 | 2026-11 | Aditya Rao | Air Fryer | 15,600 |
| 1077 | 2026-11 | Rahul Verma | Air Fryer | 15,600 |
| 1006 | 2026-09 | Vikram Singh | Smart Watch | 13,500 |

## 4. Target customer segments

Spend bands are assumed for this analysis, since no segment definitions were supplied.

```sql
WITH customer_totals AS (
  SELECT first_name, last_name, COUNT(*) AS order_count, SUM(amount) AS recorded_spend
  FROM orders
  GROUP BY first_name, last_name
)
SELECT *,
  CASE WHEN recorded_spend >= 40000 THEN 'High'
       WHEN recorded_spend >= 25000 THEN 'Medium'
       ELSE 'Low' END AS customer_segment
FROM customer_totals
ORDER BY recorded_spend DESC;
```

### Segment summary

| segment | customer_count | recorded_spend |
| --- | --- | --- |
| High | 2 | 87,200 |
| Medium | 7 | 245,100 |
| Low | 11 | 152,000 |

### Highest-spend customers

| customer_name | order_count | recorded_spend | segment |
| --- | --- | --- | --- |
| Vikram Singh | 8 | 46,800 | High |
| Tanvi Thakur | 7 | 40,400 | High |
| Lakshmi Kapoor | 6 | 39,500 | Medium |
| Manoj Desai | 6 | 39,100 | Medium |
| Aditya Rao | 4 | 38,600 | Medium |
| Isha Pillai | 6 | 38,500 | Medium |
| Nisha Mishra | 4 | 31,500 | Medium |
| Aarav Sharma | 4 | 30,200 | Medium |
| Rahul Verma | 6 | 27,700 | Medium |
| Sneha Das | 7 | 23,800 | Low |

## 5. Headline KPIs

| KPI | Result |
|---|---:|
| Orders | 90 |
| Unique customers | 20 |
| Units ordered | 150 |
| Recorded order value | ₹484,300.00 |
| Average recorded order value | ₹5,566.67 |
| Orders with recorded amount | ₹87.00 |
| Missing amounts | ₹3.00 |
| Completed orders | 63 |
| Pending orders | 19 |
| Disputed orders | 8 |
| Completed order value | ₹346,200.00 |
| Pending recorded value | ₹64,900.00 |
| Disputed recorded value | ₹73,200.00 |

## 6. Orders by status

```sql
SELECT status, COUNT(*) AS order_count, SUM(amount) AS recorded_amount
FROM orders
GROUP BY status
ORDER BY order_count DESC;
```

| status | order_count | recorded_amount | avg_recorded_amount |
| --- | --- | --- | --- |
| completed | 63 | 346,200 | 5,495.24 |
| pending | 19 | 64,900 | 4,056.25 |
| disputed | 8 | 73,200 | 9,150 |

## 7. Strong products

Ranked by recorded sales amount (not profit).

```sql
SELECT item, COUNT(*) AS order_count, SUM(quantity) AS units_sold,
       SUM(amount) AS recorded_sales
FROM orders
GROUP BY item
ORDER BY recorded_sales DESC;
```

| item | order_count | units_sold | recorded_sales | contribution_pct | tier |
| --- | --- | --- | --- | --- | --- |
| Air Fryer | 14 | 28 | 145,600 | 30.06 | A |
| Smart Watch | 12 | 21 | 94,500 | 19.51 | A |
| Wireless Earbuds | 15 | 27 | 83,200 | 17.18 | A |
| Running Shoes | 11 | 17 | 61,200 | 12.64 | B |
| Denim Jacket | 6 | 12 | 30,000 | 6.19 | B |
| Cotton Kurta | 9 | 15 | 21,000 | 4.34 | C |
| Bluetooth Speaker | 8 | 10 | 19,600 | 4.05 | C |
| Bedsheet Set | 7 | 9 | 17,100 | 3.53 | C |
| Table Lamp | 8 | 11 | 12,100 | 2.5 | C |

**Top product:** Air Fryer, with recorded sales of ₹145,600 (30.1% of all recorded amount).

## 8. Customer profile by region

```sql
SELECT region, COUNT(*) AS order_count,
       COUNT(DISTINCT CONCAT(first_name, ' ', last_name)) AS unique_customers,
       SUM(quantity) AS units_ordered, SUM(amount) AS recorded_sales
FROM orders
GROUP BY region
ORDER BY recorded_sales DESC;
```

| region | order_count | unique_customers | units_ordered | recorded_sales | avg_recorded_order_value | completed | pending | disputed |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| North | 22 | 5 | 37 | 133,600 | 6,072.73 | 19 | 2 | 1 |
| West | 23 | 5 | 39 | 119,200 | 5,418.18 | 15 | 4 | 4 |
| East | 20 | 5 | 38 | 116,000 | 6,105.26 | 12 | 6 | 2 |
| South | 25 | 5 | 36 | 115,500 | 4,812.5 | 17 | 7 | 1 |

## 9. Order-level fact table

One row per order, at the grain of `order_id`. This query returns all **90** orders.

```sql
SELECT order_id, order_month,
       TRIM(CONCAT(first_name, ' ', last_name)) AS customer_name,
       region, rep_name, item, quantity, amount, status
FROM orders
ORDER BY order_id;
```

Sample first 10 rows:

| order_id | order_month | customer_name | region | rep_name | item | quantity | amount | status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1001 | 2026-09 | Meera Patil | South | Kavya Nair | Bluetooth Speaker | 2 | NULL | pending |
| 1002 | 2026-09 | Nisha Mishra | West | Neha Kulkarni | Smart Watch | 1 | 4,500 | pending |
| 1003 | 2026-09 | Lakshmi Kapoor | South | Kavya Nair | Air Fryer | 2 | 10,400 | disputed |
| 1004 | 2026-09 | Gaurav Yadav | East | Sanjay Roy | Cotton Kurta | 2 | 2,800 | pending |
| 1005 | 2026-09 | Tanvi Thakur | South | Kavya Nair | Table Lamp | 1 | 1,100 | completed |
| 1006 | 2026-09 | Vikram Singh | North | Arjun Mehta | Smart Watch | 3 | 13,500 | completed |
| 1007 | 2026-09 | Tanvi Thakur | South | Kavya Nair | Bedsheet Set | 1 | 1,900 | completed |
| 1008 | 2026-09 | Sneha Das | West | Neha Kulkarni | Wireless Earbuds | 2 | 6,400 | completed |
| 1009 | 2026-09 | Rahul Verma | East | Sanjay Roy | Bedsheet Set | 1 | 1,900 | completed |
| 1010 | 2026-09 | Gaurav Yadav | East | Sanjay Roy | Wireless Earbuds | 1 | NULL | pending |

## 10. Customer-level order summary

```sql
SELECT first_name, last_name, COUNT(*) AS order_count,
       SUM(quantity) AS units_ordered, SUM(amount) AS recorded_spend
FROM orders
GROUP BY first_name, last_name
ORDER BY order_count DESC, recorded_spend DESC;
```

Top customers by number of orders (ties sorted by recorded spend):

| customer_name | order_count | units_ordered | recorded_spend | completed_orders |
| --- | --- | --- | --- | --- |
| Vikram Singh | 8 | 13 | 46,800 | 7 |
| Tanvi Thakur | 7 | 11 | 40,400 | 5 |
| Sneha Das | 7 | 9 | 23,800 | 5 |
| Lakshmi Kapoor | 6 | 10 | 39,500 | 4 |
| Manoj Desai | 6 | 11 | 39,100 | 6 |
| Isha Pillai | 6 | 12 | 38,500 | 2 |
| Rahul Verma | 6 | 11 | 27,700 | 4 |
| Meera Patil | 5 | 7 | 12,100 | 2 |
| Aditya Rao | 4 | 9 | 38,600 | 3 |
| Nisha Mishra | 4 | 9 | 31,500 | 3 |

**Most frequent customer:** Vikram Singh, with 8 orders.

## 11. Region and month report

```sql
SELECT order_month, region, COUNT(*) AS order_count,
       SUM(amount) AS recorded_sales, SUM(quantity) AS units_ordered
FROM orders
GROUP BY order_month, region
ORDER BY order_month, region;
```

| order_month | region | order_count | recorded_sales | units_ordered |
| --- | --- | --- | --- | --- |
| 2026-09 | East | 5 | 18,200 | 7 |
| 2026-09 | North | 8 | 53,500 | 14 |
| 2026-09 | South | 7 | 30,200 | 11 |
| 2026-09 | West | 6 | 38,700 | 11 |
| 2026-10 | East | 6 | 29,500 | 13 |
| 2026-10 | North | 7 | 44,100 | 12 |
| 2026-10 | South | 9 | 31,200 | 11 |
| 2026-10 | West | 8 | 38,400 | 15 |
| 2026-11 | East | 9 | 68,300 | 18 |
| 2026-11 | North | 7 | 36,000 | 11 |
| 2026-11 | South | 9 | 54,100 | 14 |
| 2026-11 | West | 9 | 42,100 | 13 |

### Recorded sales by month and region (₹)

| order_month | East | North | South | West |
| --- | --- | --- | --- | --- |
| 2026-09 | 18,200 | 53,500 | 30,200 | 38,700 |
| 2026-10 | 29,500 | 44,100 | 31,200 | 38,400 |
| 2026-11 | 68,300 | 36,000 | 54,100 | 42,100 |

## 12. Product contribution tiers

ABC-style bands below are based on sales contribution share, not cumulative ABC analysis.

```sql
WITH product_sales AS (
  SELECT item, SUM(amount) AS recorded_sales
  FROM orders GROUP BY item
),
product_shares AS (
  SELECT *, 100.0 * recorded_sales / SUM(recorded_sales) OVER () AS contribution_pct
  FROM product_sales
)
SELECT *,
  CASE WHEN contribution_pct >= 15 THEN 'A'
       WHEN contribution_pct >= 5 THEN 'B'
       ELSE 'C' END AS contribution_tier
FROM product_shares
ORDER BY recorded_sales DESC;
```

| item | recorded_sales | contribution_pct | tier |
| --- | --- | --- | --- |
| Air Fryer | 145,600 | 30.06 | A |
| Smart Watch | 94,500 | 19.51 | A |
| Wireless Earbuds | 83,200 | 17.18 | A |
| Running Shoes | 61,200 | 12.64 | B |
| Denim Jacket | 30,000 | 6.19 | B |
| Cotton Kurta | 21,000 | 4.34 | C |
| Bluetooth Speaker | 19,600 | 4.05 | C |
| Bedsheet Set | 17,100 | 3.53 | C |
| Table Lamp | 12,100 | 2.5 | C |

## 13. Rep performance against target

The source contains rep names and order amounts, but **no sales targets**. Actual attainment and variance are therefore unavailable. Current recorded sales by rep are:

| rep_name | order_count | recorded_sales | completed_orders | pending_orders | disputed_orders |
| --- | --- | --- | --- | --- | --- |
| Arjun Mehta | 22 | 133,600 | 19 | 2 | 1 |
| Neha Kulkarni | 23 | 119,200 | 15 | 4 | 4 |
| Sanjay Roy | 20 | 116,000 | 12 | 6 | 2 |
| Kavya Nair | 25 | 115,500 | 17 | 7 | 1 |

Use a separate table once targets are provided:

```sql
-- Example structure only; insert real approved targets before reporting.
CREATE TABLE rep_targets (
  rep_name VARCHAR(100) PRIMARY KEY,
  target_amount DECIMAL(12,2)
);

SELECT o.rep_name, SUM(o.amount) AS recorded_sales,
       t.target_amount,
       SUM(o.amount) - t.target_amount AS variance_to_target,
       100.0 * SUM(o.amount) / NULLIF(t.target_amount, 0) AS target_attainment_pct
FROM orders o
LEFT JOIN rep_targets t ON t.rep_name = o.rep_name
GROUP BY o.rep_name, t.target_amount;
```

Do not populate `rep_targets` with invented numbers; provide the actual target amounts first.

## Data quality checks

- Row count: **90**
- Distinct order IDs: **90**
- Duplicate order IDs: **0**
- Missing amounts: **3**
- Status counts: completed=63, pending=19, disputed=8
- Total recorded amount: **₹484,300**

## How to run

1. Import `data/orders enriched.csv` into your SQL database as a table named `orders`.
2. Run the relevant query from `sql/q01.sql–q13.sql`.
3. Compare results with this report. SQL dialects differ in functions such as `CONCAT`, `LIMIT`, and window-function support.
