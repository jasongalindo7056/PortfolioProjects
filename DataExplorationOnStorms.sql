-- Data Exploration On Storms


#Total storms per year
SELECT year, COUNT(name)
FROM storms
GROUP BY year
ORDER BY year;

#Average storm category per year
SELECT year, AVG(category)
FROM storms
GROUP BY year
ORDER BY year;

#Highest storm category per year
SELECT year, MAX(category)
FROM storms
GROUP BY year
ORDER BY year;

#Highest storm category per month
SELECT month, MAX(category)
FROM storms
GROUP BY month
ORDER BY month;


#Average storm winds per year
SELECT year, AVG(wind)
FROM storms
GROUP BY year
ORDER BY year;

#Average storm winds per month
SELECT month, AVG(wind)
FROM storms
GROUP BY month
ORDER BY month;

#Highest storm winds per year
SELECT year, MAX(winds)
FROM storms
GROUP BY year
ORDER BY year;

#Highest storm winds per year
SELECT month, MAX(winds)
FROM storms
GROUP BY month
ORDER BY month;

#Amount of storms based on status
SELECT status, COUNT(status)
FROM storms
GROUP BY status
ORDER BY COUNT(status);