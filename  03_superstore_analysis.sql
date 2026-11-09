SELECT current_database(), current_schema();
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name ILIKE '%superstore%';


ALTER TABLE "Superstore".superstore
SET SCHEMA public;

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_name = 'superstore';


------- Calculate:
------- 1. Total Sales
------- 2. Total Profit
------- 3. Total Quantity Sold
------- 4. Total Number of Orders

select 
	sum("Profit") as Total_Profit,
	sum("Sales") as Total_Sales,
	sum("Quantity") as Total_Qty,
	count(distinct "Order ID") as Total_Order
from public.superstore_clean;

----- Category Performance
select 
	"Category",
	sum("Profit") as Total_Profit,
	sum("Sales") as Total_Sales,
	sum("Quantity") as Total_Qty
from public.superstore_clean
group by "Category"
order by "Category" desc;


---- Find the problem in Furniture

select 
	"Sub-Category",
	sum("Profit") as Total_Profit,
	sum("Sales") as Total_Sales,
	sum("Quantity") as Total_Qty,
	AVG("Discount") as average_discount
from public.superstore_clean
where "Category" = 'Furniture'
group by "Sub-Category"
order by "Sub-Category" desc;


----- Analyze by Disc Group

select 
	CASE
    WHEN "Discount" = 0 THEN '0%'
    WHEN "Discount" <= 0.20 THEN '1-20%'
    WHEN "Discount" <= 0.40 THEN '21-40%'
    ELSE 'Above 40%'
end as Discount_Group,
	sum("Profit") as Total_Profit,
	SUM("Profit") / SUM("Sales") * 100 as Profit_Margin,
	sum("Sales") as Total_Sales,
	sum("Quantity") as Total_Qty,
	COUNT(*) AS Total_Transactions
from public.superstore_clean
where "Category" = 'Furniture'
group by CASE
    WHEN "Discount" = 0 THEN '0%'
    WHEN "Discount" <= 0.20 THEN '1-20%'
    WHEN "Discount" <= 0.40 THEN '21-40%'
    ELSE 'Above 40%'
end

----- Discount × Sub-Category

select "Sub-Category",
	CASE
    WHEN "Discount" = 0 THEN '0%'
    WHEN "Discount" <= 0.20 THEN '1-20%'
    WHEN "Discount" <= 0.40 THEN '21-40%'
    ELSE 'Above 40%'
end as Discount_Group,
	sum("Profit") as Total_Profit,
	SUM("Profit") / SUM("Sales") * 100 as Profit_Margin,
	sum("Sales") as Total_Sales
from public.superstore_clean
where "Category" = 'Furniture'
group by "Sub-Category",
	CASE
    WHEN "Discount" = 0 THEN '0%'
    WHEN "Discount" <= 0.20 THEN '1-20%'
    WHEN "Discount" <= 0.40 THEN '21-40%'
    ELSE 'Above 40%'
end


----- furnishings check -----

select "Sub-Category",
	count (distinct "Order ID") as order_lines,
	CASE
    WHEN "Discount" = 0 THEN '0%'
    WHEN "Discount" <= 0.20 THEN '1-20%'
    WHEN "Discount" <= 0.40 THEN '21-40%'
    ELSE 'Above 40%'
end as Discount_Group,
	sum("Profit") as Total_Profit,
	SUM("Profit") / SUM("Sales") * 100 as Profit_Margin,
	sum("Sales") as Total_Sales
from superstore
where "Sub-Category" = 'Furnishings'
group by "Sub-Category",
	CASE
    WHEN "Discount" = 0 THEN '0%'
    WHEN "Discount" <= 0.20 THEN '1-20%'
    WHEN "Discount" <= 0.40 THEN '21-40%'
    ELSE 'Above 40%'
end

---- sort by actual discount value
select "Sub-Category", "Discount",
		sum("Profit") as Total_Profit,
		SUM("Profit") / SUM("Sales") * 100 as Profit_Margin,
		sum("Sales") as Total_Sales,
		COUNT(*) AS Total_Transactions
from public.superstore_clean 
where "Category" = 'Furniture'
group by "Sub-Category","Discount"
order by "Sub-Category", "Discount";

-------- checking on Total Profit for Furniture
SELECT
    "Sub-Category",
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit
FROM public.superstore_clean
WHERE "Category" = 'Furniture'
GROUP BY "Sub-Category"
ORDER BY Total_Profit ASC;

----- Product level analysis for Tables and Bookcases

select "Sub-Category", "Product Name",
		sum("Profit") as Total_Profit,
		SUM("Profit") / SUM("Sales") * 100 as Profit_Margin,
		sum("Sales") as Total_Sales,
		COUNT(distinct "Order ID") AS ORDER_LINES
