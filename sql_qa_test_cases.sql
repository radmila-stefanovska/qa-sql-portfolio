USE qa_portfolio;

-- =====================================================
-- SQL QA TEST CASES
-- Project: QA SQL Portfolio
-- =====================================================

-- TC_SQL_001
-- Verify Active Products
-- Expected Result:
-- Only active products should be returned.
SELECT * FROM products
WHERE is_active = TRUE;

-- TC_SQL_002
-- Verify Inactive Products
-- Expected Result:
-- Only inactive products should be returned.
SELECT * FROM products
WHERE is_active = FALSE;

-- TC_SQL_003
-- Verify Out of Stock Products
-- Expected Result:
-- Only products with stock = 0 should be returned.
SELECT * FROM products
WHERE stock = 0;

-- TC_SQL_004
-- Verify No Negative Product Prices
-- Expected Result:
-- 0 rows should be returned.
SELECT * FROM products
WHERE price < 0;

-- TC_SQL_005
-- Verify No Active Products Have Zero Stock
-- Expected Result:
-- 0 rows should be returned.
SELECT * FROM products
WHERE is_active = TRUE
AND stock = 0;

-- TC_SQL_006
-- Verify Product Sorting (Low to High)
SELECT * FROM products
ORDER BY price ASC;

-- TC_SQL_007
-- Verify Product Sorting (High to Low)
SELECT * FROM products
ORDER BY price DESC;

-- Test Case ID: TC_SQL_008
-- Title: Verify that there are no duplicate product names
-- Expected Result: No product name should appear more than once
SELECT name, COUNT(*) AS duplicate_count
FROM products
GROUP BY name
HAVING COUNT(*) > 1;

-- Test Case ID: TC_SQL_009
-- Title: Verify that user emails are unique
-- Expected Result: 0 rows should be returned
SELECT email, COUNT(*) AS duplicate_count
FROM users
GROUP BY email
HAVING COUNT(*) > 1;

-- Test Case ID: TC_SQL_010
-- Title: Verify that no user has a missing email
-- Expected Result: 0 rows should be returned
SELECT * FROM users
WHERE email IS NULL;

-- Test Case ID: TC_SQL_011
-- Title: Verify that user first name and last name are populated
-- Expected Result: 0 rows should be returned
SELECT * FROM users
WHERE first_name IS NULL
   OR last_name IS NULL;

-- Test Case ID: TC_SQL_012
-- Title: Verify that all user emails contain the @ symbol
-- Expected Result: 0 rows should be returned
SELECT * FROM users
WHERE email NOT LIKE '%@%';

-- Test Case ID: TC_SQL_013
-- Title: Verify that all orders have a positive quantity
-- Expected Result: 0 rows should be returned
SELECT * FROM orders
WHERE quantity <= 0;

-- Test Case ID: TC_SQL_014
-- Title: Verify that every order belongs to an existing user
-- Expected Result: 0 rows should be returned
SELECT
    orders.id AS order_id,
    orders.user_id
FROM orders
LEFT JOIN users
    ON users.id = orders.user_id
WHERE users.id IS NULL;

-- Test Case ID: TC_SQL_015
-- Title: Verify that all orders have a valid product name
-- Expected Result: 0 rows should be returned
SELECT * FROM orders
WHERE product IS NULL;

-- Test Case ID: TC_SQL_016
-- Title: Verify that product quantity is greater than zero
-- Expected Result: 0 rows should be returned
SELECT * FROM orders
WHERE quantity <= 0;

-- Test Case ID: TC_SQL_017
-- Title: Verify that every order belongs to an existing user
-- Expected Result: 0 rows should be returned
SELECT
    orders.id,
    orders.user_id
FROM orders
LEFT JOIN users
ON orders.user_id = users.id
WHERE users.id IS NULL;

-- Test Case ID: TC_SQL_018
-- Title: Verify each order displays the correct customer
-- Expected Result:
-- Every order should be linked to an existing customer.
SELECT
    users.first_name,
    users.last_name,
    orders.product,
    orders.quantity
FROM users
INNER JOIN orders
ON users.id = orders.user_id;

-- Test Case ID: TC_SQL_019
-- Title: Verify users without any orders
-- Expected Result:
-- Only users without orders should be returned.
SELECT
    users.first_name,
    users.last_name
FROM users
LEFT JOIN orders
ON users.id = orders.user_id
WHERE orders.id IS NULL;

-- Test Case ID: TC_SQL_020
-- Title: Verify that every ordered product exists in the products table
-- Expected Result: 0 rows should be returned
SELECT
    orders.id AS order_id,
    orders.product
FROM orders
LEFT JOIN products
    ON orders.product = products.name
WHERE products.id IS NULL;

-- Test Case ID: TC_SQL_021
-- Title: Verify that all product prices are greater than zero
-- Expected Result: 0 rows should be returned
SELECT * FROM products
WHERE price <= 0;

