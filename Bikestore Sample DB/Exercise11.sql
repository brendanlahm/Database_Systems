-- Exercise 11
USE BikeStore

-- Task 1: Division
-- a) Re-order products not present in every store	
select product_name, stocks.store_id
from products, stores, stocks

except -- Return every row in A that does not appear verbatim in B
	
select product_name, stocks.store_id
from products join stocks on(stocks.product_id=products.product_id)
where stocks.quantity >0








