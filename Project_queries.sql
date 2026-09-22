CREATE DATABASE IF NOT EXISTS projects;
USE projects;

CREATE TABLE projects.project(
Property_ID VARCHAR(100) PRIMARY KEY,
Customer_ID VARCHAR(100),
Project_Name VARCHAR(255),
Property_Type VARCHAR(100),
BHK VARCHAR(50),
City VARCHAR(100),
Locality VARCHAR(100),
Pincode INT,
Latitude DECIMAL(10,6),
Longitude DECIMAL(10,6),
Area_sqft INT,
Floor INT,
Total_Floors INT,
Price_per_sqft INT,
Listed_Price BIGINT,
Discount_Pct DECIMAL(5,2),
Final_Price BIGINT,
Booking_Date DATE,
Possession_Date DATE,
Customer_Age INT,
Annual_Income BIGINT,
Family_Size INT,
Occupation VARCHAR(100),
Lead_Source VARCHAR(100),
Campaign VARCHAR(100),
Website_Visits INT,
Calls INT,
Site_Visits INT,
Loan_Required VARCHAR(10),
Loan_Amount BIGINT,
Interest_Rate DECIMAL(5,2),
Loan_Tenure_Years INT,
Amenities VARCHAR(255),
Parking VARCHAR(10),
Furnishing VARCHAR(100),
Facing VARCHAR(50),
Payment_Mode VARCHAR(50),
Sales_Status VARCHAR(50),
Days_to_Sale DOUBLE NULL,
Days_to_possession INT NULL,
Booking_year INT,
Booking_month VARCHAR(20),
Booking_quarter INT,
LTV DOUBLE NULL,
Discount_Ammount BIGINT,
Self_funded_ammount BIGINT,
Estimated_Total_Interest DOUBLE NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Srijan_data.csv'
INTO TABLE projects.project
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Property_ID, Customer_ID, Project_Name, Property_Type, BHK, City, Locality, Pincode, Latitude, Longitude, Area_sqft, Floor, Total_Floors, Price_per_sqft, Listed_Price, Discount_Pct, Final_Price, @Booking_Date, @Possession_Date, Customer_Age, Annual_Income, Family_Size, Occupation, Lead_Source, Campaign, Website_Visits, Calls, Site_Visits, Loan_Required, Loan_Amount, Interest_Rate, Loan_Tenure_Years, Amenities, Parking, Furnishing, Facing, Payment_Mode, Sales_Status, @Days_to_Sale, @Days_to_possession, Booking_year, Booking_month, Booking_quarter, @LTV, Discount_Ammount, Self_funded_ammount, @Estimated_Total_Interest)
SET
Booking_Date = NULLIF(@Booking_Date,''),
Possession_Date = NULLIF(@Possession_Date,''),
Days_to_Sale = NULLIF(@Days_to_Sale,''),
Days_to_possession = NULLIF(@Days_to_possession,''),
LTV = NULLIF(@LTV,''),
Estimated_Total_Interest = NULLIF(@Estimated_Total_Interest,'');

-- Displaying the info
select * from project limit 5;

-- 1. Overall Business Performance
select count(Property_ID) as Total_properties, 
sum(case when Sales_Status = "sold" then 1 else 0 end) as Properties_sold, 
round((sum(case when Sales_Status = "sold" then Final_Price else 0 end)/10000000),0)as Total_Revenue_in_Cr,
round(avg(Days_to_Sale),0) as Avg_Days_to_Sale from project;

-- 2. Which top 10 City/Locality makes the most money?
select City,
Locality,
count(*) as Properties_sold ,
round((sum(Final_Price)/10000000),0) as Revenue_Core, 
round(avg(Area_sqft),2) as AVG_Area_sqft from project
where Sales_Status = "Sold"
group by City,Locality
order by Revenue_Core limit 10;

-- 3. Which Property Type/BHK sells fastest?
select Property_Type, BHK ,
count(*) as Sold, 
round(avg(Days_to_Sale),0) as AVG_Days_to_Sale, 
round((Avg(Final_Price)/100000),2) as AVG_Price_Lakh,
round(Avg(Discount_Pct),2) as AVG_Discount_Pct
from project where Sales_Status = "Sold" 
group by Property_type,BHK 
order by AVG_Days_to_Sale ASC;

-- 4. Marketing ROI query
select Lead_Source, Campaign ,
count(*) as Leads,
Sum(case when Sales_Status = "Sold" then 1 else 0 end) as Converted,
round(sum(case when Sales_Status="Sold" then 1 else 0 end)*100/count(*),2) as Conversion_Pct 
from project GROUP BY Lead_Source, Campaign
ORDER BY Conversion_Pct DESC;

-- 5. Discount Strategy - Does More Discount Sell Faster? 
select case when Discount_Pct= 0 then "No Discount" when Discount_Pct<=5 then "5%" when Discount_Pct<=10 then "10%" else "More than 10%" end as Discount_Slab,
count(*) as Unit,
round(avg(Days_to_Sale),0) as AVG_Days_to_Sale,
round(((avg(Final_Price))/100000),2) as AVG_Final_Price_Lakh
from project
where Sales_Status = "Sold"
group by Discount_Slab
order by Discount_Slab ASC;

-- 6. Customer Profile - Who is Buying?
select Occupation, count(*) as Buyers,
avg(Area_sqft) as AVG_Area_sqft,
round(((avg(Final_Price))/100000),2) as AVG_Final_Price_Lakh,
round(avg(Customer_Age),0) as AVG_Customer_Age,
round((avg(Annual_Income*83)/100000),2) as AVG_cust_Annual_Income_Lakh_INR
from project
where Sales_Status = "Sold"
group by Occupation
order by AVG_cust_Annual_Income_Lakh_INR DESC;

-- 7. L-T-V and Bank Analysis
select case when LTV >= 80 then "High Risk" when LTV >= 50 then "Medium Risk" else "Low Risk" end as Risk_Analysis,
count(*) as Customers,
round((avg(Final_Price)/100000),2) AVG_Final_Price_Lakh,
round((avg(Loan_Amount)/100000),2) as AVG_Loan_Amount_Lakh,
round((avg(Self_funded_ammount)/100000),2) as AVG_Self_funded_ammount_Lakh,
round((avg(Estimated_Total_Interest)/100000),2) as AVG_Estimated_Total_Interest_Lakh
from project where 
Loan_Required ="Yes" and Sales_Status="Sold"
group by Risk_Analysis
order by Risk_Analysis;

-- 8. Seasonality - Best month/ Quarter to Sell
select Booking_year, Booking_quarter, Booking_month,
count(*) as Units_Sold,
round(sum(Final_Price)/10000000) as Revenue_Cr
from project
where Sales_Status='Sold'
group by Booking_year, Booking_quarter, Booking_month
order by Booking_year,Revenue_Cr, 
FIELD(Booking_month,'January','February','March','April','May','June','July','August','September','October','November','December');

-- 9. Loss Analysis- Why properties are not selling?
select sales_status, property_type, city,
 avg(days_to_sale) as avg_days_in_market,
avg(website_visits) as avg_website_visits,
avg(site_visits) as avg_site_visits,
count(*) as count
from project
where sales_status != 'sold'
group by sales_status, property_type, city
order by count desc limit 10;

-- 10. Top 10 most valuable Customers
select Customer_ID,
Occupation,
Customer_Age,
round(((Annual_Income*83)/1000000),2)as Annual_income_Lakh,
Area_sqft,
BHK,
(Final_Price/1000000) as Revenue_generated_Cr
from project where Sales_Status="Sold" order by Revenue_generated_Cr desc limit 10;
