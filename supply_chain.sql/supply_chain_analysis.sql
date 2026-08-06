-- 📑 Bloque 1: SELECT

SELECT 
	* 
FROM 
	datacosupplychaindataset 
LIMIT 20;

-- 2. Display only the "Customer City" and Customer "Country columns".
SELECT 
	"Customer City", 
	"Customer Country" 
FROM 
	datacosupplychaindataset;

-- 3. Display the Category Name and the Product Name for all rows
SELECT 
	"Category Name", 
	"Product Name" 
FROM 
	datacosupplychaindataset d;

-- 4. Select the "Order Id" and the "order date" (order date (DateOrders)).
SELECT 
	"Order Id", 
	"order date (DateOrders)" 
FROM 
	datacosupplychaindataset d;

-- 5. Display the "payment type (Type)" and the "current Order Status".
SELECT  
	"Type", 
	"Order Status" 
FROM 
	datacosupplychaindataset d;

-- 6. Select the Sales amount and the actual shipping days (Days for shipping (real)).
SELECT  
	"Sales", 
	"Days for shipping (real)" 
FROM 
	datacosupplychaindataset d;

-- 7. Display the "Customer Fname (first name)", "Customer Lname (last name)", and "Customer Id".
SELECT 
	"Customer Id", 
	"Customer Fname", 
	"Customer Lname" 
FROM 
	datacosupplychaindataset d;

-- 8. Select the "Benefit per order" column and rename it (alias) as order_net_profit.
SELECT 
	"Benefit per order" as order_net_profit 
FROM 
	datacosupplychaindataset d;

-- 9. Display the Product Name and its price (Product Price) renamed as unit_price. 
SELECT  
	"Product Name", 
	"Product Price" as unit_price 
FROM 
	datacosupplychaindataset d;

-- 10. Select the Order Id and calculate double the sales (Sales * 2) to simulate a revenue projection.
SELECT  
	"Order Id", (d."Sales" * 2) as revenue_projection 
FROM 
	datacosupplychaindataset d;

-- 11. Calculate the difference between actual and scheduled shipping days (Days for shipping (real) - Days for shipment (scheduled)).
SELECT 
	"Days for shipping (real)",
	"Days for shipment (scheduled)",
	("Days for shipping (real)" - "Days for shipment (scheduled)") as difference_days 
FROM
	datacosupplychaindataset d;

-- 12. Display all customer cities using DISTINCT to eliminate duplicates.
SELECT DISTINCT
	"Customer City"
FROM 
	datacosupplychaindataset d;

-- 13. Select all unique payment methods (Type) available in the table using DISTINCT.
SELECT DISTINCT 
	"Type"
FROM 
	datacosupplychaindataset d;

-- 14. Display all unique types of Order Status that exist in the dataset.
SELECT DISTINCT 
	"Order Status"
FROM 
	datacosupplychaindataset d;

-- 15. Select the Product Name and calculate an estimated 10% tax column by multiplying Sales * 0.10.
SELECT 
	d."Product Name",
	d."Sales",
	(d."Sales" * 0.10)::NUMERIC(10,2) AS estimated_10_tax
FROM 
	datacosupplychaindataset d;







-- 🛡️ Block 2: WHERE

-- 1. Display all order data where the payment type (Type) is exactly 'DEBIT'.
SELECT 
	*, "Type" 
FROM 
	datacosupplychaindataset d 
WHERE 
	"Type" = 'DEBIT';

-- 2. Filter all orders that belong to the Category Name 'Sporting Goods'.
SELECT
	"Order Id", "Category Name"
FROM 
	datacosupplychaindataset d 
WHERE 
	"Category Name" = 'Sporting Goods';

-- 3. Find all orders that were shipped to the Order City of 'Madrid'.
SELECT 
	"Order Id", "Order City"
FROM 
	datacosupplychaindataset d 
WHERE
	"Order City" = 'Madrid';

