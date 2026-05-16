
PRAGMA table_info(superstore);

SELECT *
FROM superstore
LIMIT 10;

SELECT COUNT(*) AS total_rows
FROM superstore;

SELECT
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order
FROM superstore;

SELECT COUNT(DISTINCT order_id)      AS unique_orders,
       COUNT(DISTINCT customer_id)   AS unique_customers,
       COUNT(DISTINCT product_id)    AS unique_products,
       COUNT(DISTINCT region)        AS regions,
       COUNT(DISTINCT category)      AS categories,
       COUNT(DISTINCT sub_category)  AS sub_categories,
       COUNT(DISTINCT state)         AS states
FROM superstore;

SELECT segment, COUNT(*) AS row_count
FROM superstore
GROUP BY segment
ORDER BY row_count DESC;

SELECT
    SUM(CASE WHEN order_id      IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN customer_id   IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN sales         IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN profit        IS NULL THEN 1 ELSE 0 END) AS null_profit,
    SUM(CASE WHEN region        IS NULL THEN 1 ELSE 0 END) AS null_region
FROM superstore;
