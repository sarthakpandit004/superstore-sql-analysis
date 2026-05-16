import csv
import random
from datetime import datetime, timedelta

random.seed(42)

regions = {
    "East":    ["New York", "Philadelphia", "Boston", "Baltimore", "Washington"],
    "West":    ["Los Angeles", "Seattle", "San Francisco", "Portland", "Phoenix"],
    "Central": ["Chicago", "Dallas", "Minneapolis", "Kansas City", "Columbus"],
    "South":   ["Houston", "Atlanta", "Miami", "Charlotte", "Nashville"],
}

region_state = {
    "New York": "New York", "Philadelphia": "Pennsylvania", "Boston": "Massachusetts",
    "Baltimore": "Maryland", "Washington": "District of Columbia",
    "Los Angeles": "California", "Seattle": "Washington", "San Francisco": "California",
    "Portland": "Oregon", "Phoenix": "Arizona",
    "Chicago": "Illinois", "Dallas": "Texas", "Minneapolis": "Minnesota",
    "Kansas City": "Missouri", "Columbus": "Ohio",
    "Houston": "Texas", "Atlanta": "Georgia", "Miami": "Florida",
    "Charlotte": "North Carolina", "Nashville": "Tennessee",
}

segments = ["Consumer", "Corporate", "Home Office"]

categories = {
    "Technology": {
        "Phones":      ["Apple iPhone 14", "Samsung Galaxy S22", "Google Pixel 7", "Motorola Moto G"],
        "Computers":   ["Dell Inspiron 15", "HP Pavilion 14", "Lenovo ThinkPad X1", "Apple MacBook Air"],
        "Accessories": ["Logitech MX Master Mouse", "Anker USB-C Hub", "Belkin Surge Protector", "APC UPS 1500VA"],
        "Copiers":     ["Canon imageRUNNER 2630", "Brother MFC-L8900CDW", "Ricoh IM C300", "Xerox B210"],
        "Machines":    ["Zebra ZT411 Label Printer", "Dymo LabelWriter 450", "Fellowes Powershred 79Ci"],
    },
    "Furniture": {
        "Chairs":      ["HON Ignition 2.0 Task Chair", "Steelcase Leap V2", "Herman Miller Aeron", "Flash Furniture Mesh Chair"],
        "Tables":      ["IKEA Bekant Desk", "Sauder Palladia Desk", "Realspace Magellan Corner Desk"],
        "Bookcases":   ["Bush Furniture Cabot Bookcase", "Sauder Cottage Road Bookcase", "Way2Furn 5-Shelf"],
        "Furnishings": ["Deflect-O Chair Mat", "Master Caster Doorstop", "Lorell Dry-Erase Board"],
    },
    "Office Supplies": {
        "Binders":     ["Avery Heavy Duty Binder", "Cardinal EasyOpen Binder", "Mead Flex Binder"],
        "Paper":       ["Hammermill Premium Copy Paper", "HP Office Paper 500-Sheet", "Georgia-Pacific Copy Paper"],
        "Art":         ["Crayola Colored Pencils", "Faber-Castell Watercolor", "Sharpie Permanent Markers"],
        "Labels":      ["Avery Easy Peel Labels", "Staples Multipurpose Labels", "Maco Laser Labels"],
        "Fasteners":   ["Swingline Heavy Duty Stapler", "Acme Scissors", "3M Post-it Flags"],
        "Envelopes":   ["Quality Park Catalog Envelopes", "Staples 10-Envelope Box"],
        "Appliances":  ["Fellowes Saturn Laminator", "Bostitch QuietSharp Sharpener", "ACCO 3-Hole Punch"],
        "Storage":     ["Avery Lateral File", "Smead Filing Box", "Bankers Box Stor/File"],
        "Supplies":    ["Pilot G2 Gel Pen 12-Pack", "Dixon Ticonderoga Pencils", "Scotch Magic Tape"],
    },
}

