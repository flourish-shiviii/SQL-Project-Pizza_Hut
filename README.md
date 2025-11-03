# Pizza Sales Analysis – SQL Project

## Overview

This repository contains a complete SQL-based analysis of a pizza sales dataset using MySQL. The project demonstrates practical applications of data analytics and business intelligence techniques in a retail food context. It covers a wide range of queries from basic metrics to advanced revenue insights, making it ideal for showcasing SQL proficiency and analytical thinking.

## Dataset Schema

The database consists of four interconnected tables:

- `orders`: Contains order-level metadata including order ID, customer ID, date, and time.
- `order_details`: Contains item-level details such as pizza ID and quantity ordered.
- `pizza`: Contains pizza-specific attributes including size, price, and type ID.
- `pizza_types`: Contains descriptive information about each pizza type including name, category, and ingredients.

## Key Objectives

The SQL queries in this project are grouped into three levels:

### Basic Queries
- Count total orders placed
- Calculate total revenue from pizza sales
- Identify the highest-priced pizza
- Find the most common pizza size ordered
- List top 5 most ordered pizza types by quantity

### Intermediate Queries
- Join tables to find total quantity ordered per pizza category
- Analyze distribution of pizzas by category
- Calculate percentage contribution of each pizza type to total revenue
- Group orders by date and compute average pizzas ordered per day
- Identify top 3 pizza types based on revenue

### Advanced Queries
- Compute percentage contribution of each pizza type to overall revenue
- Analyze cumulative revenue generated over time
- Determine top 3 pizza types by revenue within each category

## Skills Demonstrated

- SQL joins, aggregations, and subqueries
- Window functions (MySQL 8.0+)
- Business intelligence metrics
- Revenue analysis and performance ranking
- Schema understanding and query optimization
