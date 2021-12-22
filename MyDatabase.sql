-- Data Exploration on Covid 19 


-- Select data we are going to be working with

SELECT Location, date_, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Total Cases vs. Total Deaths
-- Shows likelihood of dying if you contract covid in the United States

SELECT Location, date_, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage 
FROM CovidDeaths
WHERE location = 'United States'
AND continent IS NOT NULL
ORDER BY 1,2

-- Total Cases vs. Population
-- Shows what percentage of the population got covid

SELECT Location, date_, population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected 
FROM CovidDeaths
ORDER BY 1,2

-- Countries with Highest Infection Rate compared to Population

SELECT Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected 
FROM CovidDeaths
GROUP BY Location, population
ORDER BY PercentPopulationInfected DESC 

-- Countries with Highest Death Count per Population

SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

-- BREAK THINGS DOWN BY CONTINENT
-- Showing continents with the highest death count per population

SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC 

-- GLOBAL NUMBERS
-- Total Cases, Total Deaths, Death Percentage by Continents All Together

SELECT SUM(new_cases) AS Total_Cases, SUM(CAST(new_deaths AS INT)) AS TotalDeaths , SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Total Cases by Continents All Together

SELECT SUM(new_cases)
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY new_cases

-- Total Population vs. Vaccinations
-- Percentage of population that has a minimum of one covid vaccine

SELECT dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations 
FROM CovidDeaths dea JOIN CovidVaccinations vac 
ON dea.location = vac.location
and dea.date_ = vac.date_
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3

-- Looking at Total Population and Vaccinations(adding up over each new vaccination)

SELECT dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date_ ) AS RollingPeopleVaccinated
FROM CovidDeaths dea JOIN CovidVaccinations vac 
ON dea.location = vac.location
and dea.date_ = vac.date_
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3


-- Use CTE to perform Calculation

WITH PopvsVac(Continent, Location, Date_, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location,
dea.date_ ) AS RollingPeopleVaccinated  
FROM CovidDeaths dea 
JOIN CovidVaccinations vac 
ON dea.location = vac.location
AND dea.date_ = vac.date_
WHERE dea.continent IS NOT NULL
)

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac


-- Use Temp Table to perform Calculation 

DROP TABLE IF EXISTS PercentPopulationVaccinated
CREATE TABLE PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date_ DATE,
Population NUMERIC,
New_Vaccinations NUMERIC,
RollingPeopleVaccinated NUMERIC
)
INSERT INTO PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location,
dea.date_ ) AS RollingPeopleVaccinated  
FROM CovidDeaths dea 
JOIN CovidVaccinations vac 
ON dea.location = vac.location
AND dea.date_ = vac.date_
WHERE dea.continent IS NOT NULL

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PercentPopulationVaccinated


--Creating View to store data for later visualizations

CREATE View PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS INT)) OVER (Partition BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date_ = vac.date_
WHERE dea.continent IS NOT NULL

