
--Viewing the data 
SELECT * FROM dbo.['2018$'];
SELECT * FROM dbo.['2019$'];
SELECT  * FROM dbo.['2020$'];

--Combining all the data in one uniform table
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT  * FROM dbo.['2020$'];

--Creating a temporary table of combined data
with hotels as
(
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT  * FROM dbo.['2020$']
)
SELECT * FROM hotels;

--Figuring if the revenue is growing by year
with hotels as
(
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT  * FROM dbo.['2020$']
)
SELECT arrival_date_year,hotel,ROUND(SUM((stays_in_weekend_nights+stays_in_week_nights)*adr),2) as revenue 
FROM hotels
GROUP BY arrival_date_year,hotel
ORDER BY arrival_date_year;

--Figuring out the total revenue with meal cost and discount
with hotels as
(
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT  * FROM dbo.['2020$']
)
SELECT arrival_date_year,ROUND(SUM((stays_in_weekend_nights+stays_in_week_nights)*(adr*Discount)-Cost),2)
FROM hotels
LEFT JOIN dbo.market_segment$
ON hotels.market_segment=dbo.market_segment$.market_segment
LEFT JOIN dbo.meal_cost$
ON hotels.meal=dbo.meal_cost$.meal
GROUP BY arrival_date_year;



with hotels as
(
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT  * FROM dbo.['2020$']
)
SELECT *
FROM hotels
LEFT JOIN dbo.market_segment$
ON hotels.market_segment=dbo.market_segment$.market_segment
LEFT JOIN dbo.meal_cost$
ON hotels.meal=dbo.meal_cost$.meal