-- 4. Display all records where the Order Status is 'COMPLETE'.
SELECT
	"Order Id",
	"Order Status"
FROM 
	datacosupplychaindataset d 
WHERE
	"Order Status" = 'COMPLETE';
	
-- 5. Filter all orders that achieved a Benefit per order strictly greater than 100.
SELECT
	"Order Id",
	"Benefit per order"
FROM 
	datacosupplychaindataset d 
WHERE 
	"Benefit per order" > 100;

-- 6. Find all orders where the total Sales value was less than or equal to 50.
SELECT
	"Order Id",
	"Sales"
FROM 
	datacosupplychaindataset d 
WHERE 
	"Sales" <= 50;

-- 7. Display orders where the actual shipping time (Days for shipping (real)) took more than 5 days.
SELECT 
	"Order Id",
	"Days for shipping (real)"
FROM 
	datacosupplychaindataset d 
WHERE
	"Days for shipping (real)" > 5;

-- 8. Filter rows where actual shipping days were less than scheduled days (Days for shipping (real) < Days for shipment (scheduled)).
SELECT 
	"Order Id",
	"Days for shipping (real)",
	"Days for shipment (scheduled)"
FROM 
	datacosupplychaindataset d 
WHERE
	"Days for shipping (real)" < "Days for shipment (scheduled)";

-- 9. Search for all orders flagged with an Order Status of 'SUSPECTED_FRAUD'.
SELECT
	"Order Id",
	"Order Status"
FROM 
	datacosupplychaindataset d 
WHERE 
	"Order Status" = 'SUSPECTED_FRAUD';

-- 10. Find orders from the category 'Cardio Equipment' that also generated Sales greater than 200 (Use AND).
SELECT
	"Order Id",
	"Category Name",
	"Sales"
FROM 
	datacosupplychaindataset d 
WHERE 
	"Category Name" = 'Cardio Equipment' AND "Sales" > 200

-- 11. Filter orders where the payment method is 'CASH' OR the current Order Status is 'PENDING' (Use OR).
SELECT
	"Order Id",
	"Type",
	"Order Status"
FROM 
	datacosupplychaindataset d 
WHERE
	"Type" = 'CASH' OR "Order Status" = 'PENDING';

-- 12. Find all orders where the business suffered a loss (i.e., Benefit per order is negative/less than 0).
SELECT 
	"Order Id",
	"Benefit per order"
FROM 
	datacosupplychaindataset d 
WHERE 
	"Benefit per order" < 0;

-- 13. Display all orders placed by customers residing in the Customer Country of 'Puerto Rico'.
SELECT  
	"Order Id",
	"Customer Country"
FROM 
	datacosupplychaindataset d 
WHERE 
	"Customer Country" = 'Puerto Rico';

-- 14. Filter products whose Product Price falls between 100 and 300 (Use BETWEEN).
SELECT
	"Product Name",
	"Product Price"
FROM 
	datacosupplychaindataset d 
WHERE
	"Product Price" BETWEEN 100 AND 300;

-- 15. Find all orders with an Order Status of 'CANCELED' where Sales were still recorded as greater than 0.
SELECT
	"Order Id",
	"Order Status",
	"Sales"
FROM 
	datacosupplychaindataset d 
WHERE
	"Order Status" = 'CANCELED' AND "Sales" > 0;






-- 📊 Block 3: GROUP BY & Aggregations

-- 1. Calculate the total number of orders (COUNT(*)) grouped by each Category Name.
SELECT 
	"Category Name",
	COUNT(*) AS total_pedidos
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Category Name";

-- 2. Calculate the total sum of revenue (SUM(Sales)) generated by each payment Type.
SELECT 
	"Type",
	SUM("Sales") AS total_sales
FROM 
	datacosupplychaindataset d 
GROUP BY
	"Type";

-- 3. Find the average profit (AVG(Benefit per order)) for each type of Order Status.
SELECT 
	"Order Status",
	AVG("Benefit per order")::NUMERIC(10,2) AS average_profit
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Order Status";

