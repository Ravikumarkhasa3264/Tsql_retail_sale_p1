--Creating & using Database
create database retails_sales_analysis
use retails_sales_analysis
--Creating Table
create table retails_sale(
transactions_id int primary key,
sale_date	date,
sale_time	Time,
customer_id	varchar(15),
gender varchar(5),
age int,
category varchar(15),
quantiy int,
price_per_unit	float,
cogs float,	
total_sale float)
alter table retails_sale
alter column gender varchar(6)
select*from retails_sale
--importing data into retails_sale table
bulk insert retails_sale
from 'C:\Users\RAVI KUMAR\Downloads\SQL - Retail Sales Analysis_utf .csv'
with(firstrow=2,
fieldterminator=',',
rowterminator='\n'
)
--Data cleaning & Handling null values
select  *from  retails_sale 
where transactions_id is null	or
sale_date is null	or	
sale_time	is null	or
--customer_id	is null	or
gender	is null	or
--age	is null	or
category	is null	or
quantiy	is null	or
--price_per_unit	is null	or
cogs	is null	or
total_sale is null
delete from  retails_sale  
where transactions_id is null	or
sale_date is null	or	
sale_time	is null	or
--customer_id	is null	or
gender	is null	or
--age	is null	or
category	is null	or
quantiy	is null	or
--price_per_unit	is null	or
cogs	is null	or
total_sale is null
--Data Exploration
--total numbers of entry in data
select COUNT(*) Total_sale from retails_sale
--How many Customers with uniq id
select count(distinct(customer_id))count_of_Cust_ID from retails_sale
--Categories which are  uniq
select count(distinct(category))Uniq_Category from retails_sale

--Data Anlysis
--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select top(5) *from  retails_sale 

select*from retails_sale where sale_date='2022-11-05'

/*Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
the quantity sold is more than 4 in the month of Nov-2022*/
select transactions_id from retails_sale where category ='Clothing' and quantiy>=4 and sale_date>='2022-11-01' and sale_date<'2022-12-01'

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select Category,sum(total_sale) Total_sales from retails_Sale group by category

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age)Avg_Age from retails_sale where category='Beauty'

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select transactions_id from retails_sale where total_sale>1000

--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender,category,count(transactions_id)No_of_Trans from retails_sale group by category,gender order by No_of_Trans desc

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year_,month_,AVg_sale from
(select year(sale_date)year_,MONTH(sale_date)month_,avg(total_sale)AVg_sale,
rank() over (partition by year(sale_date)order by avg(total_sale)desc) monthly_Rank
from 
retails_sale group by year(sale_date),MONTH(sale_date)) T1
where monthly_Rank=1
--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

select customer_id,SUM(total_sale) total_Sale from retails_sale 
group by customer_id order by 2 desc
offset 0 row fetch next 5 rows only


--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct(customer_id))Uniq_customers from retails_sale group by category

--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select 
case 
 when datepart(hour,sale_time)<12 then'morning'
 when datepart(hour,sale_time) between 12 and 17 then'Afternoon'
 else 'Evening'
end Shift_,count(transactions_id) total_orders
from retails_sale group by 
case 
 when datepart(hour,sale_time)<12 then'morning'
 when datepart(hour,sale_time) between 12 and 17 then'Afternoon'
 else 'Evening'
end 
--End of Project
