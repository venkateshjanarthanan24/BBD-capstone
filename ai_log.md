# AI assistance log

## Assistance used
- AI assistance was used to organize the repository structure, draft documentation, split the supplied 13-query SQL script into separate query files, and create the PostgreSQL schema/seed script from the supplied 90-row CSV.
- AI assistance was used to draft dashboard documentation from the supplied standalone HTML and the provided query-results report.
- Data cleaning was limited to trimming and title-casing first/last names. The three missing amounts were preserved as missing.

## Human verification required
- Confirm the SQL dialect/compiler and spreadsheet application match the tools actually used; the README currently documents PostgreSQL and LibreOffice Calc as assumptions.
- Confirm whether a Tableau Public dashboard was built. The current README says no because no Tableau workbook or public link was supplied.
- Execute all SQL in the intended PostgreSQL environment and compare results with `results/query_results.md` before submission.
- Verify assignment-specific interpretation of `D1`; this corrected query reports representative performance while leaving target metrics NULL because the source contains no targets.
- Review the final public GitHub repository and ensure every file is committed on `main`.
