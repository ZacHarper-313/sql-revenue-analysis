-- =========================================================
-- 01. TOP CUSTOMERS BY TOTAL REVENUE
-- =========================================================
SELECT
cu.customer_id, first_name, last_name, email,
sum((price*quantity) - discount_amount) as total_revenue
FROM order_items as i
JOIN orders as o
ON o.order_id = i.order_id
JOIN customers as cu
on cu.customer_id = o.customer_id
WHERE o.order_status NOT IN ('cancelled', 'returned')
GROUP BY cu.customer_id, first_name, last_name, email
ORDER BY total_revenue DESC
LIMIT 50;

-- =========================================================
-- 02. REVENUE BY REGION
-- =========================================================
SELECT
region, count(DISTINCT cu.customer_id) as customer_count,
sum((price*quantity) - discount_amount) as total_revenue
FROM order_items as i
JOIN orders as o
on i.order_id = o.order_id
JOIN customers as cu
on o.customer_id = cu.customer_id
WHERE o.order_status NOT IN ('cancelled', 'returned')
GROUP BY region
ORDER BY total_revenue DESC;


-- =========================================================
-- 03. TOP CUSTOMERS BY NUMBER OF ORDERS
-- =========================================================
SELECT
cu.customer_id, first_name, last_name, email,
count(DISTINCT o.order_id) as order_count
FROM orders as o
JOIN customers as cu
on o.customer_id = cu.customer_id
WHERE o.order_status NOT IN ('cancelled', 'returned')
GROUP BY cu.customer_id, first_name, last_name, email
ORDER BY order_count DESC
LIMIT 50;