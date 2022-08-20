-- Data exploration on Methane Emissions


#Highest emissions
SELECT *
FROM emissions
WHERE emissions = (SELECT MAX(emissions) FROM emissions);

#Total methane emissions per Country
SELECT country, SUM(emissions)
FROM emissions
GROUP BY country
ORDER BY AVG(emissions) DESC;

#Total methane emissions per segment
SELECT segment, SUM(emissions)
FROM emissions
GROUP BY segment
ORDER BY SUM(emissions) DESC;

#Total methane emissions per Region
SELECT region, SUM(emissions)
FROM emissions
GROUP BY region
ORDER BY SUM(emissions) DESC;

#Average methane emissions per Country
SELECT country, AVG(emissions)
FROM emissions
GROUP BY country
ORDER BY AVG(emissions) DESC;

