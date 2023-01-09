-- Import the dataset and do usual exploratory analysis steps like checking the structure & characteristics of the dataset
-- 1. Data type of columns in a table
SELECT 
TABLE_NAME, 
COLUMN_NAME, 
DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'geolocation';

-- 2. Time Period for the data is given

SELECT
  MIN(order_purchase_timestamp) as "FROM",
  MAX(order_purchase_timestamp) as "TILL"
FROM orders;

SELECT
  MIN(review_creation_date) as "FROM",
  MAX(review_creation_date)as "TILL"
FROM order_reviews;

-- Cities and States of customers ordered during the given period

SELECT
  DISTINCT
  c.customer_city,
  c.customer_state
FROM orders as o
JOIN customers as c
ON c.customer_id = o.customer_id;

-- In-depth Exploration:

-- Is there a growing trend on e-commerce in Brazil? How can we describe a complete scenario? Can we see some seasonality with peaks at specific months?
WITH seasonlity_trends AS (
	SELECT 
			*,
			EXTRACT(YEAR_MONTH from order_purchase_timestamp) as season
	FROM orders
)

SELECT 
	season,
    count(*) as total_orders,
    (count(*) - LAG(count(*)) OVER(ORDER BY season) )
        /LAG(count(*)) OVER(ORDER BY season) * 100 AS net_swwing
FROM seasonlity_trends
GROUP BY season
ORDER BY season;


-- What time do Brazilian customers tend to buy (Dawn, Morning, Afternoon or Night)

WITH purchase_time AS (
SELECT
	*,
	CASE 
		WHEN TIME(order_purchase_timestamp) BETWEEN '00:00:00' AND '06:00:00' THEN "Dawn"
		WHEN TIME(order_purchase_timestamp) BETWEEN '06:00:01' AND '12:00:00' THEN "Morning"
		WHEN TIME(order_purchase_timestamp) BETWEEN '12:00:01' AND '18:00:00' THEN "Afternoon"
        ELSE "Night" 
	END AS "Time_Period"
FROM orders
)

SELECT 
	Time_Period,
	COUNT(*) as no_purchases
FROM purchase_time
GROUP BY Time_Period
ORDER BY no_purchases DESC;

-- Evolution of E-commerce orders in the Brazil region:
-- Get month on month orders by states    

select
result.Months as Months,
max(result.SP) as SP,
max(result.SC) as SC,
max(result.MG) as MG,
max(result.PR) as PR,
max(result.RJ) as RJ,
max(result.RS) as RS,
max(result.PA) as PA,
max(result.GO) as GO,
max(result.ES) as ES,
max(result.BA) as BA,
max(result.MA) as MA,
max(result.MS) as MS,
max(result.CE) as CE,
max(result.DF) as DF,
max(result.RN) as RN,
max(result.PE) as PE,
max(result.MT) as MT,
max(result.AM) as AM,
max(result.AP) as AP,
max(result.AL) as AL,
max(result.RO) as RO,
max(result.PB) as PB,
max(result.TOs) as TOs,
max(result.PI) as PI,
max(result.AC) as AC,
max(result.SE) as SE,
max(result.RR) as RR
from (
select 
EXTRACT(YEAR_MONTH FROM raw.order_purchase_timestamp) as Months,
raw.customer_state,
SUM(case when raw.customer_state='SP' then 1 else 0 end) as SP,
SUM(case when raw.customer_state='SC' then 1 else 0 end) as SC,
SUM(case when raw.customer_state='MG' then 1 else 0 end) as MG,
SUM(case when raw.customer_state='PR' then 1 else 0 end )as PR,
SUM(case when raw.customer_state='RJ' then 1 else 0 end) as RJ,
SUM(case when raw.customer_state='RS' then 1 else 0 end )as RS,
SUM(case when raw.customer_state='PA' then 1 else 0 end )as PA,
SUM(case when raw.customer_state='GO' then 1 else 0 end )as GO,
SUM(case when raw.customer_state='ES' then 1 else 0 end )as ES,
SUM(case when raw.customer_state='BA' then 1 else 0 end )as BA,
SUM(case when raw.customer_state='MA' then 1 else 0 end )as MA,
SUM(case when raw.customer_state='MS' then 1 else 0 end )as MS,
SUM(case when raw.customer_state='CE' then 1 else 0 end )as CE,
SUM(case when raw.customer_state='DF' then 1 else 0 end )as DF,
SUM(case when raw.customer_state='RN' then 1 else 0 end )as RN,
SUM(case when raw.customer_state='PE' then 1 else 0 end )as PE,
SUM(case when raw.customer_state='MT' then 1 else 0 end )as MT,
SUM(case when raw.customer_state='AM' then 1 else 0 end )as AM,
SUM(case when raw.customer_state='AP' then 1 else 0 end )as AP,
SUM(case when raw.customer_state='AL' then 1 else 0 end )as AL,
SUM(case when raw.customer_state='RO' then 1 else 0 end )as RO,
SUM(case when raw.customer_state='PB' then 1 else 0 end )as PB,
SUM(case when raw.customer_state='TO' then 1 else 0 end )as TOs,
SUM(case when raw.customer_state='PI' then 1 else 0 end )as PI,
SUM(case when raw.customer_state='AC' then 1 else 0 end )as AC,
SUM(case when raw.customer_state='SE' then 1 else 0 end )as SE,
SUM(case when raw.customer_state='RR' then 1 else 0 end )as RR
from 
(select
c.customer_state,
o.order_purchase_timestamp
from customers c
join orders o on c.customer_id=o.customer_id
group by 1,2
) raw
group by Months
) result
group by Months
order by 1 asc;

-- Distribution of customers across the states in Brazil

SELECT
	c.customer_state, 
    count(o.order_id) as no_of_orders,
    ROUND((count(*)/(SELECT count(*) FROM orders) * 100), 2) AS percentage
FROM customers as c
JOIN orders as o
ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY no_of_orders DESC;

-- Impact on Economy: Analyze the money movement by e-commerce by looking at order prices, freight and others.
-- Get % increase in cost of orders from 2017 to 2018 (include months between Jan to Aug only) - You can use “payment_value” column in payments table
select
month as month_no,
case 
when a.month='01' then 'Jan' 
when a.month='02' then 'Feb'
when a.month='03' then 'Mar'
when a.month='04' then 'Apr'
when a.month='05' then 'May'
when a.month='06' then 'Jun'
when a.month='07' then 'Jul'
when a.month='08' then 'Aug'
END AS Month,
case when a.year= '2017'  then SUM(a.payment_value) else 0 end as Year2017,
case when a.year= '2018'  then SUM(a.payment_value) else 0 end as Year2018
from
(select 
customer_id,
orders.order_id,
order_delivered_customer_date,
order_status,
payments.payment_value,
EXTRACT(YEAR FROM order_delivered_customer_date) as year,
EXTRACT(MONTH FROM order_delivered_customer_date) as month
from orders
join payments
ON payments.order_id = orders.order_id
where order_status= 'delivered' and order_delivered_customer_date is not null
group by orders.order_id, customer_id
order by order_delivered_customer_date asc) a
group by month
order by month_no asc
	







