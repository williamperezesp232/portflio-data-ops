SELECT 
	*
FROM 
	products p
JOIN order_details od ON p.product_id = od.product_id;
	
-- Total sales by product and category, sorted in descending order.SELECT 
	p.category_id,
	p.product_name,
	SUM(od.unit_price * od.quantity)::NUMERIC (10,2) AS total_sales
FROM 
	products p
JOIN 
	order_details od ON p.product_id  = od.product_id
GROUP BY 
	p.category_id, p.product_name
ORDER BY 
	total_sales DESC;


-- Block 1: Basic JOINs Between Two Tables

-- 1. Display the order ID (order_id), order date (order_date) from the orders table, 
-- and the customer's company name (company_name) from the customers table.
SELECT 
	ord.order_id,
	ord.order_date,
	cus.company_name
FROM 
	orders ord
JOIN
	customers cus ON ord.customer_id = cus.customer_id; 

-- 2. Join the products and categories tables to show the product name (product_name) alongside its category name (category_name).
SELECT 
	p.product_name,
	c.category_name 
FROM 
	products p
JOIN
	categories c ON p.category_id = c.category_id
ORDER by 
	c.category_name;

-- 3. Combine the employees (employees) and orders (orders) tables to list which employee 
-- (first name and last name) processed each order (order_id).
SELECT
	o.order_id,
	e.first_name,
	e.last_name 
FROM
	employees e
JOIN 
	orders o ON e.employee_id = o.employee_id;

-- 4. Join the products and suppliers tables to see which supplier (company_name from suppliers) provides each product (product_name).
SELECT 
	p.product_name,
	s.company_name	 
FROM 
	products p
JOIN 
	suppliers s ON p.supplier_id = s.supplier_id
ORDER BY 
	s.company_name;

-- 5. Connect the orders table with the shippers (shippers) table to display the order ID and the 
-- company name of the shipper (company_name from shippers) that delivered it.
SELECT 
	o.order_id,
	s.company_name 
FROM 
	orders o 
JOIN 
	shippers s ON o.ship_via = s.shipper_id;

-- 6. Display all details from the order details table (order_details) along with the corresponding product name (product_name) for each row.
SELECT 
	od.*,
	p.product_name 
FROM 
	order_details od 
JOIN 
	products p ON od.product_id = p.product_id;

-- 7. Create a query showing product names (product_name) and their supplier names, 
-- but filter the results to display only products that are out of stock (units_in_stock = 0).
SELECT 
	p.product_name,
	s.company_name 
FROM 
	products p 
JOIN 
	suppliers s ON p.supplier_id = s.supplier_id
WHERE
	p.units_in_stock = 0;

-- 8. List order IDs (order_id) alongside the customer's country (country), filtering to show only
--  orders from customers located in 'France' or 'Germany'.
SELECT 
	o.order_id,
	c.country 
FROM 
	orders o 
JOIN 
	customers c ON o.customer_id = c.customer_id 
WHERE 
	c.country = 'France' OR c.country ='Germany'
ORDER BY
	c.country;

-- 9. Display employee names and the orders they managed, but filter to show only orders placed during the year 1997.
SELECT 
	o.order_id,
	e.first_name,
	e.last_name,
	EXTRACT(YEAR FROM o.order_date) AS year
FROM 
	employees e 
JOIN 
	orders o ON e.employee_id = o.employee_id
WHERE
	EXTRACT(YEAR FROM o.order_date) = 1997;

-- 10. Join products with categories and display the names of products that belong strictly to the 'Beverages' category.
SELECT 
	p.product_name,
	c.category_name 
FROM 
	products p 
JOIN 
	categories c ON p.category_id = c.category_id 
WHERE
	c.category_name = 'Beverages';






-- Block 2: JOINs Combined with Aggregations

-- 1. Count how many total orders each customer has placed. Display the customer's company name (company_name) and their total order count.
SELECT 
	c.company_name,
	COUNT("order_id") AS total_orders	 
FROM 
	orders o 
JOIN 
	customers c ON o.customer_id = c.customer_id
GROUP BY 
	c.company_name
ORDER BY 
	total_orders DESC;

-- 2. Calculate the total revenue generated (SUM(unit_price * quantity)) by each employee. 
-- Display the employee's first and last name along with their total sales.
SELECT 
	e.first_name,
	e.last_name,
	SUM(od.unit_price * od.quantity):: NUMERIC (10,2) AS total_rev_empl
FROM 
	order_details od 
JOIN 
	orders o ON od.order_id = o.order_id 
JOIN
	employees e ON e.employee_id = o.employee_id
GROUP BY 
	e.first_name, e.last_name
ORDER BY 
	total_rev_empl;

-- 3. Display each category name (category_name) and the average unit price of its products (AVG(unit_price)).
SELECT 
	c.category_name,
	AVG(p.unit_price):: NUMERIC (10,2) AS avg_price
