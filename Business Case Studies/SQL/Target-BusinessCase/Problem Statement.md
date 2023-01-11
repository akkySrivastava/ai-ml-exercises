## Context

- Target is one of the world’s most recognized brands and one of America’s leading retailers. Target makes itself a preferred shopping destination by offering outstanding value, inspiration, innovation and an exceptional guest experience that no other retailer can deliver.

- This business case has information of 100k orders from 2016 to 2018 made at Target in Brazil. Its features allows viewing an order from multiple dimensions: from order status, price, payment and freight performance to customer location, product attributes and finally reviews written by customers.

#### Dataset: https://drive.google.com/drive/folders/1TGEc66YKbD443nslRi1bWgVd238gJCnb

- Data is available in 8 csv files:

1. customers.csv

2. geolocation.csv

3. order_items.csv

4. payments.csv

5. reviews.csv

6. orders.csv

7. products.csv

8. sellers.csv

Each feature or columns of different CSV files are described below:

The customers.csv contain following features:

Features

Description

customer_id

Id of the consumer who made the purchase.

customer_unique_id

Unique Id of the consumer.

customer_zip_code_prefix

Zip Code of the location of the consumer.

customer_city

Name of the City from where order is made.

customer_state

State Code from where order is made(Ex- sao paulo-SP).

The sellers.csv contains following features:

Features

Description

seller_id

Unique Id of the seller registered

seller_zip_code_prefix

Zip Code of the location of the seller.

seller_city

Name of the City of the seller.

seller_state

State Code (Ex- sao paulo-SP)

The order_items.csv contain following features:

Features

Description

order_id

A unique id of order made by the consumers.

order_item_id

A Unique id given to each item ordered in the order.

product_id

A unique id given to each product available on the site.

seller_id

Unique Id of the seller registered in Target.

shipping_limit_date

The date before which shipping of the ordered product must be completed.

price

Actual price of the products ordered .

freight_value

Price rate at which a product is delivered from one point to another.

The geolocations.csv contain following features:

Features

Description

geolocation_zip_code_prefix

first 5 digits of zip code

geolocation_lat

latitude

geolocation_lng

longitude

geolocation_city

city name

geolocation_state

state

The payments.csv contain following features:

Features

Description

order_id

A unique id of order made by the consumers.

payment_sequential

sequences of the payments made in case of EMI.

payment_type

mode of payment used.(Ex-Credit Card)

payment_installments

number of installments in case of EMI purchase.

payment_value

Total amount paid for the purchase order.

The orders.csv contain following features:

Features

Description

order_id

A unique id of order made by the consumers.

customer_id

Id of the consumer who made the purchase.

order_status

status of the order made i.e delivered, shipped etc.

order_purchase_timestamp

Timestamp of the purchase.

order_delivered_carrier_date

delivery date at which carrier made the delivery.

order_delivered_customer_date

date at which customer got the product.

order_estimated_delivery_date

estimated delivery date of the products.

The reviews.csv contain following features:

Features

Description

review_id

Id of the review given on the product ordered by the order id.

order_id

A unique id of order made by the consumers.

review_score

review score given by the customer for each order on the scale of 1–5.

review_comment_title

Title of the review

review_comment_message

Review comments posted by the consumer for each order.

review_creation_date

Timestamp of the review when it is created.

review_answer_timestamp

Timestamp of the review answered.

The products.csv contain following features:

Features

Description

product_id

A unique identifier for the proposed project.

product_category_name

Name of the product category

product_name_lenght

length of the string which specifies the name given to the products ordered.

product_description_lenght

length of the description written for each product ordered on the site.

product_photos_qty

Number of photos of each product ordered available on the shopping portal.

product_weight_g

Weight of the products ordered in grams.

product_length_cm

Length of the products ordered in centimeters.

product_height_cm

Height of the products ordered in centimeters.

product_width_cm

width of the product ordered in centimeters.

High level overview of relationship between datasets:



Assume you are a data scientist at Target, and are given this data to analyze and provide some insights and recommendations from it.

What does ‘good’ look like?

Import the dataset and do usual exploratory analysis steps like checking the structure & characteristics of the dataset

Data type of columns in a table

Time period for which the data is given

Cities and States of customers ordered during the given period

In-depth Exploration:

Is there a growing trend on e-commerce in Brazil? How can we describe a complete scenario? Can we see some seasonality with peaks at specific months?

What time do Brazilian customers tend to buy (Dawn, Morning, Afternoon or Night)?

Evolution of E-commerce orders in the Brazil region:

Get month on month orders by states

Distribution of customers across the states in Brazil

Impact on Economy: Analyze the money movement by e-commerce by looking at order prices, freight and others.

Get % increase in cost of orders from 2017 to 2018 (include months between Jan to Aug only) - You can use “payment_value” column in payments table

Mean & Sum of price and freight value by customer state

5. Analysis on sales, freight and delivery time

Calculate days between purchasing, delivering and estimated delivery

Find time_to_delivery & diff_estimated_delivery. Formula for the same given below:

time_to_delivery = order_purchase_timestamp-order_delivered_customer_date

diff_estimated_delivery = order_estimated_delivery_date-order_delivered_customer_date

Group data by state, take mean of freight_value, time_to_delivery, diff_estimated_delivery

Sort the data to get the following:

Top 5 states with highest/lowest average freight value - sort in desc/asc limit 5

Top 5 states with highest/lowest average time to delivery

Top 5 states where delivery is really fast/ not so fast compared to estimated date

6. Payment type analysis:

Month over Month count of orders for different payment types

Count of orders based on the no. of payment installments

Evaluation Criteria (80 points)

Initial exploration of dataset like checking the characteristics of data (10 points)

In-depth Exploration (10 points)

Evolution of E-commerce orders in the Brazil region (10 points)

Impact on Economy (10 points)

Analysis on sales, freight and delivery time (10 points)

Payment type analysis (10 points)

Actionable Insights (10 points)

Recommendations (10 points)

Submission Process <IMP>:

Use Word doc to paste your SQL queries along with the screenshot of the first 10 rows
Convert your solutions notebook into PDF, and upload the same on the platform
Optionally, you may add images/graphs in the text editor by taking screenshots
After submitting, you will not be allowed to edit your submission