-- 4. Count how many total orders were placed by customers in each Customer Country.
SELECT  
	"Customer Country",
	COUNT("Order Id") AS total_orders_country
FROM 
	datacosupplychaindataset d 
GROUP BY
	"Customer Country";

-- 5. Find the maximum product price (MAX(Product Price)) within each Category Name.
SELECT 
	"Category Name",
	MAX("Product Price") AS max_product_price
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Category Name";

-- 6. Calculate the average actual shipping days (AVG(Days for shipping (real))) for each Shipping Mode.
SELECT
	 "Shipping Mode",
	 AVG("Days for shipping (real)") AS avg_shipping_days
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Shipping Mode";

-- 7. Calculate the total sum of sales (SUM(Sales)) sent to each destination Order City.
SELECT 
	"Order City",
	SUM("Sales") AS sales_order_city
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Order City";

-- 8. Count the number of unique product names (COUNT(DISTINCT Product Name)) sold under each Category Name.
SELECT 
	"Category Name",
	COUNT(DISTINCT "Product Name") AS distinct_products
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Category Name";

-- 9. Calculate the total profit (SUM(Benefit per order)) generated by each Department Name.
SELECT 
	"Department Name",
	SUM("Benefit per order") AS total_benefit_order
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Department Name";

-- 10. Find the minimum sales amount (MIN(Sales)) recorded in each destination Order Region.
SELECT
	"Order Region",
	MIN("Sales") AS min_sales_region
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Order Region";

-- 11. Display the average scheduled shipment days (AVG(Days for shipment (scheduled))) grouped by payment Type.
SELECT 
	"Type",
	CEIL(AVG("Days for shipment (scheduled)")) AS avg_days_shipment
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Type";

-- 12. Group the data by Product Name to calculate total sales, and sort them from highest to lowest (add ORDER BY SUM(Sales) DESC).
SELECT 
	"Product Name",
	ROUND(SUM("Sales")::NUMERIC (10,2)) AS sales_by_product
FROM 
	datacosupplychaindataset d 
GROUP BY
	"Product Name"
ORDER BY 
	sales_by_product DESC;

-- 13. Calculate the total count of suspected fraud orders grouped by the customer's country 
-- (Combine WHERE Order Status = 'SUSPECTED_FRAUD' before your GROUP BY).
SELECT
	"Customer Country",
	COUNT("Order Status") AS Total_fraud_orders
FROM 
	datacosupplychaindataset d 
WHERE 
	"Order Status" = 'SUSPECTED_FRAUD'
GROUP BY 
	"Customer Country";

-- 14. Display the total sum of sales and the average profit together, grouped by Category Name.
SELECT 
	"Category Name",
	SUM("Sales")::NUMERIC (10,2) AS total_sales,
	AVG("Benefit per order")::NUMERIC (10,2) AS avg_profit
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Category Name"
ORDER BY 
	total_sales DESC,
	avg_profit DESC;

-- 15. Count the total number of orders handled by each target market segment (Customer Segment).
SELECT 
	"Customer Segment",
	COUNT("Order Id") AS num_by_segment
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Customer Segment";







-- 📊 Block 4: HAVING

-- 1. Group by Category Name and show only categories where the total number of orders (COUNT(*)) is greater than 500.
SELECT 
	"Category Name",
	count(*) AS total_orders
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Category Name"
HAVING 
	count(*) > 500;

-- 2. Group by Type (payment method) and show only types where total SUM(Sales) exceeds 1,000,000.
SELECT
	"Type",
	SUM("Sales") AS total_sales
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Type" 
HAVING 
	SUM("Sales") > 1000000
ORDER BY 
	total_sales DESC;

-- 3. Group by Order Status and display only statuses where the average profit (AVG(Benefit per order)) is negative (less than 0).
SELECT
	"Order Status",
	AVG("Benefit per order") AS avg_benefit
FROM
	datacosupplychaindataset d 
GROUP BY 
	"Order Status"
