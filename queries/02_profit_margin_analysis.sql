-- =========================================================
-- 01. GROSS PROFIT ON SUCCESSFUL ORDERS
-- =========================================================
SELECT
sum(((price*quantity)- discount_amount) - (unit_cost*quantity)) as gross_profit
FROM order_items as i
JOIN costs as c
on i.product_id = c.product_id
JOIN orders as o
on o.order_id = i.order_id
WHERE o.order_status <> 'cancelled' AND o.order_status <> 'returned';


-- =========================================================
-- 02. GROSS PROFIT PER CATEGORY
-- =========================================================
SELECT
pc.category_name, 
sum(((price*quantity)- discount_amount) - (unit_cost*quantity)) as gross_profit
FROM order_items as i
JOIN costs as c
on i.product_id = c.product_id
JOIN orders as o
on o.order_id = i.order_id
JOIN products as p
on p.product_id = c.product_id
JOIN product_categories as pc
ON pc.category_id = p.category_id
WHERE o.order_status NOT IN ('cancelled','returned') 
group by pc.category_name 
order by gross_profit DESC;

-- =========================================================
-- 03. GROSS MARGIN % PER CATEGORY
-- =========================================================
WITH prof_temp AS 
(SELECT
pc.category_name, 
sum(((price*quantity)- discount_amount) - (unit_cost*quantity)) as gross_profit,
sum((price*quantity)- discount_amount) as gross_revenue
FROM order_items as i
JOIN costs as c
on i.product_id = c.product_id
JOIN orders as o
on o.order_id = i.order_id
JOIN products as p
on p.product_id = c.product_id
JOIN product_categories as pc
ON pc.category_id = p.category_id
WHERE o.order_status NOT IN ('cancelled','returned') 
group by pc.category_name 
order by gross_profit DESC)

SELECT
category_name, 
round(((gross_profit/gross_revenue)*100), 2) as gross_margin_percent
FROM prof_temp;


-- =========================================================
-- 04. TOP 10 MOST PROFITABLE PRODUCTS
-- =========================================================
SELECT
i.product_id,
p.product_name,
sum(((quantity*price)-discount_amount) -(unit_cost*quantity)) as gross_profit
FROM order_items as i
JOIN products as p
ON i.product_id = p.product_id
join orders as o
on i.order_id = o.order_id
JOIN costs as c
on c.product_id = p.product_id
WHERE o.order_status NOT IN ('cancelled', 'returned')
GROUP BY i.product_id, product_name
ORDER BY gross_profit DESC
LIMIT 10

