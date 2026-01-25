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
select stores.store_name, sum(order_items.list_price*(1-order_items.discount)+order_items.quantity) as 'Turnover ($)'
from order_items join orders on (order_items.order_id=orders.order_id) join stores on (orders.store_id=stores.store_id)
group by stores.store_name

-- # orders per employee
select staffs.staff_id, staffs.first_name, staffs.last_name, sum(order_items.quantity) as '# Orders'
from staffs join orders on (staffs.staff_id=orders.staff_id) join order_items on (orders.order_id=order_items.order_id)
group by staffs.staff_id, staffs.first_name, staffs.last_name;

-- Task 3: Recursion
-- List who manages who
with my_staff (first_name, last_name, staff_id, employee_first_name, employee_second_name, employee_id, direct_report, reports_via, level) as(
	select	p.first_name, 
			p.last_name, 
			p.staff_id, 
			s.first_name, 
			s.last_name, 
			s.staff_id, 
			cast('yes' as char(3)), 
			cast('' as varchar(255)),
			cast(0 as int) as level
	from	staffs as p 
			left join staffs as s on (p.staff_id=s.manager_id)

	union all

	select	p.first_name, 
			p.last_name, 
			p.staff_id, 
			s.first_name, 
			s.last_name, 
			s.staff_id, 
			cast('no' as char(3)), 
			case	when direct_report='yes'	then cast(employee_first_name+' '+employee_second_name as varchar(255))
					when direct_report='no'		then reports_via
			end,
			level=level+1
	from my_staff as p join staffs as s on (p.employee_id=s.manager_id) where p.employee_id is not null
)

select * from my_staff order by last_name;
select * from staffs;






