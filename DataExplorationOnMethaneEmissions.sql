-- Data Exploration On Methane Emissions

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

#Average methane emissions per Region
SELECT region, AVG(emissions)
FROM emissions
GROUP BY region
ORDER BY AVG(emissions) DESC;

#Average methane emissions per Country
SELECT country, AVG(emissions)
FROM emissions
GROUP BY country
ORDER BY AVG(emissions) DESC;

#Total methane emissions per type
SELECT type, COUNT(type)
FROM emissions
GROUP BY type
ORDER BY COUNT(type) DESC;

#Total methane emissions per year
SELECT baseYear, SUM(emissions)
FROM emissions
GROUP BY baseYear
ORDER BY SUM(emissions) DESC;

#Average methane emissions per year
SELECT baseYear, AVG(emissions)
FROM emissions
GROUP BY baseYear
ORDER BY AVG(emissions) DESC;