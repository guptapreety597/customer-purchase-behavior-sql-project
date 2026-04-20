-- Data Exploration
select * from customer_analysis.customer_purchase_behavior1;
select * from customer_analysis.customer_purchase_behavior1 limit 10;
describe customer_analysis.customer_purchase_behavior1;

-- Data Cleaning
alter table customer_analysis.customer_purchase_behavior1
rename column `Customer ID` to customer_id,
rename column `Age` to age,
rename column `Gender` to gender,
rename column `Item Purchased` to item_purchased,
rename column `Category` to category,
rename column `Purchase Amount (USD)` to purchase_amount,
rename column `Location` to location,
rename column `Size` to size,
rename column `Color` to color,
rename column `Season` to season,
rename column `Review Rating` to review_rating,
rename column `Subscription Status` to subscription_status,
rename column `Payment Method` to payment_method,
rename column `Shipping Type` to shipping_type,
rename column `Discount Applied` to discount_applied,
rename column `Promo Code Used` to promo_code_used,
rename column `Previous Purchases` to previous_purchases,
rename column `Preferred Payment Method` to preferred_payment_method,
rename column `Frequency of Purchases` to purchase_frequency;

-- Total Records
select count(*) as total_rows from customer_analysis.customer_purchase_behavior1;

-- Check Null Values
select
sum(customer_id is null) as null_customer_id,
sum(age is null) as null_age,
sum(gender is null) as null_gender,
sum(item_purchased is null) as null_item_purchased,
sum(category is null) as null_category,
sum(purchase_amount is null) as null_purchase_amount
from customer_analysis.customer_purchase_behavior1;

-- Chech Duplicates
select customer_id, age, gender, item_purchased, category, purchase_amount, location, size, color, season, review_rating, subscription_status, payment_method, shipping_type, discount_applied, promo_code_used, previous_purchases, preferred_payment_method, purchase_frequency,
count(*) as duplicate_count from customer_analysis.customer_purchase_behavior1
group by customer_id, age, gender, item_purchased, category, purchase_amount, location, size, color, season, review_rating, subscription_status, payment_method, shipping_type, discount_applied, promo_code_used, previous_purchases, preferred_payment_method, purchase_frequency
having count(*) > 1;

-- Average Purchase
select 
round(avg(purchase_amount), 2) as avg_purchase
from customer_analysis.customer_purchase_behavior1;

-- Total Revenue
select 
round(sum(purchase_amount), 2) as total_revenue
from customer_analysis.customer_purchase_behavior1;

-- Customer Distribution by Gender
select gender, 
count(*) as total_customers
from customer_analysis.customer_purchase_behavior1
group by gender;

-- Product Category Distribution
select category,
count(*) as total_categories
from customer_analysis.customer_purchase_behavior1
group by category;

-- Revenue By Category
select category,
round(sum(purchase_amount), 2) as total_revenue 
from customer_analysis.customer_purchase_behavior1 
group by category 
order by total_revenue desc;

-- Revenue By Season
select season,
round(avg(purchase_amount), 2) as avg_purchase
from customer_analysis.customer_purchase_behavior1
group by season
order by avg_purchase desc;

-- Top 10 Customers by Total Spending
select customer_id, round(sum(purchase_amount), 2) as total_spent
from customer_analysis.customer_purchase_behavior1
group by customer_id
order by total_spent desc
limit 10;

-- Purchase Behavior by Subscription Status
select subscription_status, count(*) as total_orders,
round(avg(purchase_amount), 2) as avg_purchase,
round(sum(purchase_amount), 2) as total_revenue
from customer_analysis.customer_purchase_behavior1
group by subscription_status;

-- Purchase Behavior by Frequency
select purchase_frequency, count(*) as total_orders,
round(avg(purchase_amount), 2) as avg_purchase
from customer_analysis.customer_purchase_behavior1
group by purchase_frequency
order by avg_purchase desc;

-- Product Category Popularity
select category, count(*) as purchase_count
from customer_analysis.customer_purchase_behavior1
group by category
order by purchase_count desc;

-- Preferred Payment Method
select preferred_payment_method, count(*) as customer_count
from customer_analysis.customer_purchase_behavior1
group by preferred_payment_method
order by customer_count desc;

-- Top Locations by Purchase Volume
select location, count(*) as purchase_count
from customer_analysis.customer_purchase_behavior1
group by location
order by purchase_count desc
limit 15;

-- Top Locations by Revenue Contribution
select location, count(*) as purchase_count,
round(sum(purchase_amount), 2) as total_revenue
from customer_analysis.customer_purchase_behavior1
group by location
order by total_revenue desc
limit 15;

-- Purchase Behavior by Gender
select gender, count(*) as total_orders,
round(avg(purchase_amount), 2) as avg_purchase,
round(sum(purchase_amount), 2) as total_revenue
from customer_analysis.customer_purchase_behavior1
group by gender
order by total_revenue desc;

-- Average Age of Customers Purchasing Footwear
select round(avg(age), 2) as avg_age
from customer_analysis.customer_purchase_behavior1
where category = 'Footwear';

-- High-Value Purchases
select * from customer_analysis.customer_purchase_behavior1
where purchase_amount >= 90
order by purchase_amount desc;

--  Product Preference by Gender and Category
select gender, category, count(*) as total_transaction
from customer_analysis.customer_purchase_behavior1
group by gender, category;

-- Unique Customers per Product Category
select category, count(distinct customer_id) as unique_customer_count
from customer_analysis.customer_purchase_behavior1
group by category;


-- Age Group Analysis
select 
	case
		when age < 25 then '18-24'
        when age < 35 then '25-34'
        when age < 45 then '35-44'
        when age < 55 then '45-54'
        else '55+'
	end as age_group,
    category, count(*) as total_orders,
    round(sum(purchase_amount), 2) as total_revenue
from customer_analysis.customer_purchase_behavior1
group by age_group, category
order by age_group, total_revenue desc;

-- Purchase Frequency
select 
	case
		when previous_purchases >= 30 then 'frequent buyer'
        when previous_purchases >= 15 then 'regular buyer'
        else 'occasional buyer'
	end as buyer_type,
    count(distinct customer_id) as total_customers,
    round(avg(purchase_amount), 2) as avg_purchase
from customer_analysis.customer_purchase_behavior1
group by buyer_type
order by avg_purchase desc;

-- Revenue Analysis by Gender and Product Category
select gender, category,
round(sum(purchase_amount), 2) as total_revenue,
count(*) as total_orders
from customer_analysis.customer_purchase_behavior1
group by gender, category
order by total_revenue desc;



























