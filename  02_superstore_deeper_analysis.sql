
----checking on November 2017 whre it gaves most sales

SELECT
    "Sub-Category", "Category",

    CASE
        WHEN "Discount" = 0 THEN '0%'
        WHEN "Discount" <= 0.20 THEN '1-20%'
        WHEN "Discount" <= 0.40 THEN '21-40%'
        ELSE 'Above 40%'
    END AS Discount_Group,

    SUM("Profit") AS Total_Profit,
    SUM("Sales") AS Total_Sales,
    COUNT(*) AS Order_Lines

FROM public.superstore_clean

WHERE TO_DATE("Order Date", 'MM/DD/YYYY') >= DATE '2017-03-01'
  AND TO_DATE("Order Date", 'MM/DD/YYYY') < DATE '2017-04-01'

GROUP BY
    "Sub-Category","Category",
    CASE
        WHEN "Discount" = 0 THEN '0%'
        WHEN "Discount" <= 0.20 THEN '1-20%'
        WHEN "Discount" <= 0.40 THEN '21-40%'
        ELSE 'Above 40%'
    END

ORDER BY total_sales DESC;