price_ranges = {
    "Phones": (199, 1199), "Computers": (399, 1799), "Accessories": (15, 249),
    "Copiers": (299, 1499), "Machines": (89, 449),
    "Chairs": (89, 899), "Tables": (120, 899), "Bookcases": (59, 349), "Furnishings": (15, 189),
    "Binders": (4, 29), "Paper": (6, 55), "Art": (3, 45), "Labels": (5, 35),
    "Fasteners": (5, 59), "Envelopes": (7, 39), "Appliances": (19, 149),
    "Storage": (12, 89), "Supplies": (3, 29),
}

first_names = ["James","Mary","John","Patricia","Robert","Jennifer","Michael","Linda",
               "William","Barbara","David","Susan","Richard","Jessica","Joseph","Sarah",
               "Thomas","Karen","Charles","Lisa","Christopher","Nancy","Daniel","Betty",
               "Matthew","Margaret","Anthony","Sandra","Mark","Ashley","Donald","Emily"]
last_names  = ["Smith","Johnson","Williams","Brown","Jones","Garcia","Miller","Davis",
               "Martinez","Hernandez","Lopez","Gonzalez","Wilson","Anderson","Taylor",
               "Moore","Jackson","Martin","Lee","Perez","Thompson","White","Harris","Clark"]

ship_modes = ["Standard Class", "Second Class", "First Class", "Same Day"]
ship_delays = {"Standard Class": (5,7), "Second Class": (3,5), "First Class": (2,3), "Same Day": (0,1)}

def rand_date(start, end):
    return start + timedelta(days=random.randint(0, (end - start).days))

start_date = datetime(2019, 1, 1)
end_date   = datetime(2022, 12, 31)

customer_pool = []
for i in range(120):
    cname = f"{random.choice(first_names)} {random.choice(last_names)}"
    seg   = random.choice(segments)
    cid   = f"CUS-{str(i+1001).zfill(5)}"
    customer_pool.append((cid, cname, seg))

rows = []
order_counter = 10001
row_id = 1

for _ in range(1000):
    order_id  = f"CA-{random.randint(2019,2022)}-{str(order_counter).zfill(6)}"
    order_counter += random.randint(1, 5)

    order_date = rand_date(start_date, end_date)
    mode       = random.choice(ship_modes)
    lo, hi     = ship_delays[mode]
    ship_date  = order_date + timedelta(days=random.randint(lo, hi))

    customer   = random.choice(customer_pool)
    cust_id, cust_name, segment = customer

    region = random.choice(list(regions.keys()))
    city   = random.choice(regions[region])
    state  = region_state[city]
    postal = str(random.randint(10000, 99999))

    category    = random.choice(list(categories.keys()))
    sub_cat     = random.choice(list(categories[category].keys()))
    product_name = random.choice(categories[category][sub_cat])
    prod_id      = f"{'TEC' if category=='Technology' else 'FUR' if category=='Furniture' else 'OFF'}-{sub_cat[:3].upper()}-{random.randint(10000,99999)}"

    base_price = random.uniform(*price_ranges[sub_cat])
    quantity   = random.randint(1, 10)
    discount   = random.choice([0, 0, 0, 0.1, 0.2, 0.3, 0.4, 0.5])
    sales      = round(base_price * quantity * (1 - discount), 2)
    profit     = round(sales * random.uniform(0.05, 0.45) * (1 if discount < 0.4 else -0.5), 2)

    num_items = random.randint(1, 4)
    for _ in range(num_items):
        rows.append([
            row_id, order_id,
            order_date.strftime("%Y-%m-%d"),
            ship_date.strftime("%Y-%m-%d"),
            mode, cust_id, cust_name, segment,
            "United States", city, state, postal, region,
            prod_id, category, sub_cat, product_name,
            round(sales / num_items, 2),
            quantity, discount,
            round(profit / num_items, 2)
        ])
        row_id += 1

headers = [
    "Row ID","Order ID","Order Date","Ship Date","Ship Mode",
    "Customer ID","Customer Name","Segment","Country","City",
    "State","Postal Code","Region","Product ID","Category",
    "Sub-Category","Product Name","Sales","Quantity","Discount","Profit"
]

with open("data/sample_superstore.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(headers)
    writer.writerows(rows)

print(f"Generated {len(rows)} rows → data/sample_superstore.csv")
