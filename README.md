# sql-revenue-analysis

# Revenue, Profitability, and Customer Analysis (PostgreSQL)

This project analyzes transactional sales data to evaluate revenue performance, gross profitability, and customer behavior using SQL in PostgreSQL.

## Dataset Overview

The dataset simulates an e-commerce business and includes:

- Customers (region, signup date)
- Orders (date, payment method, status)
- Order line items (price, quantity, discounts)
- Products and product categories
- Unit-level product costs

All analysis excludes cancelled and returned orders to reflect recognized revenue.

## Key Analyses

### Revenue Analysis
- Total revenue from successful orders
- Revenue by product category
- Monthly revenue trends

### Profit & Margin Analysis
- Total gross profit
- Gross profit by product category
- Gross margin percentage by category
- Top 10 most profitable products

### Customer Analysis
- Top customers by total revenue
- Revenue by customer region
- Most frequent customers by order count

## Skills Demonstrated

- Advanced SQL (PostgreSQL)
- Multi-table joins and aggregations
- Financial metrics (revenue, gross profit, margin %)
- Time-series analysis
- Customer segmentation and ranking
- Data modeling with fact and dimension tables
- Git/GitHub version control

## Tools & Technologies

- PostgreSQL
- SQL
- VS Code
- Git & GitHub

## Business Use Case

This analysis supports financial reporting, profitability analysis, and customer insights that could inform pricing strategy, product mix optimization, and customer retention efforts.

## Challenges & What I Learned

**Setting up PostgreSQL in VS Code:**  
At the start, I struggled getting PostgreSQL to connect properly through VS Code. I kept ending up in the PostgreSQL extension panel instead of the actual project folder, which led to confusion when VS Code tried creating database schemas instead of SQL files. Once I understood the difference between the two panels, everything clicked.

**Importing CSV files on Windows:**  
Loading the CSV data was more challenging than I expected. PostgreSQL kept throwing “permission denied” errors, and it took me a while to figure out that Windows was blocking the service account from accessing the folder. Giving the correct folder permissions to the `NETWORK SERVICE` (or the Postgres user) ended up being the fix.

**Building a clean folder structure and Git workflow:**  
I’m still new to GitHub, so learning to clone the repo, create files in the right place, stage changes, and commit logically was a big part of this project. I now understand how to keep a project organized and how to avoid committing temporary or misplaced files.

**Understanding fact vs. dimension tables:**  
Partway through the project, I realized that `order_items` functions as the core fact table in this dataset. Even though I didn’t go back and refactor every query, recognizing this structure helped me understand why certain joins work the way they do and how financial and BI data models are typically organized. It made the later parts of the analysis much clearer and helped me think more intentionally about data modeling.

## Setup Guide (If You Want To Reproduce This Project)

1. Install PostgreSQL and optionally pgAdmin.
2. Clone this repository into VS Code.
3. Create a new database named `revenue_analysis` in PostgreSQL.
4. Open `queries/schema.sql` and run it to create all tables and enums.
5. Place the CSV files from the `/data` folder into a local folder that PostgreSQL can read.
6. Run the COPY commands to load the data. If you're on Windows, you may need to update the file paths.
7. If you get “permission denied” errors when importing data, give the folder read permissions for `NETWORK SERVICE` or the `postgres` user.
8. After the data loads, you can open and run any query file in the `/queries` folder.

This setup took me some trial and error, so I included these notes to make the process easier for anyone who wants to try the same project.