HAVING 
	AVG("Benefit per order") < 0
ORDER BY 
	avg_benefit DESC;

-- 4. Group by Customer Country and filter for countries that have more than 1,000 unique orders.
SELECT 
	"Customer Country",
	COUNT(DISTINCT "Order Id") AS unique_orders
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Customer Country" 
HAVING 
COUNT(DISTINCT "Order Id") > 1000;

-- 5. Group by Product Name and list only products where the maximum price (MAX(Product Price)) is greater than 200.
SELECT 
	"Product Name",
	MAX("Product Price") AS max_price
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Product Name" 
HAVING 
	MAX("Product Price") > 200;

-- 6. Group by Order City and show cities that generated a total profit (SUM(Benefit per order)) of more than 50,000.
SELECT
	"Order City",
	SUM("Benefit per order") AS total_profit
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Order City" 
HAVING 
	SUM("Benefit per order") >= 50000;	

-- 7. Group by Shipping Mode and display only modes where the average actual shipping time (AVG(Days for shipping (real))) 
-- is strictly greater than 4 days.
SELECT 
	"Shipping Mode",
	CEIL(AVG("Days for shipping (real)")) AS avg_ship_time
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Shipping Mode"
HAVING
	(AVG("Days for shipping (real)")) > 4;

-- 8. Group by Department Name and filter for departments where total revenue (SUM(Sales)) is less than 500,000.
SELECT 
	"Department Name",
	ROUND(SUM("Sales")::NUMERIC (10,2)) AS total_revenue
FROM
	datacosupplychaindataset d 
GROUP BY 
	"Department Name"
HAVING 
	SUM("Sales") < 500000
ORDER BY 
	total_revenue DESC;

-- 9. Group by Customer Segment and show segments where the minimum sales value (MIN(Sales)) recorded is greater than 5.
SELECT
	"Customer Segment",
	MIN("Sales") AS min_sale
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Customer Segment"
HAVING 
	MIN("Sales") > 5;

-- 10. Group by Order Region and show regions where suspected fraud cases (COUNT(*)) are higher than 50 
-- (Hint: Use WHERE "Order Status" = 'SUSPECTED_FRAUD' before GROUP BY, then apply HAVING).
SELECT 
	"Order Region",
	COUNT(*) AS total
FROM
	datacosupplychaindataset d 
WHERE 
	"Order Status" = 'SUSPECTED_FRAUD'
GROUP BY
	"Order Region" 
HAVING 
	COUNT(*) > 50
ORDER BY 
	total DESC;

-- 11. Group by Category Name and filter for categories where the average product price is between 50 and 150.
SELECT 
	"Category Name",
	AVG("Product Price")::NUMERIC (10,2) AS avg_price
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Category Name"
HAVING 
	AVG("Product Price") BETWEEN 50 AND 150
ORDER BY 
	avg_price DESC;

-- 12. Group by Customer City and show only cities where the total sum of sales is greater than 100,000, 
-- sorted from highest to lowest sales.
SELECT 
	"Customer City",
	SUM("Sales")::NUMERIC AS total_sales
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Customer City"
HAVING 
	SUM("Sales") > 100000
ORDER BY 
total_sales DESC;

-- 13. Group by Product Name and show products that have been ordered less than 10 times in total.
SELECT
	"Product Name",
	COUNT(*) AS total_products
FROM
	datacosupplychaindataset d 
GROUP BY 
	"Product Name" 
HAVING 
	COUNT(*) < 10;

-- 14. Group by Type and Order Status together, and filter for combinations where the total count of orders is greater than 100.
SELECT 
	"Type",
	"Order Status",
	count(*) AS total_orders
FROM 
	datacosupplychaindataset d 
GROUP BY 
	"Type", "Order Status"
HAVING
	count(*) > 100
ORDER BY 
	total_orders DESC;

-- 15. Group by Department Name and display only those where the average profit per order is greater than 30.
SELECT 
	"Department Name",
	AVG("Benefit per order")::NUMERIC (10,2) AS avg_profit_order
