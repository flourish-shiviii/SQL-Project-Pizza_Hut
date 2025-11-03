/*
Project: Pizza Sales Analysis
Tables:
- orders
- order_details
- pizza
- pizza_types
*/

/* ----------------------------- */
/* BASIC QUERIES              */
/* ----------------------------- */

/*-- Q1. Retrieve the total number of orders placed */
SELECT 
    COUNT(*) AS number_of_orders
FROM 
    orders;

/*-- Q2. Calculate the total revenue generated from pizza sales */
SELECT 
    ROUND(SUM(o.quantity * p.price), 2) AS revenue
FROM 
    order_details AS o
JOIN 
    pizza AS p ON o.pizza_id = p.pizza_id;

/*-- Q3. Identify the highest-priced pizza */
SELECT 
    pt.name, p.price
FROM 
    pizza_types AS pt
JOIN 
    pizza AS p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY 
    p.price DESC
LIMIT 1;

/*-- Q4. Identify the most common pizza size ordered */
SELECT 
    p.size, COUNT(o.order_details_id) AS total_orders
FROM 
    pizza AS p
JOIN 
    order_details AS o ON p.pizza_id = o.pizza_id
GROUP BY 
    p.size
ORDER BY 
    total_orders DESC;

/*-- Q5. List the top 5 most ordered pizza types along with their quantities */
SELECT 
    pt.name AS pizza_type,
    SUM(od.quantity) AS total_quantity
FROM 
    pizza_types AS pt
JOIN 
    pizza AS p ON pt.pizza_type_id = p.pizza_type_id
JOIN 
    order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY 
    pt.name
ORDER BY 
    total_quantity DESC
LIMIT 5;


/* ----------------------------- */
/* INTERMEDIATE QUERIES       */
/* ----------------------------- */

/*-- Q6. Total quantity of each pizza category ordered */
SELECT 
    pt.category,
    SUM(od.quantity) AS total_quantity
FROM 
    order_details AS od
JOIN 
    pizza AS p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.category
ORDER BY 
    total_quantity DESC;

/*-- Q7. Category-wise distribution of pizzas */
SELECT 
    pt.category,
    COUNT(p.pizza_id) AS pizza_count
FROM 
    pizza AS p
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.category
ORDER BY 
    pizza_count DESC;

/*-- Q8. Percentage contribution of each pizza type to total revenue */
SELECT 
    pt.name AS pizza_type,
    ROUND(SUM(od.quantity * p.price) / 
          (SELECT SUM(od2.quantity * p2.price)
           FROM order_details AS od2
           JOIN pizza AS p2 ON od2.pizza_id = p2.pizza_id) * 100, 2) AS percentage_contribution
FROM 
    order_details AS od
JOIN 
    pizza AS p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    percentage_contribution DESC;

/*-- Q9. Average number of pizzas ordered per day */
SELECT 
    ROUND(AVG(daily_total), 2) AS avg_pizzas_per_day
FROM (
    SELECT 
        o.date,
        SUM(od.quantity) AS daily_total
    FROM 
        orders AS o
    JOIN 
        order_details AS od ON o.order_id = od.order_id
    GROUP BY 
        o.date
) AS daily_summary;

/* -- Q10. Top 3 most ordered pizza types based on revenue */
SELECT 
    pt.name AS pizza_type,
    SUM(od.quantity * p.price) AS total_revenue
FROM 
    order_details AS od
JOIN 
    pizza AS p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    total_revenue DESC
LIMIT 3;


/* ----------------------------- */
/* ADVANCED QUERIES           */
/* ----------------------------- */

/* -- Q11. Percentage contribution of each pizza type to total revenue */
SELECT 
    pt.name AS pizza_type,
    ROUND(SUM(od.quantity * p.price) / 
          (SELECT SUM(od2.quantity * p2.price)
           FROM order_details AS od2
           JOIN pizza AS p2 ON od2.pizza_id = p2.pizza_id) * 100, 2) AS percentage_contribution
FROM 
    order_details AS od
JOIN 
    pizza AS p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    percentage_contribution DESC;

/* -- Q12. Cumulative revenue generated over time */
SELECT 
    date,
    daily_revenue,
    SUM(daily_revenue) OVER (ORDER BY date) AS cumulative_revenue
FROM (
    SELECT 
        o.date,
        SUM(od.quantity * p.price) AS daily_revenue
    FROM 
        orders AS o
    JOIN 
        order_details AS od ON o.order_id = od.order_id
    JOIN 
        pizza AS p ON od.pizza_id = p.pizza_id
    GROUP BY 
        o.date
) AS revenue_by_day;

/*-- Q13. Top 3 most ordered pizza types based on revenue for each category */
-- Note: If using MySQL 8.0+, you can apply ROW_NUMBER() or RANK() for precise top 3 filtering.
SELECT 
    pt.category,
    pt.name AS pizza_type,
    SUM(od.quantity * p.price) AS total_revenue
FROM 
    order_details AS od
JOIN 
    pizza AS p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.category, pt.name
ORDER BY 
    pt.category,
    total_revenue DESC;
