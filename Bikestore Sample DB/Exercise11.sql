-- Exercise 11
USE BikeStore

-- Task 1: Division
-- a) Re-order products not present in every store	
select product_name, stocks.store_id
from products, stores, stocks

except -- Return every row in A that does not appear verbatim in B
	
select product_name, stocks.store_id
from products join stocks on(stocks.product_id=products.product_id)
where stocks.quantity>0 -- Only an item w/ quantity 0 in some store will end up in list A

-- b) List of products in stock in every store
select product_name
from products

except -- Only items w/ quantity >0 in all stores will end up in list A

select product_name
from (
	select product_name, store_id
	from products, stores

	except
	
	select product_name, stocks.store_id
	from products join stocks on(stocks.product_id=products.product_id)
	where stocks.quantity>0
) as p
order by product_name






