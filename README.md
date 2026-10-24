# Sales Intelligence: SQL Orders Analysis and Dashboard

## Tools
- **SQL compiler / database dialect:** PostgreSQL (queries use PostgreSQL-compatible SQL; execute in PostgreSQL/psql or a compatible SQL editor).
- **Spreadsheet tool:** LibreOffice Calc is the documented spreadsheet workflow assumption; cleaning was also reproduced with Python/pandas when packaging the deliverables. If you used another spreadsheet tool, replace this statement with the tool actually used.
- **Tableau Public dashboard:** No. The provided dashboard artifact is standalone HTML; `docs/dashboard_spec.md` records its design. If you built and published a Tableau Public dashboard, update this answer and add the public workbook URL.

## Summary and key findings
The dataset contains 90 orders from September through November 2026, 20 customers, and 150 units ordered. Recorded order value is ₹484,300, excluding three missing amounts; this is recorded order value and must not be interpreted as profit. The three most important findings are: (1) Air Fryer is the top product at ₹145,600, contributing 30.06% of recorded sales; Smart Watch and Wireless Earbuds contribute another 19.51% and 17.18%, respectively. (2) November is the strongest month at ₹200,500, compared with ₹140,600 in September and ₹143,200 in October. (3) North has the highest regional recorded sales at ₹133,600, while 19 orders remain pending and 8 are disputed. Three pending orders have missing amounts; resolve those records before using the figures for financial reconciliation. No rep targets or cost data were supplied, so target attainment and profit cannot be calculated.

## Assumptions
- `amount` represents recorded order value, not profit or margin; missing values remain NULL/blank and are not converted to zero.
- Customer segments are assumed: High >= ₹40,000; Medium ₹25,000–₹39,999.99; Low < ₹25,000.
- Product contribution tiers are based on each product's share of total recorded amount: A >= 15%; B >= 5% and < 15%; C < 5%. These are contribution bands, not cumulative ABC analysis.
- Currency is INR, inferred from the supplied dashboard/report context.
- Spreadsheet tool and Tableau Public status above are assumptions to confirm against the tools you actually used.

## File index (required repository files)
| File | Part / purpose |
|---|---|
| `README.md` | Submission overview, tools, findings, assumptions, and file index |
| `sql/00_schema_and_seed.sql` | SQL setup: PostgreSQL schema and all 90 seed rows |
| `sql/q01.sql` | Part: Q01 — pending orders |
| `sql/q02.sql` | Part: Q02 — missing amounts |
| `sql/q03.sql` | Part: Q03 — five largest completed orders |
| `sql/q04.sql` | Part: Q04 — customer spend segments |
| `sql/q05.sql` | Part: Q05 — headline KPIs |
| `sql/q06.sql` | Part: Q06 — orders and recorded value by status |
| `sql/q07.sql` | Part: Q07 — product performance |
| `sql/q08.sql` | Part: Q08 — regional customer/order profile |
| `sql/q09.sql` | Part: Q09 — order-level fact table |
| `sql/q10.sql` | Part: Q10 — customer-level order summary |
| `sql/q11.sql` | Part: Q11 — region-by-month report |
| `sql/q12.sql` | Part: Q12 — product contribution tiers |
| `sql/q13.sql` | Part: Q13 — representative performance; target data limitation documented |
| `sql/d1_corrected.sql` | Part: D1 — corrected representative query that does not invent targets |
| `results/query_results.md` | Query outputs, interpretations, assumptions, and data-quality checks |
| `data/orders enriched.csv` | Enriched dataset with normalized customer name field |
| `data/orders_clean.csv` | Cleaned dataset with trimmed/title-cased customer names and missing amounts preserved |
| `docs/spreadsheet_notes.md` | Spreadsheet cleaning process and validation notes |
| `docs/dashboard_spec.md` | Dashboard design, filters, integrity rules, and findings |
| `docs/ai_log.md` | AI assistance disclosure and verification notes |

## Run the SQL
1. Create a PostgreSQL database and run `sql/00_schema_and_seed.sql`.
2. Run `sql/q01.sql` through `sql/q13.sql` individually.
3. Run `sql/d1_corrected.sql` for representative performance without target assumptions.
4. Compare output with `results/query_results.md`. `NULL` amount values are expected.
