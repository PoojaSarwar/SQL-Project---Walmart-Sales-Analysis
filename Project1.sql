--------  Project 1: Analyze Walmart Sales Data ----------

-- Database used
use project

-- Table view 
Select * from walmartdata

------------------------------------------------  Questions ------------------------------------------

-- 1.  Retrieve all columns for sales made in a specific branch (e.g., Branch 'A')

Select * ,
	format (unit_price * quantity, 'N2' ) as Sales from walmartdata   --(N2' specifies numeric value with two decimal places)
	where branch = 'A'
	order by sales desc

-- 2. Find the total sales for each product line

select Product_line, 
	format(sum(unit_price * quantity ),'N2') as Total_Sales from walmartdata
	group by product_line 
	order by Total_sales desc

-- 3. List all sales transactions where the payment method was 'Cash'

Select * ,
	format (unit_price * quantity, 'N2' ) as Sales from walmartdata   
	where payment = 'cash'
	order by sales desc

-- 4.  Calculate the total gross income generated in each city

select city, 
	format(sum(gross_income),'N2') as Total_Gross_Income from walmartdata
	group by City
	order by Total_Gross_Income desc 

-- 5. Find the average rating given by customers in each branch

select branch, 
	format ( Avg(rating), 'N2') as AVG_Rating from walmartdata
	group by branch 
	order by AVG_Rating desc

-- 6. Determine the total quantity of each product line sold

select Product_line, 
	count(quantity ) as Total_Quantity from walmartdata
	group by product_line 
	order by Total_quantity desc

-- 7. List the top 5 products by unit price

select top 5 Product_line, 
	invoice_id,  
	unit_price  from walmartdata
order by unit_price

-- 8. Find sales transactions with a gross margin percentage greater than 3%

select format((unit_price * quantity), 'N2') As Sales, 
	gross_margin_percentage from walmartdata
	where gross_margin_percentage > 3

-- 9.  Retrieve sales transactions that occurred on weekends

select format((unit_price * quantity), 'N2') As Sales, Date, 
	   datename(weekday, date) as Week_day from walmartdata
	where datename(weekday, date) in ('saturday','sunday')

-- 10.  Calculate the total sales and gross income for each month

select datename(Month,date) As Month_Name,
	format(sum((unit_price * quantity)), 'N2') As Total_Sales, 
	sum(gross_income) As Total_Gross_Income from walmartdata
group by datename(Month,date)

-- 11.  Find the number of sales transactions that occurred after 6 PM

select count(unit_price * quantity) As Sales_count_after_6PM,
	datename(month,date) as Month_name from walmartdata
	where time > '18:00:00'
group by datename(month,date)
order by sales_count_after_6PM desc

-- 12.  List the sales transactions that have a higher total than the average total of all transactions

select format((unit_price * quantity), 'N2') As Sales from walmartdata
	where (unit_price * quantity) > (select avg(unit_price * quantity) from walmartdata )
order by sales 

-- 13.  Find customers who made more than 5 purchases in a single month

select invoice_id,customer_type, 
	datename(month,date) as Month_name, 
	quantity from walmartdata
	where quantity > 5

-- 14. Calculate the cumulative gross income for each branch by date

select branch, 
	date, 
	sum(gross_income) over (partition by branch order by date ) as cumulative_gross_income from walmartdata
order by branch, date

-- 15. Find the total cogs for each customer type in each city

select city, 
	customer_type, 
	sum(cogs) as Total_COGS from walmartdata
group by city, customer_type
order by city 


