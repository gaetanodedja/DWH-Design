Analysis part: 
----------------------------------
When I have to design a star schema datawarehouse in a new project usually I try to answer two fundamental questions: 
	1. What we are trying to measure? 
	2. What are the attributes (data points, quality, characteristics ect) that are being measured?
	
The first question directs to the fact tables meanwhile the second one leads to the dimensions. In our case study we want to measure orders
made online on an e-commerce website. This leads us to the fact table. In our example we have a parent-child type of fact with our two fact tables,
order_informations and order_items. If we study these facts, we find out that the attributes are related with regions, products and date. For us it 
means that the regions and produt table are our dimensions. Then if we check our products table, we see that it has another table related to it,
which is product groups. This is translated to our model as an dimension of the dimension (kind of snowflake schema). About the date attribute, 
we can generate a date dimension by script in sql. 

Another topic to solve that we can see in our date is the currency. Transactions are made in different currencies so we need a currency rate table 
to make the convertion in our local currency which is EURO. This complete our data warehous model (can find the schema in the image dwh star schema):
	Facts: order_informations, order_items
	Dimensions: regions, products - product_groups (as an extension of products), currency_rate, date

Developing part:
----------------------------------
After the analysis part, i start to explore the data in our oltp database. Checking for info characteristics, anomalies, volume ect. Find some 
of these checks in the sql script named checks.sql. After creating a picture in my mind, I continue with the solution.
I am usig mySql as a source databse since it is consedered a good one for OLTP. For builiding datawarehouse, I used SQL Server. 
I moved the data from our source system to my datawarehouse in two phases: 
	1. Satging:
		I created some stage tables as a station for the data moving from mySql. I used Sql Server Integration Service as a tool for the etl part.
		Also here in this phase, I added the currency rate table to our schema. To do this, I used python to get the exchange rate of 
		all the currencies present in our db against euro for the last three years (total period tha we have transactions in our table)
		from a public api and saving them as a csv file. Then I loaded this csv file to the staging table with SSIS. 
		Find the technical solution in the folder 01_Staging.
	2. Datawarehouse:
		Here i created the final version of our fact and dimension tables. For population the data I created a procedure in Sql Server(sice the
		data is moving inside the server, there's no need for SSIS). I also generated the date dimension. I generate it in the store procedure
		dynamically according to order dates in order table. Find the technical solution in the folder 02_Data Warehouse.

Technology stack: 
----------------------------------
1. MySql Server and Sql Server for hosting DBs.
2. Sql Server Integration Service for the etl part.
3. Sql Server Management Studio as a database management tool. 
4. Visual studio 2017 version for builiding SSIS flows. 

