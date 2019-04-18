USE etl_db; 

SELECT c.Date, 
	c.Latitude, 
	c.Longitude, 
	c.`Offense Description`, 
	p.`Violation Code`,
	p.`House Number`, 
	p.`Street Name`
FROM nyc_crime c
INNER JOIN nyc_parking p ON c.Date = p.Date
GROUP BY Date ;