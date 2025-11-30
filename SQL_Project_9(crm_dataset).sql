use college13;
select * from crm_dataset;


-- Q.1 Top 10 High-Value Customers by Lifetime Value
select customer_id, first_name, last_name, 
round(total_purchases * avg_purchase_value_usd,2) as lifetime_value
from crm_dataset 
order by lifetime_value desc limit 10;



-- Q.2 Average Satisfaction by Segment
select customer_segment, round(avg(customer_satisfaction_score),2) as avg_satisfaction
from crm_dataset group by customer_segment
order by avg_satisfaction desc;



-- Q.3 Churn Rate by Country
select country,
round(sum(case when churn='Yes' then 1 else 0 end)*100 / count(*),2) as churn_rate_percent
from crm_dataset
group by country
order by churn_rate_percent desc;



-- Q.4 Correlation Insight: Income vs. Satisfaction
select round(avg(annual_income_usd)) as avg_income,
round(avg(customer_satisfaction_score),2) as avg_satisfaction
from crm_dataset
group by customer_segment;



-- Q.5 Customers with Unresolved Support Tickets
select customer_id, support_tickets_raised, support_tickets_resolved,
(support_tickets_raised - support_tickets_resolved) as unresolved_tickets
from crm_dataset
where support_tickets_raised > support_tickets_resolved;



-- Q.6 Rank Customers by Purchase Value
select customer_id, total_purchases, avg_purchase_value_usd,
rank() over(order by ( total_purchases * avg_purchase_value_usd) desc) as rank_ltv
from crm_dataset;



-- Q.7 Segment-Wise Purchase Statistics
select customer_segment, count(*) as total_customers,
round(avg(total_purchases),2) as avg_purchases,
round(sum(total_purchases* avg_purchase_value_usd),2) as total_revenue
from crm_dataset
group by customer_segment
order by total_revenue desc;



-- Q.8 Find the Most Active Customers by Email Engagement
select customer_id, email_open_rate
from crm_dataset where email_open_rate > 0.8
order by email_open_rate desc;


-- Q.9  Find High-Income, Low-Satisfaction Customers
select customer_id, annual_income_usd, customer_satisfaction_score from crm_dataset
where Annual_income_usd > 100000 and customer_satisfaction_score <3;


-- Q.10 Compare Average Revenue Between Churned and Retained Customers
select churn, round(avg(total_purchases * avg_purchase_value_usd),2) avg_revenue
from crm_dataset group by churn;



-- Q.11 Customers Who Haven’t Purchased in 6+ Months
select customer_id, last_purchase_date from crm_dataset
where last_purchase_date < date_sub(curdate(), interval 6 month);


-- Q.12  Country & Segment Cross Analysis
select country, customer_segment, count(*) as customer_count,
round(avg(customer_satisfaction_score),2) as avg_satisfaction
from crm_dataset
group by country, customer_segment
order by country, avg_satisfaction desc;



-- Q.13 Customers with Perfect Support Record
select customer_id, support_tickets_raised, support_tickets_resolved
from crm_dataset
where support_tickets_raised = support_tickets_resolved and support_tickets_raised > 0;



-- Q.14 Detect Outliers in Purchase Behavior
select * from crm_dataset where ( total_purchases * avg_purchase_value_usd) >
(select avg(total_purchases* avg_purchase_value_usd) + 2* stddev(total_purchases * avg_purchase_value_usd) from crm_dataset);



-- Q.15  Segment-Wise Retention Rate Using CASE
select customer_segment, round(sum(case when churn ='No' then 1 else 0 end) * 100 / count(*), 2)  as retention_rate
from crm_dataset
group by customer_segment
order by retention_rate desc;





























































































