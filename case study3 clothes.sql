------------------------que and answer-----------------------------
que1: what was the total quantity sold for all products?
select details.product_name,
sum(sales.qty) as sales_counts
from sales inner join product_details as details
on sales.prod_id=details.product_id
group by details.product_name
order by sales_counts desc;
-------------------------------------------------------------------
que2:what is the total generated revenue for each product?
select sum(price*qty) as no_dis_revenue
from sales;
----------------------------------------------------------------------
que3:what was the total discount amount for all products?
select sum(price*qty*discount)/100 as total_discount from sales;
-------------------------------------------------------------------

que4:How many unique transactions were there?
select count(distinct txn_id) as unique_txn
from sales;
---------------------------------------------------------------
que5: what are the average unique products purchased in each transactions?
WITH cte_transaction_products AS (
    SELECT txn_id, COUNT(DISTINCT prod_id) AS product_count
    FROM sales
    GROUP BY txn_id
)
SELECT ROUND(AVG(product_count)) AS avg_unique_products
FROM cte_transaction_products;
-----------------------------------------------------------------

que6: avg discount values per transaction;
WITH cte_transaction_discount AS (
    SELECT txn_id, sum(price*qty*discount)/100 AS total_discount
    FROM sales
    GROUP BY txn_id
)
SELECT ROUND(AVG(total_discount)) AS avg_discount
FROM cte_transaction_discount;
-------------------------------------------------------------------------

que7: average revenue for member and non member transaction?
with cte_member_revenue as(
select member,txn_id,sum(price*qty) as revenue
from sales
group by member,txn_id)
select member,round(avg(revenue),2) as avg_revenue
from cte_member_revenue
group by member;
----------------------------------------------------------

que8:what are top 3 products by total revenue before discount?
SELECT details.product_name, SUM(sales.qty * details.price) AS discount_revenue
FROM sales
INNER JOIN product_details AS details ON sales.prod_id = details.product_id
GROUP BY details.product_name
ORDER BY discount_revenue DESC
LIMIT 3;
----------------------------------------------------------------------
que9:total qty,revenue,discount for each segment?
SELECT
    details.segment_id,
    details.segment_name,
    SUM(sales.qty) AS total_quantity,
    SUM(sales.qty * sales.price) AS total_revenue,
    SUM(sales.qty * sales.price * sales.price * sales.discount) / 100 AS total_price_times_discount,
    SUM(sales.qty * sales.price) AS total_revenue_after_discount,
    SUM(sales.qty * sales.price * sales.discount) / 100 AS total_discount
FROM sales
INNER JOIN product_details AS details ON sales.prod_id = details.product_id
GROUP BY details.segment_id, details.segment_name;

--------------------------------------------------------------------
que10:which product have highest revenue?
select details.segment_id,
details.segment_name,
details.product_id,details.product_name,
sum(sales.qty) as product_quantity
from sales inner join product_details as details
on sales.prod_id=details.product_id
group by details .segment_id,details.segment_name,
details.product_id,details.product_name
order by product_quantity desc
limit 5;
---------------------------------------------------------

que11:total revenue,discount,quantity for each category?
SELECT
    details.category_id,
    details.category_name,
    SUM(sales.qty) AS total_quantity,
    SUM(sales.qty * sales.price) AS total_revenue,
    SUM(sales.qty * sales.price * sales.price * sales.discount) / 100 AS total_price_times_discount,
    SUM(sales.qty * sales.price) AS total_revenue_after_discount,
    SUM(sales.qty * sales.price * sales.discount) / 100 AS total_discount
FROM sales
INNER JOIN product_details AS details ON sales.prod_id = details.product_id
GROUP BY details.category_id, details.category_name;
---------------------------------------------------------------------------

que12:top selling product for each category?
select details.category_id,
details.category_name,
details.product_id,details.product_name,
sum(sales.qty) as product_quantity
from sales inner join product_details as details
on sales.prod_id=details.product_id
group by details .category_id,details.category_name,
details.product_id,details.product_name
order by product_quantity desc
limit 5;
--------------------------------------------------------done_-------------------------------------------------


