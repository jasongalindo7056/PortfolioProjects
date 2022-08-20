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

#Average winds per year
SELECT year, AVG(wind)
FROM storms
GROUP BY year
ORDER BY year;

#Amount of storms based on status
SELECT status, COUNT(status)
FROM storms
GROUP BY status
ORDER BY COUNT(status);