FROM 
	datacosupplychaindataset d 
GROUP BY
	"Department Name"
HAVING 
	AVG("Benefit per order") > 30;






-- 🧠 Block 5: CASE WHEN (15 Exercises)

-- 1. Create a column called profitability_status. If Benefit per order > 0 then 'Profitable', else 'Loss'.
SELECT 
	"Order Id",
	"Benefit per order",
	CASE 
		WHEN "Benefit per order" > 0 THEN 'Profitable' 
		ELSE 'Loss' 
		END AS profitability_status
FROM
	datacosupplychaindataset d;

-- 2. Create a column called shipping_performance. If Days for shipping (real) <= Days for shipment (scheduled) then 'On Time', else 'Delayed'.
SELECT
	"Order Id",
	"Days for shipping (real)",
	"Days for shipment (scheduled)",
	CASE
		WHEN ROUND("Days for shipping (real)") <= ROUND("Days for shipment (scheduled)") THEN 'On Time'
		ELSE 'Delayed' 
	END AS shipping_performance
FROM 
	datacosupplychaindataset d;

-- 3. Segment sales into sales_volume: If Sales > 500 then 'High', if Sales BETWEEN 100 AND 500 then 'Medium', else 'Low'.
SELECT 
	"Order Id",
	"Sales",
	CASE
		WHEN "Sales" > 500 THEN 'High'
		WHEN "Sales" BETWEEN 100 AND 500 THEN 'Medium'
		ELSE 'Low'
	END AS sales_volume
FROM
	datacosupplychaindataset d
ORDER BY 
	"Sales" DESC;

-- 4. Categorize order status into order_group: If Order Status IN ('COMPLETE', 'CLOSED') then 'Finished', 
-- if IN ('PENDING', 'PROCESSING', 'PAYMENT_REVIEW') then 'In Progress', else 'Alert/Cancelled'.
SELECT 
	"Order Id",
	"Order Status",
	CASE
		WHEN "Order Status" IN ('COMPLETE', 'CLOSED') THEN 'Finished'
		WHEN "Order Status" IN ('PENDING', 'PROCESSING', 'PAYMENT_REVIEW') THEN 'In Progress'
		ELSE 'Alert/Cancelled'
	END AS order_group
FROM 
	datacosupplychaindataset d;
	
-- 5. Create a fraud_risk flag: If Order Status = 'SUSPECTED_FRAUD' then 'High Risk', else 'Normal'.
SELECT
	"Order Id",
	"Order Status",
	CASE 
		WHEN "Order Status" = 'SUSPECTED_FRAUD' THEN 'High Risk'
		ELSE 'Normal'
	END AS fraud_risk_flag
FROM 
	datacosupplychaindataset d ;
	

-- 6. Standardize prices into price_tier: If Product Price >= 200 then 'Premium', 
-- if Product Price BETWEEN 50 AND 199.99 then 'Mid-Range', else 'Budget'.
SELECT 
	"Product Name",
	"Product Price",
CASE
	WHEN "Product Price" >= 200 THEN 'Premium'
	WHEN "Product Price" BETWEEN 50 AND 199.99 THEN 'Mid-Range'
	ELSE 'Budget'
END AS price_tier
FROM 
	datacosupplychaindataset d;

-- 7. Create a column delivery_speed: If Days for shipping (real) <= 2 then 'Express', if between 3 and 5 then 'Standard', else 'Slow'.
SELECT 
	"Order Id",
	"Days for shipping (real)",
	CASE 
		WHEN "Days for shipping (real)" <= 2 then 'Express'
		WHEN "Days for shipping (real)" BETWEEN 3 AND 5 THEN 'Standard'
		ELSE 'Slow'
	END AS delivery_speed
FROM 
	datacosupplychaindataset d;
	
