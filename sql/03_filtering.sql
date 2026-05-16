
SELECT order_id, customer_name, city, state, sales, profit
FROM superstore
WHERE region = 'West'
ORDER BY sales DESC
LIMIT 20;

SELECT order_id, product_name, sub_category, sales, quantity, discount
FROM superstore
WHERE category = 'Technology'
ORDER BY sales DESC
LIMIT 20;

SELECT order_id, order_date, customer_name, region, sales
FROM superstore
WHERE strftime('%Y', order_date) = '2021'
ORDER BY order_date;

SELECT order_id, order_date, product_name, sales, profit
FROM superstore
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31'
ORDER BY order_date;

SELECT order_id, customer_name, product_name, sales, profit
FROM superstore
WHERE sales > 500
ORDER BY sales DESC;

SELECT order_id, product_name, category, sales, discount, profit
FROM superstore
WHERE discount > 0.3
ORDER BY discount DESC, profit;

SELECT order_id, customer_name, product_name, sales, discount, profit
FROM superstore
WHERE profit < 0
ORDER BY profit;

SELECT order_id, customer_name, city, state, sales, profit
FROM superstore
WHERE segment = 'Corporate'
  AND region  = 'South'
ORDER BY sales DESC;

SELECT order_id, segment, customer_name, sales, profit
FROM superstore
WHERE region = 'East'
  AND segment IN ('Consumer', 'Home Office')
ORDER BY sales DESC
LIMIT 30;

SELECT order_id, product_name, sub_category, sales, profit
FROM superstore
WHERE product_name LIKE '%Chair%'
ORDER BY sales DESC;
