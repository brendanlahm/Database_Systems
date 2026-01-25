-- Exercise 10
USE BikeStore;

-- Task 1: Joins
-- Customers who never ordered
select customers.first_name, customers.last_name, customers.customer_id, customers.email
from customers left join orders on (customers.customer_id=orders.customer_id)
where orders.customer_id is null
order by last_name

-- Customers w/ an order but no order item
select distinct customers.first_name, customers.last_name, customers.customer_id, customers.email, orders.order_id, order_items.item_id, order_items.product_id
from customers left join orders on (customers.customer_id=orders.customer_id) left join order_items on (orders.order_id=order_items.order_id)
where order_items.item_id is null and orders.order_id is not null

-- All products that have less than 20 units in inventory & model year 2018 or 2019
select products.product_name, sum(isnull(stocks.quantity,0.0)) as sum
from products left join stocks on (products.product_id=stocks.product_id)
where model_year = 2018 or model_year = 2019
group by products.product_name
having sum(isnull(stocks.quantity,0.0))<20
order by sum

-- Task 2: Aggregate Functions & Joins
-- Determine turnover per store






