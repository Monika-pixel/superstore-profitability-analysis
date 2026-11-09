
---- test dicount limit for furniture----

SELECT
    "Sub-Category",
 	CASE
    WHEN "Sub-Category" = 'Tables'THEN LEAST("Discount", 0.10)
    WHEN "Sub-Category" = 'Bookcases'THEN LEAST("Discount", 0.10)
    WHEN "Sub-Category" = 'Chairs'THEN LEAST("Discount", 0.20)
    WHEN "Sub-Category" = 'Furnishings'THEN LEAST("Discount", 0.20)
    END AS proposed_disc
FROM public.superstore_clean

WHERE TO_DATE("Order Date", 'MM/DD/YYYY') >= DATE '2017-01-01'
  AND TO_DATE("Order Date", 'MM/DD/YYYY') < DATE '2018-01-01' and "Category" = 'Furniture';


----- cont the estimated sales with capped discount----


WITH actual_sales AS (
    SELECT
        "Sub-Category",
        "Sales",
        "Discount",
        CASE
            WHEN "Sub-Category" = 'Tables'
                THEN LEAST("Discount", 0.10)
            WHEN "Sub-Category" = 'Bookcases'
                THEN LEAST("Discount", 0.10)
            WHEN "Sub-Category" = 'Chairs'
                THEN LEAST("Discount", 0.20)
            WHEN "Sub-Category" = 'Furnishings'
                THEN LEAST("Discount", 0.20)
            ELSE "Discount"
        END AS proposed_disc
    FROM public.superstore_clean
    WHERE
        TO_DATE("Order Date", 'MM/DD/YYYY') >= DATE '2017-01-01'
        AND TO_DATE("Order Date", 'MM/DD/YYYY') < DATE '2018-01-01'
        AND "Category" = 'Furniture'
),

estimated_sales_after_disc AS (
    SELECT
        "Sub-Category",
        "Sales" AS actual_sales,
        "Sales" / (1 - "Discount")
            * (1 - proposed_disc) AS estimated_sales
    FROM actual_sales
)

SELECT
    "Sub-Category",
    ROUND(SUM(actual_sales)::numeric, 2) AS actual_sales,
    ROUND(SUM(estimated_sales)::numeric, 2)
        AS estimated_sales_after_cap,
    ROUND(
        (SUM(estimated_sales) - SUM(actual_sales))::numeric,
        2
    ) AS sales_difference
FROM estimated_sales_after_disc
GROUP BY "Sub-Category"
ORDER BY sales_difference DESC;

----- cont the estimated profit with estimated sales----

WITH actual_sales AS (
    SELECT
        "Sub-Category",
        "Sales",
        "Discount",
        "Profit",
        CASE
            WHEN "Sub-Category" = 'Tables'
                THEN LEAST("Discount", 0.10)
            WHEN "Sub-Category" = 'Bookcases'
                THEN LEAST("Discount", 0.10)
            WHEN "Sub-Category" = 'Chairs'
                THEN LEAST("Discount", 0.20)
            WHEN "Sub-Category" = 'Furnishings'
                THEN LEAST("Discount", 0.20)
            ELSE "Discount"
        END AS proposed_disc
    FROM public.superstore_clean
    WHERE
        TO_DATE("Order Date", 'MM/DD/YYYY') >= DATE '2017-01-01'
        AND TO_DATE("Order Date", 'MM/DD/YYYY') < DATE '2018-01-01'
        AND "Category" = 'Furniture'
),

estimated_sales_after_disc AS (
    SELECT
        "Sub-Category",
        "Profit" AS actual_profit,
        "Sales" AS actual_sales,
        "Sales" / (1 - "Discount")
            * (1 - proposed_disc) AS estimated_sales
    FROM actual_sales
),

additional_sales AS (
    SELECT
        "Sub-Category",
        SUM(actual_profit) AS actual_profit,
        SUM(actual_sales) AS actual_sales,
        SUM(estimated_sales) AS estimated_sales_after_cap,
        SUM(estimated_sales) - SUM(actual_sales) AS sales_difference
    FROM estimated_sales_after_disc
    GROUP BY "Sub-Category"
)

SELECT
    "Sub-Category",
    ROUND(actual_profit::numeric, 2) AS actual_profit,
    ROUND(
        (actual_profit + sales_difference)::numeric,
        2
    ) AS estimated_profit,
    ROUND(sales_difference::numeric, 2) AS profit_difference
FROM additional_sales
ORDER BY estimated_profit DESC;

---- SENSITIVITY and EVIDENCE CHECK---
---- 1. Calculate affected sales percentage by subcategory----


WITH actual_sales AS (
    SELECT
        "Sub-Category",
        "Sales",
        "Discount",
        CASE
            WHEN "Sub-Category" = 'Tables'
                THEN LEAST("Discount", 0.10)
            WHEN "Sub-Category" = 'Bookcases'
                THEN LEAST("Discount", 0.10)
            WHEN "Sub-Category" = 'Chairs'
                THEN LEAST("Discount", 0.20)
            WHEN "Sub-Category" = 'Furnishings'
                THEN LEAST("Discount", 0.20)
            ELSE "Discount"
        END AS proposed_disc
    FROM public.superstore_clean
    WHERE
        TO_DATE("Order Date", 'MM/DD/YYYY') >= DATE '2017-01-01'
        AND TO_DATE("Order Date", 'MM/DD/YYYY') < DATE '2018-01-01'
        AND "Category" = 'Furniture'
),

affected_sales AS (
    SELECT
        "Sub-Category",
        SUM("Sales") AS actual_sales,
        SUM(
            CASE
                WHEN "Discount" > proposed_disc
                    THEN "Sales"
                ELSE 0
            END
        ) AS affected_actual_sales
    FROM actual_sales
    GROUP BY "Sub-Category"
)

SELECT
    "Sub-Category",
    ROUND(actual_sales::numeric, 2) AS actual_sales,
    ROUND(affected_actual_sales::numeric, 2) AS affected_actual_sales,
    ROUND(
        (affected_actual_sales / NULLIF(actual_sales, 0) * 100)::numeric,
        2
    ) AS affected_sales_percentage
FROM affected_sales
ORDER BY affected_sales_percentage DESC;

















		