-- 8. Create a column is_local: If Customer Country = 'EE. UU.' (or 'United States') then 'Domestic', else 'International'.
SELECT
	"Customer Country",
	CASE 
		WHEN "Customer Country" = 'EE. UU.' THEN 'Domestic'
		ELSE 'International'
	END AS is_local
FROM 
	datacosupplychaindataset d;

-- 9. Check benefit metrics: If Benefit per order > 500 then 'Excellent Profit', if between 0 and 500 then 'Standard Profit', 
-- else 'Negative Impact'.
SELECT
	"Benefit per order",
	CASE 
		WHEN "Benefit per order" > 500 THEN 'Excellent Profit' 
		WHEN "Benefit per order" BETWEEN 0 AND 500 THEN 'Standard Profit'
		ELSE 'Negative Impact'
	END AS benefit_metrics
FROM
	datacosupplychaindataset d ;
	
-- 10. Assign a numeric priority score based on Shipping Mode: If 'First Class' then 1, if 'Second Class' then 2, else 3.
SELECT 
	"Shipping Mode",
	CASE 
		WHEN "Shipping Mode" = 'First Class' THEN 1
		WHEN "Shipping Mode" = 'Second Class' THEN 2 
		ELSE 3
	END AS numeric_priority
FROM 
	datacosupplychaindataset d ;
	
-- 11. Label customer segments: If Customer Segment = 'Consumer' then 'B2C', else 'B2B'.
SELECT 
	"Customer Segment",
	CASE
		WHEN "Customer Segment" = 'Consumer' THEN 'B2C'
		ELSE 'B2B'
	END AS customer_segments
FROM
	datacosupplychaindataset d ;

-- 12. Flag expensive items: If Product Price > (SELECT AVG("Product Price") 
--FROM datacosupplychaindataset) then 'Above Average', else 'Below Average' (Advanced practice!).
SELECT 
	"Product Price",
	CASE 
		WHEN "Product Price" > (SELECT AVG("Product Price") FROM datacosupplychaindataset) then 'Above Average'
		ELSE 'Below Average'
	END AS expensive_items
FROM
	datacosupplychaindataset d ;

-- 13. Group payment types: If Type IN ('CASH', 'DEBIT', 'TRANSFER') then 'Traditional', else 'Electronic'.
SELECT 
	"Type",
	CASE
		WHEN "Type" IN ('CASH', 'DEBIT', 'TRANSFER') THEN 'Traditional'
		ELSE 'Electronic'
	END AS payment_types
FROM
	datacosupplychaindataset d ;
	
-- 14. dentify zero-value orders: If Sales = 0 OR Sales IS NULL then 'Void Order', else 'Valid Transaction'.
SELECT 
	"Sales",
	CASE
	WHEN "Sales" = 0 OR "Sales" IS NULL THEN 'Void Order'
	ELSE 'Valid Transaction'
	END AS zero_value_orders
FROM
	datacosupplychaindataset d ;

-- 15. Combine conditions: If Order Status = 'COMPLETE' AND Benefit per order > 100 then 'Top Order', else 'Standard Order'.
SELECT
	"Order Id",
	"Benefit per order",
	"Order Status",
	CASE
		WHEN "Order Status" = 'COMPLETE' AND "Benefit per order" > 100 THEN 'Top Order'
		ELSE 'Standard Order'
	END AS order_condition
FROM 
	datacosupplychaindataset d ;
	











-- 🔤 Block 6: UPPER, LOWER, CONCAT, SUBSTRING

-- 1. Display Customer Fname in all uppercase characters using UPPER.
SELECT
	UPPER("Customer Fname") AS upper_mayus
FROM
	datacosupplychaindataset d ;

-- 2. Display Category Name in all lowercase characters using LOWER.
SELECT
	LOWER("Customer Fname") AS upper_mayus
FROM
	datacosupplychaindataset d ;

-- 3. Combine Customer Fname and Customer Lname into a single column called full_name using CONCAT (include a space between them).
SELECT
	CONCAT("Customer Fname", ' ' , "Customer Lname") AS full_name
