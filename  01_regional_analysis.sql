
----- Which regions contribute most to sales and profit, and are there meaningful differences in profitability across regions?

select "State",
		SUM("Sales") AS Total_Sales,
   		SUM("Profit") AS Total_Profit,
    	SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
         sum("Quantity") as ttl_QTY,
        COUNT(distinct "Order ID") AS ORDER_LINES
FROM public.superstore_clean
group by "State"
ORDER BY Total_Profit DESC;

----- investigate on TEXAS why high sales but minus profit?

select "Category",
		SUM("Sales") AS Total_Sales,
   		SUM("Profit") AS Total_Profit,
    	SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
         sum("Quantity") as ttl_QTY,
        COUNT(distinct "Order ID") AS ORDER_LINES
FROM public.superstore_clean
where "State" = 'Texas'
group by "Category"
ORDER BY Total_Sales DESC;

------ product level analysis and disount TEXAS
select "Sub-Category", "Discount",
		sum("Profit") as Total_Profit,
		SUM("Profit") / SUM("Sales") * 100 as Profit_Margin,
		sum("Sales") as Total_Sales,
		COUNT(*) AS Total_Transactions
FROM public.superstore_clean
where "State" = 'Texas'
group by "Sub-Category","Discount"
order by "Sub-Category", "Discount";

----- Compare with Washington

select "Sub-Category", "Discount",
		sum("Profit") as Total_Profit,
		SUM("Profit") / SUM("Sales") * 100 as Profit_Margin,
		sum("Sales") as Total_Sales,
		COUNT(*) AS Total_Transactions
from public.superstore_clean
where "State" = 'Washington'
group by "Sub-Category","Discount"
order by "Sub-Category", "Discount";

---- Segmentation on Regional 

select "Segment", 
		SUM("Sales") AS Total_Sales,
   		SUM("Profit") AS Total_Profit,
    	SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
         sum("Quantity") as ttl_QTY,
        COUNT(distinct "Order ID") AS ORDER_LINES
from public.superstore_clean
where "State" = 'Texas'
group by "Segment"
ORDER BY Total_Sales DESC;

---- WASHINGTON
select "Segment", 
		SUM("Sales") AS Total_Sales,
   		SUM("Profit") AS Total_Profit,
    	SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
         sum("Quantity") as ttl_QTY,
        COUNT(distinct "Order ID") AS ORDER_LINES
from public.superstore_clean
where "State" = 'Washington'
group by "Segment"
ORDER BY Total_Sales DESC;

--------- CONSUMER SEGMENT IN TEXAS----------------
select "Category", 
		SUM("Sales") AS Total_Sales,
   		SUM("Profit") AS Total_Profit,
    	SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
         sum("Quantity") as ttl_QTY,
        COUNT(distinct "Order ID") AS ORDER_LINES
from public.superstore_clean
WHERE "Segment" = 'Consumer'
  AND "State" = 'Texas'
group by "Category"
ORDER BY Total_Sales DESC;

--------- CONSUMER SEGMENT IN washington----------------
select "Category", 
		SUM("Sales") AS Total_Sales,
   		SUM("Profit") AS Total_Profit,
    	SUM("Profit") / NULLIF(SUM("Sales"), 0) * 100
        AS Profit_Margin,
         sum("Quantity") as ttl_QTY,
        COUNT(distinct "Order ID") AS ORDER_LINES
from public.superstore_clean
WHERE "Segment" = 'Consumer'
  AND "State" = 'Washington'
group by "Category"
ORDER BY Total_Sales DESC;

----- checking----

select "Sub-Category", "Discount",
		sum("Profit") as Total_Profit,
		SUM("Profit") / SUM("Sales") * 100 as Profit_Margin,
		sum("Sales") as Total_Sales,
		COUNT(*) AS Total_Transactions
from public.superstore_clean
where "State" = 'Texas' and s."Sub-Category" = 'Appliances'
group by "Discount", "Sub-Category" 
order by "Discount";

--------

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
where "Sub-Category" = 'Appliances' and "State" = 'Texas'
group by "Sub-Category",
	CASE
    WHEN "Discount" = 0 THEN '0%'
    WHEN "Discount" <= 0.20 THEN '1-20%'
    WHEN "Discount" <= 0.40 THEN '21-40%'
    ELSE 'Above 40%'
end

