select top 10 * from sales
-------------
select round(sum(total_price),0)  as total_revenue
from sales
-------------
select pizza_category , count(*) as total_count
from sales
group by pizza_category
order by total_count desc
-------------
select pizza_size , count(*) as total_count
from sales
group by pizza_size
order by total_count desc
-------------------
select pizza_name,count(*) as total_orders
from sales
group by pizza_name
order by total_orders desc
------------------
select pizza_name,sum(total_price) as total_revenue
from sales
group by pizza_name
order by total_revenue desc
-------------------
select top 10 order_date , count(*) as total_orders
from sales
group by order_date
order by total_orders desc
-------------------
select sum(total_price) / count(distinct order_id) as [Average Order Price]
from sales
-----------
select sum(quantity) as [Total Pizzas sold]
from sales
------
select count(distinct order_id) as [Total Orders]
from sales
-----
select cast(cast(count(quantity) as decimal(10,2)) / cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2))
as [Average Pizzas per Order]
from sales
----
select pizza_category,
	   pizza_name,
	  total_price
from (
	select pizza_category,
	   pizza_name,
	   total_price,
	   row_number() over(
		partition by pizza_category
		order by total_price desc
	   ) as row_num
	from sales
	)as t
where row_num <= 3
order by pizza_category,total_price desc
-------------------------------
select datename(DW,order_date) as order_day,
	   count(distinct order_id) as total_orders
from sales
group by datename(DW,order_date)
order by total_orders desc
----------------------
select datename(MONTH,order_date) as month_name,
	   count(distinct order_id) as total_orders
from sales
group by datename(MONTH,order_date)
order by total_orders desc
-------------------------
select pizza_category,
	   round(sum(total_price),1) as [Total Sales],
	   round(sum(total_price) * 100 / (select sum(total_price) from sales where month(order_date) = 1),1)as [Percentage Category Sales]
from sales
where month(order_date) = 1
group by pizza_category
-----------------
select pizza_size,
		round(sum(total_price),1) as [Total Price],
		round(sum(total_price) * 100 / (select sum(total_price) from sales),1) as [Pizza Size Sales Percentage]
from sales
where datepart(quarter,order_date) = 1
group by pizza_size
order by sum(total_price) desc
------------------
select top 5 pizza_name,
		     sum(total_price) as Total_Revenue
from sales
group by pizza_name
order by Total_Revenue desc
--------------------
select top 5 pizza_name,
		     round(sum(total_price),1) as Total_Revenue
from sales
group by pizza_name
order by Total_Revenue
--------------------
select top 5 pizza_name,
			 round(sum(quantity),1) as [Total Quantity]
from sales
group by pizza_name
order by sum(quantity) desc
-------------------
select top 5 pizza_name,
			 count(distinct order_id) as[Total Orders]
from sales
group by pizza_name
order by count(distinct order_id) asc
-----------------