FROM 
	categories c 
JOIN 
	products p ON c.category_id = p.category_id
GROUP BY 
	c.category_name
ORDER BY 
	avg_price DESC;

-- 4. Count how many different products each supplier provides. Display the supplier's company name (company_name) 
-- and the total count of products.
SELECT
	s.company_name,
	COUNT(p.product_id ) AS total_products
FROM 
	products p 
JOIN 
	suppliers s ON p.supplier_id = s.supplier_id
GROUP BY 
	s.company_name
ORDER BY 
	total_products DESC;

-- 5. Calculate the total units sold (SUM(quantity)) for each product. Display the product_name and the total units sold.
SELECT 
	p.product_name,
	SUM(quantity) AS total_sold
FROM
	order_details od 
JOIN 	
	products p ON od.product_id = p.product_id
GROUP BY 
	p.product_name
ORDER BY 
	total_sold DESC;
	
-- 6. Find customers who have placed more than 15 total orders. Display their company_name and the total order count (Hint: Use HAVING).
SELECT 
	c.contact_name,
	c.company_name,
	COUNT(o.order_id) AS total_orders
FROM 	
	customers c 
JOIN 
	orders o ON c.customer_id = o.customer_id
GROUP BY
	c.contact_name, c.company_name
HAVING 
	COUNT(o.order_id) > 15
ORDER BY 
	total_orders DESC;

-- 7. Display categories that have an average product unit price greater than 30 dollars.
SELECT
	c.category_name,
	avg(p.unit_price)::numeric(10,2) AS avg_products
FROM 
	categories c 
JOIN 
	products p ON c.category_id = p.category_id
GROUP BY 
	c.category_name
HAVING
	avg(p.unit_price) > 30;

-- 8. Calculate the total freight expenses (SUM(freight)) grouped by the shipping company name (company_name from the shippers table).
SELECT 
	s.company_name,
	SUM(o.freight):: NUMERIC (10,2) AS total_exp
FROM 
	orders o 
JOIN 
	shippers s ON o.ship_via = s.shipper_id
GROUP BY
	s.company_name;





-- Block 3: JOINs of Three or More Tables

-- 1. The Week 2 Classic: Join order_details, products, and categories to display total sales (SUM(unit_price * quantity)) 
-- grouped by category name and product name.
SELECT 
	c.category_name,
	p.product_name,
	SUM(od.unit_price * od.quantity):: numeric(10,2) AS total_sales
FROM 
	order_details od 
JOIN 
	products p ON od.product_id = p.product_id 
JOIN
	categories c ON p.category_id = c.category_id
GROUP BY 
	c.category_name, p.product_name
ORDER BY 
	total_sales DESC;
	
-- 2. Join customers, orders, and employees to see which employee assisted which customer. 
-- Display the customer's company_name and the full name of the employee.
SELECT 
	CONCAT(e.first_name,' ', e.last_name) AS employee_full_name,
	c.company_name 
FROM 
	customers c 
JOIN 
	orders o ON c.customer_id = o.customer_id 
JOIN
	employees e ON o.employee_id = e.employee_id;

-- 3. Combine orders, order_details, and products to list the order ID, the date it was placed, 
-- and the names of all products purchased in that specific order.
SELECT 
	o.order_id,
	o.order_date,
	p.product_name 
FROM 
	orders o
JOIN 
	order_details od ON o.order_id = od.order_id 
JOIN
	products p ON od.product_id = p.product_id
ORDER by 
	p.product_name;

-- 4. Cross-reference categories, products, and suppliers to create a report showing the category name, 
-- product name, and the company name of the supplier selling it.
SELECT
	p.product_name,
	s.company_name,
	c.category_name 
FROM 
	categories c 
JOIN 
	products p ON c.category_id = p.category_id 
JOIN
	suppliers s ON p.supplier_id = s.supplier_id
ORDER BY 
	s.company_name, c.category_name;

-- 5. Join customers, orders, and shippers to show which shipping company handled the orders for each customer. 
-- Display the customer's company_name and the shipper's company_name.
SELECT 
	o.order_id,
	c.company_name,
	s.company_name 
FROM 
	customers c 
JOIN 
	orders o ON C.customer_id = o.customer_id 
JOIN
	shippers s ON o.ship_via = s.shipper_id
ORDER BY 
	c.company_name, s.company_name;

-- 6. Calculate total sales by customer country and product category. You will need to join 5 tables: 
-- customers, orders, order_details, products, and categories. Display the country, category_name, and the total sales sum.
SELECT
	c.country,
	p.product_name,
	c2.category_name,
	SUM(od.unit_price * od.quantity):: NUMERIC (10,2) AS total_sales
FROM 
	customers c 
JOIN 
	orders o ON c.customer_id = o.customer_id 
JOIN
	order_details od ON o.order_id = od.order_id 
