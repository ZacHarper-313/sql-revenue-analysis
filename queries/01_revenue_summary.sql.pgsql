-- =========================================================
-- 01. TOTAL REVENUE
-- =========================================================
SELECT
sum ((price*quantity)-discount_amount) as total_revenue
from 
(SELECT i.order_id, i.price, i.quantity, i.discount_amount, o.order_status 
from order_items as i
JOIN orders as o on o.order_id = i.order_id) as rev_items
where order_status <> 'cancelled' AND order_status <> 'returned';

-- =========================================================
-- 02. TOTAL REVENUE BY CATEGORY
-- =========================================================
SELECT
category_name,
sum((price*quantity)-discount_amount) as total_revenue
from (
    SELECT
i.order_id, price, quantity, discount_amount, p.category_id, order_status, c.category_name
from order_items as i
JOIN products as p
on p.product_id = i.product_id
JOIN orders as o
on o.order_id = i.order_id
join product_categories as c
on c.category_id = p.category_id
where order_status <> 'cancelled' AND order_status <> 'returned'
) as rev_items
group by category_name
order by total_revenue DESC;

-- =========================================================
-- 03. MONTHLY REVENUE TREND
-- =========================================================
SELECT
date_trunc('month',order_date) as month_start, 
sum((price*quantity)-discount_amount) as total_revenue
from order_items as i
JOIN orders as o
on o.order_id = i.order_id
WHERE order_status <> 'cancelled' AND order_status <> 'returned'
group by month_start
order by month_start ASC;