# Spreadsheet cleaning notes

## Tool
Spreadsheet workflow: LibreOffice Calc (declared project assumption; change this if another tool was actually used). The source CSV was also normalized reproducibly during packaging with Python/pandas; use the spreadsheet notes to document the manual review rather than implying unperformed spreadsheet actions.

## Cleaning decisions
- Loaded the source as CSV with blank `amount` values preserved as missing values.
- Trimmed leading/trailing whitespace from `first_name` and `last_name` and normalized them to title case in `data/orders_clean.csv`.
- Preserved `order_id`, `order_month`, region, representative, product, quantity, amount, and status values.
- Kept all 90 rows and all 10 source columns; verified order IDs are unique.
- Kept the three missing amounts as blank/NULL. Missing amounts are not converted to zero or imputed.
- Kept amount numeric and quantity integer; currency is interpreted as INR based on the dashboard/report context.

## Checks
- Rows: 90
- Distinct order IDs: 90
- Missing amounts: 3 (orders 1001, 1010, 1064)
- Status counts: completed 63, pending 19, disputed 8
- Total recorded amount excluding missing values: ₹484,300

## Limitations
The source has no sales targets, cost/margin, or profit fields. Target attainment and profitability cannot be derived. Customer segment thresholds and product contribution tiers are analytical assumptions documented in the results report.