FROM 
	datacosupplychaindataset d ;

-- 4. Extract just the first 3 characters of the Customer Country using SUBSTRING.
SELECT
	SUBSTRING("Customer Country", 1, 3) AS short_country
FROM 
	datacosupplychaindataset d ;

-- 5. Create a clean mailing label: Combine Customer City and Customer Country into a format like "City, Country" using CONCAT.
SELECT 
	CONCAT("Customer City", ', ', "Customer Country") AS city_country
FROM
	datacosupplychaindataset d ;

-- 6. Display the Product Name in uppercase and its Order Status in lowercase in the same query.
SELECT
	UPPER("Product Name") AS product_mayus,
	LOWER("Order Status") AS orderst_min
FROM 
	datacosupplychaindataset d ;

-- 7. Filter rows using text functions: Find all records where the lowercase version of Order Status is exactly 'complete' (using LOWER).
SELECT
	*	
FROM 
	datacosupplychaindataset d
WHERE
	LOWER("Order Status") = 'complete';

-- 8. Format customer names so they look like "LASTNAME, Firstname" using a combination of UPPER, CONCAT, and the original column.
SELECT 
	CONCAT(UPPER("Customer Lname"), ', ', "Customer Fname") AS last_firsname
FROM 
	datacosupplychaindataset d ;

-- 9. Extract the first character of the Type column to create a quick one-letter code (e.g., 'D' for Debit).
SELECT 
	SUBSTRING("Type",1,1) AS short_type
FROM 
	datacosupplychaindataset d ;

-- 10. Find the length of characters in the Product Name column (Bonus function: Use LENGTH("Product Name")).
SELECT
	"Product Name",
	LENGTH("Product Name") AS lenght_prod
FROM 
	datacosupplychaindataset d ;

-- 11. Use CONCAT to add a dollar sign currency symbol in front of the Sales column (e.g., '$150.00') by casting it to text.
SELECT
	"Sales" AS original,
	CONCAT('$',"Sales") AS sales_dollar
FROM 
	datacosupplychaindataset d ;

-- 12. Extract the last 4 characters of the Order City column.
SELECT 
	RIGHT("Order City", 4) AS ord_city
FROM 
	datacosupplychaindataset d ;

-- 14. Create a custom reference code combining the first 2 letters of Category Name (in uppercase) and the Order Id (e.g., 'SP-10452').
SELECT 
	CONCAT(UPPER(SUBSTRING("Category Name",1,2)),'-' ,"Order Id") AS reference_code
FROM 
	datacosupplychaindataset d ;

-- 15. Filter orders where the Product Name contains a specific keyword, ensuring it works regardless of capitalization
-- by using LOWER("Product Name") LIKE '%sport%'.
SELECT 
	"Order Id",
	"Product Name"
FROM 
	datacosupplychaindataset d 
WHERE 
	LOWER("Product Name") LIKE '%sport%';







-- 📅 Block 7: EXTRACT or DATE_TRUNC