from public.superstore_clean
WHERE "Sub-Category" IN ('Tables', 'Bookcases')
GROUP BY "Sub-Category", "Product Name"
ORDER BY Total_Profit ASC;

----- Chromcraft Bull-Nose Wood Oval Conference Tables & Bases

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
    SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'Chromcraft Bull-Nose Wood Oval Conference Tables & Bases'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;


--------- Bush Advantage Collection Racetrack Conference Table

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin
FROM superstore
WHERE "Product Name" =
    'Bush Advantage Collection Racetrack Conference Table'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;

---------- Bush Advantage Collection Racetrack Conference Table

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
     SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'Bush Advantage Collection Racetrack Conference Table'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;

--------- Balt Solid Wood Rectangular Table

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
     SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'Balt Solid Wood Rectangular Table'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;


--------- O'Sullivan 4-Shelf Bookcase in Odessa Pine
SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
     SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'O''Sullivan 4-Shelf Bookcase in Odessa Pine'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;

--------- O''Sullivan Plantations 2-Door Library in Landvery Oak

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
     SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'O''Sullivan Plantations 2-Door Library in Landvery Oak'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;

--------- O''Sullivan Living Dimensions 5-Shelf Bookcases

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
     SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'O''Sullivan Living Dimensions 5-Shelf Bookcases'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;


----- Product level analysis for CHAIRS AND FURNISHINGS

select "Sub-Category", "Product Name",
		sum("Profit") as Total_Profit,
		SUM("Profit") / SUM("Sales") * 100 as Profit_Margin,
		sum("Sales") as Total_Sales,
		COUNT(distinct "Order ID") AS ORDER_LINES
from public.superstore_clean
WHERE "Sub-Category" IN ('Chairs', 'Furnishings')
GROUP BY "Sub-Category", "Product Name"
ORDER BY Total_Profit ASC;

--- Hon 2090 “Pillow Soft” Series Mid Back Swivel/Tilt Chairs

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
     SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'Hon 2090 “Pillow Soft” Series Mid Back Swivel/Tilt Chairs'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;

--- Global Wood Trimmed Manager's Task Chair, Khaki

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
     SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'Global Wood Trimmed Manager''s Task Chair, Khaki'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;

--- Global High-Back Leather Tilter, Burgundy

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
     SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'Global High-Back Leather Tilter, Burgundy'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;

--- Tenex Antistatic Computer Chair Mats

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
     SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'Tenex Antistatic Computer Chair Mats'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;

--- Tenex Chairmat w/ Average Lip, 45" x 53"

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
     SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'Tenex Chairmat w/ Average Lip, 45" x 53"'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;

--- Deflect-o RollaMat Studded, Beveled Mat for Medium Pile Carpeting

SELECT
    "Product Name",
    "Discount",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit,
    SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
    sum("Quantity") as ttl_QTY,
     SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit
FROM public.superstore_clean
WHERE "Product Name" =
    'Deflect-o RollaMat Studded, Beveled Mat for Medium Pile Carpeting'
GROUP BY
    "Product Name",
    "Discount"
ORDER BY "Discount" ASC;


----- Technology and Office Supplies levels discount analysis on general 
select "Sub-Category", "Discount",
		sum("Profit") as Total_Profit,
		SUM("Profit") / SUM("Sales") * 100 as Profit_Margin,
		sum("Sales") as Total_Sales,
		SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit,
		COUNT(*) AS Total_Transactions
from public.superstore_clean
where "Category" = 'Office Supplies'
group by "Sub-Category","Discount"
order by "Sub-Category", "Discount";

------- TECHNOLOGY-----

select "Sub-Category", "Discount",
		sum("Profit") as Total_Profit,
		SUM("Profit") / SUM("Sales") * 100 as Profit_Margin,
		sum("Sales") as Total_Sales,
		SUM("Sales") / nullif (SUM("Quantity"), 0) as sales_per_unit,
		COUNT(*) AS Total_Transactions
from public.superstore_clean
where "Category" = 'Technology'
group by "Sub-Category","Discount"
order by "Sub-Category", "Discount";





SELECT
    "State",
    COUNT(*) AS Order_Lines,
    SUM("Sales") AS Total_Sales,
    SUM("Profit") AS Total_Profit
FROM public.superstore_clean
GROUP BY
    "State"


SELECT
    COUNT(*) AS row_count,
    SUM("Profit") AS total_profit
FROM public.superstore_clean;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT "Row ID") AS unique_row_ids,
    MIN("Row ID") AS min_row_id,
    MAX("Row ID") AS max_row_id
FROM public.superstore_clean;


SELECT
    "Row ID",
    COUNT(*) AS copies
FROM public.superstore
GROUP BY "Row ID"
HAVING COUNT(*) > 1
ORDER BY "Row ID"
LIMIT 10;

