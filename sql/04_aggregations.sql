
SELECT
    region,
    COUNT(DISTINCT order_id)          AS total_orders,
    SUM(sales)                        AS total_sales,
    SUM(profit)                       AS total_profit,
    ROUND(AVG(sales), 2)              AS avg_order_sales,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

SELECT
    category,
    COUNT(*)             AS line_items,
    SUM(quantity)        AS total_qty_sold,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(discount) * 100, 1) AS avg_discount_pct
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

SELECT
    sub_category,
    category,
    COUNT(*)             AS line_items,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY sub_category, category
ORDER BY total_sales DESC;

SELECT
    region,
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY region, category
ORDER BY region, total_sales DESC;

SELECT
    segment,
    COUNT(DISTINCT order_id)       AS total_orders,
    ROUND(AVG(sales), 2)           AS avg_line_sales,
    ROUND(SUM(sales), 2)           AS total_sales
FROM superstore
GROUP BY segment
ORDER BY total_sales DESC;

SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS order_count,
    SUM(quantity)            AS total_qty,
    ROUND(SUM(sales), 2)     AS total_sales
FROM superstore
GROUP BY ship_mode
ORDER BY order_count DESC;

SELECT
    category,
    ROUND(SUM(sales), 2)  AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM superstore
GROUP BY category
HAVING SUM(sales) > 5000
ORDER BY margin_pct DESC;

SELECT
    state,
    region,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2)     AS total_sales
FROM superstore
GROUP BY state, region
HAVING COUNT(DISTINCT order_id) > 50
ORDER BY order_count DESC;
