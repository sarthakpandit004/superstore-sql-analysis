
SELECT
    product_name,
    sub_category,
    category,
    ROUND(SUM(sales), 2)  AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity)         AS units_sold
FROM superstore
GROUP BY product_name, sub_category, category
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    product_name,
    category,
    ROUND(SUM(sales), 2)  AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY product_name, category
ORDER BY total_profit DESC
LIMIT 10;

SELECT
    product_name,
    category,
    ROUND(SUM(sales), 2)  AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY product_name, category
ORDER BY total_profit ASC
LIMIT 10;

SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC
LIMIT 5;

SELECT
    city,
    state,
    region,
    ROUND(SUM(sales), 2)     AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore
GROUP BY city, state, region
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    sub_category,
    category,
    SUM(quantity)        AS total_units,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY sub_category, category
ORDER BY total_units DESC
LIMIT 10;

SELECT
    sub_category,
    category,
    ROUND(AVG(discount) * 100, 1) AS avg_discount_pct,
    COUNT(*)                      AS line_items
FROM superstore
WHERE discount > 0
GROUP BY sub_category, category
ORDER BY avg_discount_pct DESC
LIMIT 5;

SELECT
    region,
    ship_mode,
    COUNT(*) AS order_lines
FROM superstore
GROUP BY region, ship_mode
ORDER BY region, order_lines DESC;