JOIN
	products p ON od.product_id = p.product_id 
JOIN
	categories c2 ON p.category_id = c2.category_id
GROUP BY 
	c.country, p.product_name, c2.category_name
ORDER BY 
	total_sales DESC;


WITH product_rotation AS (
    SELECT 
        o.ship_country AS region,
        p.product_name,
        SUM(od.quantity) AS total_units_sold
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY o.ship_country, p.product_name
),
ranked_products AS (
    SELECT 
        region,
        product_name,
        total_units_sold,
        RANK() OVER (PARTITION BY region ORDER BY total_units_sold DESC) AS rotation_rank
    FROM product_rotation
)
SELECT * 
FROM ranked_products 
WHERE rotation_rank = 1;



WITH product_sales AS (
    SELECT 
        c.category_name,
        p.product_name,
        SUM(od.unit_price * od.quantity) AS total_sales
    FROM categories c
    JOIN products p ON c.category_id = p.category_id
    JOIN order_details od ON p.product_id = od.product_id
    GROUP BY c.category_name, p.product_name
),
ranked_products AS (
    SELECT 
        category_name,
        product_name,
        total_sales,
        RANK() OVER (
            PARTITION BY category_name 
            ORDER BY total_sales DESC
        ) AS rank_position
    FROM product_sales
)
SELECT 
    category_name,
    product_name,
    total_sales
FROM ranked_products
WHERE rank_position = 1
ORDER BY total_sales DESC;





-- 1. Top Products by Units in Stock: Find the top 3 products with the highest inventory (units_in_stock) 
-- within each category. (products, categories)
WITH units_in_stock AS (
	SELECT 
		p.product_name, 
		c.category_name,
		p.units_in_stock AS total_units
	FROM products p 
	JOIN categories c ON p.category_id  = c.category_id
),
ranking_stock AS (
	SELECT
		product_name, 
		category_name,
		total_units,
	RANK() OVER(
		PARTITION BY category_name
		ORDER BY total_units DESC
		) AS top_products
	FROM units_in_stock
)
SELECT
	category_name,
	product_name,
	total_units,
	top_products
FROM ranking_stock
WHERE top_products <= 3
ORDER BY category_name, top_products;
	

-- 2. Most Expensive Product by Supplier: Identify the most expensive product (unit_price) 
-- provided by each supplier. (products, suppliers)
WITH most_expensive AS (
	SELECT 
	p.product_name,
	s.company_name,
	p.unit_price
FROM
	products p 
JOIN suppliers s ON p.supplier_id = s.supplier_id
),
ranking_price AS (
SELECT 
	product_name,
	company_name,
	unit_price,
RANK() OVER(
	PARTITION BY company_name
	ORDER BY unit_price DESC
	) AS top_price
FROM most_expensive
)
SELECT 
	product_name,
	company_name,
	unit_price,
	top_price
FROM 
	ranking_price
WHERE top_price = 1
ORDER BY company_name;

-- 3. Top Customers by Total Freight Paid: For each country, rank customers based 
-- on the total freight expenses (SUM(freight)) they generated on their orders. (customers, orders)
WITH total_freight AS (
	SELECT
		c.contact_name,
		o.ship_country,
		SUM(freight):: numeric(10,2) AS total_expenses
	FROM
		orders o
	JOIN customers c ON o.customer_id = c.customer_id
	GROUP BY c.contact_name, o.ship_country
),
ranking_customers AS (
	SELECT 
		contact_name,
		ship_country,
		total_expenses,
	RANK() OVER(
			PARTITION BY ship_country
			ORDER BY total_expenses DESC
	) AS top_customers
	FROM total_freight
)
SELECT 
	contact_name,
	ship_country,
	total_expenses
FROM
	ranking_customers 
WHERE top_customers = 1
ORDER BY ship_country;

-- 4. Top Customer by Year: Find the #1 customer who spent the most money during each individual year (1996, 1997, 1998). 
-- (customers, orders, order_details)
WITH customer_spending AS (
	SELECT 
		EXTRACT(YEAR FROM o.order_date) AS order_year,
		c.company_name,
		SUM(od.unit_price * od.quantity)::NUMERIC(10,2) AS total_spent
	FROM 
		orders o
	JOIN 
		customers c ON o.customer_id = c.customer_id
	JOIN 
		order_details od ON o.order_id = od.order_id
	GROUP BY 
		EXTRACT(YEAR FROM o.order_date),
		c.company_name
),
ranking_customers AS (
	SELECT 
		order_year,
		company_name,
		total_spent,
		RANK() OVER(
			PARTITION BY order_year 
			ORDER BY total_spent DESC
		) AS top_customer
	FROM 
		customer_spending
)
SELECT 
	order_year,
	company_name,
	total_spent
FROM 
	ranking_customers
WHERE 
	top_customer = 1
ORDER BY 
	order_year ASC;