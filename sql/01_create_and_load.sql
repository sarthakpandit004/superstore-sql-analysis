
DROP TABLE IF EXISTS superstore;

CREATE TABLE superstore (
    row_id        INTEGER,
    order_id      TEXT,
    order_date    DATE,
    ship_date     DATE,
    ship_mode     TEXT,
    customer_id   TEXT,
    customer_name TEXT,
    segment       TEXT,
    country       TEXT,
    city          TEXT,
    state         TEXT,
    postal_code   TEXT,
    region        TEXT,
    product_id    TEXT,
    category      TEXT,
    sub_category  TEXT,
    product_name  TEXT,
    sales         REAL,
    quantity      INTEGER,
    discount      REAL,
    profit        REAL
);


SELECT COUNT(*) AS total_rows FROM superstore;
