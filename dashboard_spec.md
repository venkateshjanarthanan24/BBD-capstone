# Dashboard specification

## Status
A standalone HTML dashboard was supplied as `sales_intelligence_dashboard(2).html` and used as the visual/functional reference. The required repository structure does not include the HTML itself, so this file documents its design. **Tableau Public build: No** (assumption based on the supplied artifact being standalone HTML; update if a Tableau Public workbook was also published).

## Audience and purpose
Give a sales manager a concise view of order status, recorded order value, product mix, regional results, month trend, customer spend bands, and representative summaries.

## Main views
1. KPI cards: recorded value, total orders, completed, pending, average recorded order value.
2. Monthly recorded sales trend for September–November 2026.
3. Order status counts and recorded amounts.
4. Regional sales ranking and month-by-month regional sales.
5. Product contribution ranking with tiers A (>=15%), B (>=5% and <15%), C (<5%).
6. Customer segments based on assumed recorded-spend thresholds: High >= ₹40,000; Medium ₹25,000–₹39,999.99; Low < ₹25,000.
7. Representative snapshot, with target attainment omitted because no targets exist.
8. Recent-orders detail is specified as a future view requiring order-level records; do not fabricate records.

## Filters and interactions
- Region, month, and status filters.
- Reset filters action.
- Export report to CSV.
- Navigation links to overview, orders, customers, products, regions, representatives, reports, and settings.

## Data and integrity rules
- Amount means recorded order value, not revenue margin or profit.
- NULL amounts remain missing and are excluded from SUM/AVG per SQL behavior.
- Source provides independent summary dimensions; do not imply that all charts cross-filter accurately unless built from the shared order-level fact table.
- Currency displayed as INR (₹).
- Show data-quality caveats for 3 missing amounts and absent targets.

## Three key findings
- Total recorded order value is ₹484,300 across 90 orders, with 3 missing amounts.
- Air Fryer is the leading product at ₹145,600 (30.06% of recorded value).
- North leads regions by recorded sales at ₹133,600; November is the strongest month at ₹200,500.
