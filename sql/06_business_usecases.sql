
SELECT
    strftime('%Y', order_date)          AS yr,
    strftime('%m', order_date)          AS mo,
    strftime('%Y-%m', order_date)       AS year_month,
    COUNT(DISTINCT order_id)            AS orders,
    ROUND(SUM(sales), 2)                AS monthly_sales,
    ROUND(SUM(profit), 2)               AS monthly_profit,
    ROUND(AVG(sales), 2)                AS avg_order_value
FROM superstore
GROUP BY strftime('%Y-%m', order_date)
ORDER BY year_month;

SELECT
    strftime('%Y', order_date) AS year,
    category,
    ROUND(SUM(sales), 2)       AS total_sales,
    ROUND(SUM(profit), 2)      AS total_profit
FROM superstore
GROUP BY year, category
ORDER BY year, total_sales DESC;

SELECT
    customer_id,
    customer_name,
    segment,
    region,
    COUNT(DISTINCT order_id)    AS total_orders,
    ROUND(SUM(sales), 2)        AS lifetime_sales,
    ROUND(SUM(profit), 2)       AS lifetime_profit,
    ROUND(AVG(sales), 2)        AS avg_order_value
FROM superstore
GROUP BY customer_id, customer_name, segment, region
ORDER BY lifetime_sales DESC
LIMIT 10;

SELECT
    customer_id,
    customer_name,
    segment,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(sales), 2)     AS total_sales,
    ROUND(SUM(profit), 2)    AS total_profit
FROM superstore
GROUP BY customer_id, customer_name, segment
HAVING SUM(profit) < 0
ORDER BY total_profit ASC
LIMIT 15;

SELECT
    CASE
        WHEN discount = 0          THEN '0 — No Discount'
        WHEN discount <= 0.1       THEN '1 — Up to 10%'
        WHEN discount <= 0.2       THEN '2 — 11–20%'
        WHEN discount <= 0.3       THEN '3 — 21–30%'
        WHEN discount <= 0.5       THEN '4 — 31–50%'
        ELSE                            '5 — Above 50%'
    END AS discount_bucket,
    COUNT(*)                        AS line_items,
    ROUND(AVG(sales), 2)            AS avg_sales,
    ROUND(SUM(profit), 2)           AS total_profit,
    ROUND(SUM(profit)/SUM(sales)*100, 2) AS margin_pct
FROM superstore
GROUP BY discount_bucket
ORDER BY discount_bucket;

SELECT
    strftime('%Y', order_date)   AS year,
    CASE
        WHEN CAST(strftime('%m', order_date) AS INT) BETWEEN 1 AND 3  THEN 'Q1'
        WHEN CAST(strftime('%m', order_date) AS INT) BETWEEN 4 AND 6  THEN 'Q2'
        WHEN CAST(strftime('%m', order_date) AS INT) BETWEEN 7 AND 9  THEN 'Q3'
        ELSE 'Q4'
    END                          AS quarter,
    ROUND(SUM(sales), 2)         AS quarterly_sales,
    ROUND(SUM(profit), 2)        AS quarterly_profit,
    COUNT(DISTINCT order_id)     AS order_count
FROM superstore
GROUP BY year, quarter
ORDER BY year, quarter;

SELECT
    customer_id,
    customer_name,
    segment,
    COUNT(DISTINCT order_id) AS order_frequency,
    ROUND(SUM(sales), 2)     AS total_sales
FROM superstore
GROUP BY customer_id, customer_name, segment
HAVING COUNT(DISTINCT order_id) >= 5
ORDER BY order_frequency DESC;

SELECT
    row_id,
    COUNT(*) AS occurrences
FROM superstore
GROUP BY row_id
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;

SELECT
    order_id,
    COUNT(*) AS line_items
FROM superstore
GROUP BY order_id
ORDER BY line_items DESC
LIMIT 20;

SELECT
    ship_mode,
    COUNT(*)                                       AS shipments,
    ROUND(AVG(julianday(ship_date) - julianday(order_date)), 2) AS avg_days_to_ship,
    MIN(julianday(ship_date) - julianday(order_date))           AS min_days,
    MAX(julianday(ship_date) - julianday(order_date))           AS max_days
FROM superstore
GROUP BY ship_mode
ORDER BY avg_days_to_ship;

SELECT
    region,
    ROUND(SUM(sales), 2)                         AS total_sales,
    ROUND(SUM(profit), 2)                        AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2)     AS profit_margin_pct,
    RANK() OVER (ORDER BY SUM(profit) DESC)      AS profit_rank
FROM superstore
GROUP BY region
ORDER BY profit_rank;

SELECT
    region,
    sub_category,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY region, sub_category
ORDER BY region, total_profit DESC;
