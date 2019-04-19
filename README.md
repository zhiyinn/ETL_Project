# ETL_Project

## Project Proposal 
We are looking to extract, load, and transform crime and parking ticket data for major cities in the US in order to compare the incidence of parking tickets and crime on particular days.
To do this, we will examine parking ticket data for these cities from Kaggle and crime data from each respective city's open data repositories.
We will investigate the relationship between parking ticket citations and crime by date.
Anticipated challenges include finding the appropriate joins to merge multiple into workable queries for the purposes of this project.

Data were found for Los Angeles, Chicago, New York, and Washington D.C.

Los Angeles:
[Crime Data](https://data.lacity.org/A-Safe-City/Crime-Data-from-2010-to-Present/y8tr-7khq)
[Parking Data](https://www.kaggle.com/cityofLA/los-angeles-parking-citations)

Chicago:
[Crime Data](https://www.kaggle.com/chicago/chicago-crime)
[Parking Data](https://www.propublica.org/datastore/dataset/chicago-parking-ticket-data)

New York:
[Crime Data](https://data.cityofnewyork.us/Public-Safety/NYC-crime/qb7u-rbmr)
[Parking Data](https://www.kaggle.com/new-york-city/ny-parking-violations-issued)

Washington D.C.:
[Crime Data](https://datagate.dc.gov/search/open/crimes?daterange=1-1-2018,12-31-2018&details=true&format=csv)
[Parking Data](https://www.kaggle.com/arcgisopendata/dc-parking-violations)

##Extract
Extract is the process of reading data from a database. In our extract stage, we collected data from the above sources and read in our files into Python notebooks and Pandas dataframes from CSV formats. 

##Transform 
In this step, we modified our dataframes to convert the extracted data so that it can be placed in a new database. To do this, we selected for variables we had expressed interest in, removed rows with blank or null cells, refined the output to create common values we could potentially merge on, and renamed column names to more clearly define context of the data fields. 

##Load 
In the last step of this process, we used SQLAlchemy to create a database and push cleaned data in tables in SQL. 