-- 1. Extract the Year from the order date column.
SELECT
	"order date (DateOrders)",
	EXTRACT(YEAR FROM TO_TIMESTAMP ("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS order_year
FROM 
	datacosupplychaindataset d;

-- 2. Extract the Month (number from 1 to 12) from the order date column.
SELECT 
	"order date (DateOrders)",
	EXTRACT (MONTH FROM TO_TIMESTAMP ("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS order_month
FROM
	datacosupplychaindataset d ;

-- 3. Extract the Day of the week (0 = Sunday or 1 = Monday depending on settings) from the order date.
SELECT 
	"order date (DateOrders)",
	EXTRACT (DOW FROM TO_TIMESTAMP ("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS order_dow
FROM
	datacosupplychaindataset d;

-- 4. Extract the specific Day of the month from the order date.
SELECT
	"order date (DateOrders)",
	EXTRACT(DAY FROM TO_TIMESTAMP ("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS order_month_day
FROM
	datacosupplychaindataset d;

-- 5. Extract the Hour of the day from the order date to see when customers buy the most.
SELECT
	EXTRACT(HOUR FROM TO_TIMESTAMP ("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS order_hour,
	COUNT(*) AS total_orders
FROM
	datacosupplychaindataset d
GROUP BY
	order_hour
ORDER BY
	total_orders DESC;

-- 6. Use DATE_TRUNC to truncate the order date to the Month level (setting all days to the 1st of that month).
SELECT 
	"order date (DateOrders)" AS original,
	DATE_TRUNC('month', TO_TIMESTAMP("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS month_truncated
FROM
	datacosupplychaindataset d ;

-- 7. Use DATE_TRUNC to truncate the order date to the Year level.
SELECT 
	DATE_TRUNC('year', TO_TIMESTAMP("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS year_only
FROM 
datacosupplychaindataset d
GROUP BY 
year_only
ORDER BY 
year_only DESC;

-- 8. Group the total sum of Sales by order Year (using EXTRACT or DATE_TRUNC in the GROUP BY).
SELECT 
	DATE_TRUNC('year', TO_TIMESTAMP("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS year_only
FROM 
datacosupplychaindataset d
GROUP BY 
year_only
ORDER BY 
year_only DESC

-- 9. Count the number of total orders processed per Month of the year.
SELECT 
	DATE_TRUNC('month', TO_TIMESTAMP("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS month_year,
	COUNT(*) AS total_orders	
FROM
	datacosupplychaindataset d 
GROUP BY 
	month_year
ORDER BY 
	month_year ASC;

-- 10. Calculate the average profit (AVG(Benefit per order)) grouped by the Hour of the day.
SELECT 
	EXTRACT (HOUR FROM TO_TIMESTAMP ("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS order_hour,
	AVG("Benefit per order")::NUMERIC (10,2) AS avg_profut
FROM
	datacosupplychaindataset d 
GROUP BY
	order_hour
ORDER BY
	order_hour;

-- 11. Group total sales by both Year and Month combined using DATE_TRUNC('month', ...).
SELECT 
	DATE_TRUNC('month', TO_TIMESTAMP("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS month_year,
	SUM("Sales") AS total_sales
FROM
	datacosupplychaindataset d 
GROUP BY 
	month_year
ORDER BY 
	month_year DESC;

-- 12. Filter the dataset using WHERE to show only orders placed in the Year 2017.
SELECT 
	"Order Id",
	EXTRACT (YEAR FROM TO_TIMESTAMP ("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS order_year
FROM 
datacosupplychaindataset d
WHERE 
	EXTRACT (YEAR FROM TO_TIMESTAMP ("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) = 2017;

-- 13. Filter the dataset to show only orders placed during Hour 14 (2:00 PM).
SELECT
	"Order Id",
	EXTRACT (HOUR FROM TO_TIMESTAMP ("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS order_hour
FROM
	datacosupplychaindataset d
WHERE
	EXTRACT (HOUR FROM TO_TIMESTAMP ("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) = 14;

-- 14. Group by Day of the week to find out which day generates the highest average sales amount.
SELECT
	EXTRACT (DOW FROM TO_TIMESTAMP ("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS order_dow,
	AVG("Sales")::NUMERIC(10,2) AS avgsales_dow
FROM
	datacosupplychaindataset d
GROUP BY 
	order_dow
ORDER BY
	avgsales_dow DESC;

-- 15. Find the maximum shipping delay (MAX(Days for shipping (real))) grouped by the Quarter of the year (using EXTRACT(QUARTER FROM ...)).
SELECT
    EXTRACT(QUARTER FROM TO_TIMESTAMP("order date (DateOrders)", 'MM/DD/YYYY HH24:MI')) AS order_quarter,
    MAX("Days for shipping (real)") AS max_shipping_delay
FROM
    datacosupplychaindataset d
GROUP BY
    order_quarter
ORDER BY
    order_quarter;