-- Test Case ID: TC_SQL_022
-- Title: Verify that product stock is not negative
-- Expected Result: 0 rows should be returned
SELECT * FROM products
WHERE stock < 0;

-- Test Case ID: TC_SQL_023
-- Title: Verify that inactive products are not included in active product results
-- Expected Result: Only active products should be returned
SELECT * FROM products
WHERE is_active = TRUE;

-- Test Case ID: TC_SQL_024
-- Title: Verify that each order displays the correct product price
-- Expected Result: Every order should match an existing product and its stored price
SELECT
    orders.id AS order_id,
    users.first_name,
    users.last_name,
    orders.product,
    orders.quantity,
    products.price
FROM orders
INNER JOIN users
    ON orders.user_id = users.id
INNER JOIN products
    ON orders.product = products.name;
    
-- Test Case ID: TC_SQL_025
-- Title: Verify the calculated total for each order
-- Expected Result: calculated_total should equal quantity multiplied by product price
SELECT
    orders.id AS order_id,
    users.first_name,
    orders.product,
    orders.quantity,
    products.price,
    orders.quantity * products.price AS calculated_total
FROM orders
INNER JOIN users
    ON orders.user_id = users.id
INNER JOIN products
    ON orders.product = products.name;
    
-- TC_SQL_026
-- Verify users can be searched by email
-- Expected Result:
-- Only the matching user should be returned.
SELECT * FROM users
WHERE email = 'john@test.com';


-- TC_SQL_027
-- Verify users can be searched by partial first name
-- Expected Result:
-- Only users whose first name starts with J should be returned.
SELECT * FROM users
WHERE first_name LIKE 'J%';

-- TC_SQL_028
-- Verify users are sorted alphabetically
-- Expected Result:
-- Users should be returned from A to Z by first name.
SELECT * FROM users
ORDER BY first_name ASC;

-- TC_SQL_029
-- Verify newest users are returned first
-- Expected Result:
-- User with the highest ID should be returned first.
SELECT * FROM users
ORDER BY id DESC;

-- TC_SQL_030
-- Verify total number of users
-- Expected Result:
-- The query should return the current number of users.
SELECT COUNT(*) AS total_users
FROM users;

-- TC_SQL_031
-- Verify total number of active products
-- Expected Result:
-- The query should return the number of active products.
SELECT COUNT(*) AS active_products
FROM products
WHERE is_active = TRUE;

-- TC_SQL_032
-- Verify product count by category
-- Expected Result:
-- Products should be grouped and counted by category.
SELECT
    category,
    COUNT(*) AS product_count
FROM products
GROUP BY category;

-- TC_SQL_033
-- Verify categories with more than two products
-- Expected Result:
-- Only categories containing more than two products should be returned.
SELECT
    category,
    COUNT(*) AS product_count
FROM products
GROUP BY category
HAVING COUNT(*) > 2;

-- TC_SQL_034
-- Verify minimum and maximum product prices
-- Expected Result:
-- The query should return the lowest and highest product prices.
SELECT
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM products;

-- TC_SQL_035
-- Verify average product price
-- Expected Result:
-- The query should return the average price of all products.
SELECT AVG(price) AS average_price
FROM products;

-- TC_SQL_036
-- Verify number of orders per user
-- Expected Result:
-- Each user with orders should display the correct order count.
SELECT
    users.id,
    users.first_name,
    users.last_name,
    COUNT(orders.id) AS order_count
FROM users
LEFT JOIN orders
    ON users.id = orders.user_id
GROUP BY
    users.id,
    users.first_name,
    users.last_name;

-- TC_SQL_037
-- Verify users with more than one order
-- Expected Result:
-- Only users with more than one order should be returned.
SELECT
    users.id,
    users.first_name,
    users.last_name,
    COUNT(orders.id) AS order_count
FROM users
INNER JOIN orders
    ON users.id = orders.user_id
GROUP BY
    users.id,
    users.first_name,
    users.last_name
HAVING COUNT(orders.id) > 1;

-- TC_SQL_038
-- Verify total quantity ordered for each product
-- Expected Result:
-- Each product should display the total ordered quantity.
SELECT
    orders.product,
    SUM(orders.quantity) AS total_quantity_ordered
FROM orders
GROUP BY orders.product;

-- TC_SQL_039
-- Verify total order value per user
-- Expected Result:
-- Each user should display the total value of all their orders.
SELECT
    users.id,
    users.first_name,
    users.last_name,
    SUM(orders.quantity * products.price) AS total_order_value
FROM users
INNER JOIN orders
    ON users.id = orders.user_id
INNER JOIN products
    ON orders.product = products.name
GROUP BY
    users.id,
    users.first_name,
    users.last_name;

-- TC_SQL_040
-- Verify duplicate order records
-- Expected Result:
-- 0 rows should be returned if duplicate orders are not allowed.
SELECT
    user_id,
    product,
    quantity,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY
    user_id,
    product,
    quantity
HAVING COUNT(*) > 1;   
    
    