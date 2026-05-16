
SELECT COUNT(*) AS total_rows FROM superstore;

SELECT
    COUNT(DISTINCT order_id)     AS distinct_orders,
    COUNT(DISTINCT customer_id)  AS distinct_customers,
    COUNT(DISTINCT product_id)   AS distinct_products
FROM superstore;

SELECT
    SUM(CASE WHEN row_id       IS NULL THEN 1 ELSE 0 END) AS null_row_id,
    SUM(CASE WHEN order_id     IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN order_date   IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN ship_date    IS NULL THEN 1 ELSE 0 END) AS null_ship_date,
    SUM(CASE WHEN ship_mode    IS NULL THEN 1 ELSE 0 END) AS null_ship_mode,
    SUM(CASE WHEN customer_id  IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN region       IS NULL THEN 1 ELSE 0 END) AS null_region,
    SUM(CASE WHEN category     IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN sales        IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN profit       IS NULL THEN 1 ELSE 0 END) AS null_profit,
    SUM(CASE WHEN quantity     IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN discount     IS NULL THEN 1 ELSE 0 END) AS null_discount
FROM superstore;

SELECT
    MIN(discount) AS min_discount,
    MAX(discount) AS max_discount,
    SUM(CASE WHEN discount < 0 OR discount > 1 THEN 1 ELSE 0 END) AS invalid_discount_rows
FROM superstore;

SELECT COUNT(*) AS negative_sales_count
FROM superstore
WHERE sales < 0;

SELECT COUNT(*) AS invalid_ship_dates
FROM superstore
WHERE julianday(ship_date) < julianday(order_date);

SELECT COUNT(*) AS invalid_qty
FROM superstore
WHERE quantity <= 0;

SELECT
    'sales'    AS metric, ROUND(MIN(sales),2)    AS min_val, ROUND(MAX(sales),2)    AS max_val,
    ROUND(AVG(sales),2)    AS avg_val, ROUND(SUM(sales),2)    AS total
FROM superstore
UNION ALL
SELECT
    'profit',            ROUND(MIN(profit),2),  ROUND(MAX(profit),2),
    ROUND(AVG(profit),2), ROUND(SUM(profit),2)
FROM superstore
UNION ALL
SELECT
    'quantity',          MIN(quantity),          MAX(quantity),
    ROUND(AVG(quantity),2), SUM(quantity)
FROM superstore
UNION ALL
SELECT
    'discount',          MIN(discount),          MAX(discount),
    ROUND(AVG(discount),3), NULL
FROM superstore;

SELECT DISTINCT region FROM superstore ORDER BY region;

SELECT DISTINCT category FROM superstore ORDER BY category;

SELECT
    strftime('%Y', order_date) AS year,
    COUNT(DISTINCT order_id)   AS orders,
    ROUND(SUM(sales), 2)       AS sales
FROM superstore
GROUP BY year
ORDER BY year;

SELECT row_id, COUNT(*) AS cnt
FROM superstore
GROUP BY row_id
HAVING COUNT(*) > 1
ORDER BY cnt DESC
LIMIT 10;
