DROP DATABASE IF EXISTS pizza_restaurant;
CREATE DATABASE pizza_restaurant;
use pizza_restaurant;

CREATE TABLE customer (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_name VARCHAR(100),
  phone VARCHAR(25)
);

CREATE TABLE customer_order (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  -- total_price DECIMAL(10,2),
  delivery_time TIMESTAMP,
  customer_id INT,
  foreign key (customer_id) references customer (customer_id)
);

CREATE TABLE standard_pizza (
  standard_pizza_id INT PRIMARY KEY AUTO_INCREMENT,
  st_pizza_name VARCHAR(200),
  price DECIMAL(10,2)
);

CREATE TABLE order_standard_pizza (
  order_standard_pizza_id INT PRIMARY KEY AUTO_INCREMENT,
  standard_pizza_id INT, 
  order_id INT NOT NULL,
  quantity INT,
  foreign key (order_id) references customer_order (order_id),
  foreign key (standard_pizza_id ) references standard_pizza (standard_pizza_id)
);

INSERT INTO customer(customer_name, phone)
	VALUES ('Trevor Page', '226-555-4982'), ('John Doe', '555-555-9498');

INSERT INTO standard_pizza(st_pizza_name, price)
	VALUES ('Pepperoni & Cheese', 7.99),('Vegetarian', 9.99),('Meat Lovers', 14.99),
  ('Hawaiian', 12.99);
  
INSERT INTO customer_order(delivery_time, customer_id)
	VALUES (STR_TO_DATE('9/10/2014 9:47:00','%m/%d/%Y %H:%i:%s'), 1),(STR_TO_DATE('9/10/2014 13:20:00','%m/%d/%Y %H:%i:%s'), 2),(STR_TO_DATE('9/10/2014 9:47:00','%m/%d/%Y %H:%i:%s'), 1);
  
INSERT INTO order_standard_pizza(standard_pizza_id, order_id, quantity)
VALUES (1, 1, 1),(3, 1, 1),(2, 2, 1),(3, 2, 2),(3, 3, 1),(4, 3, 1);

-- Total money spent by customer
SELECT c.customer_name,  SUM(ord.quantity*p.price) as 
Total_Amount
FROM customer c inner join customer_order o
     on c.customer_id = o.customer_id join
     order_standard_pizza ord
     on o.order_id = ord.order_id join
     standard_pizza p
     on ord.standard_pizza_id = p.standard_pizza_id
GROUP BY customer_name
ORDER BY Total_Amount DESC;

-- Total money spent by customer by date
SELECT c.customer_name, o.delivery_time, SUM(ord.quantity*p.price) as 
Total_Amount
FROM customer c inner join customer_order o
     on c.customer_id = o.customer_id join
     order_standard_pizza ord
     on o.order_id = ord.order_id join
     standard_pizza p
     on ord.standard_pizza_id = p.standard_pizza_id
GROUP BY c.customer_name, o.delivery_time
ORDER BY Total_Amount DESC;





