SELECT Location, date_, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1,2

-- Looking at Total Cases vs. Total Deaths
-- Shows likelihood of dying if you contract covid in my country
SELECT Location, date_, total_cases, total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage 
FROM CovidDeaths
WHERE location = 'United States'
ORDER BY 1,2

-- Looking at Total Cases vs. Population
-- Shows what percentage of population got covid
SELECT Location, date_, population, total_cases, (total_cases/population)*100 AS DeathPercentage 
FROM CovidDeaths
WHERE location = 'United States'
ORDER BY 1,2

-- Looking at Countries with Highest Infection Rate compared to population
SELECT Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected 
FROM CovidDeaths
GROUP BY Location, population
ORDER BY PercentPopulationInfected DESC NULLS LAST

-- Showing Countries with Highest Death Count per Population
SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- LETS BREAK THINGS DOWN BY CONTINENT
-- Showing continents with the highest death count per population
SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC NULLS LAST;

-- GLOBAL NUMBERS
SELECT date_, SUM(new_cases) AS Total_Cases, SUM(CAST(new_deaths AS INT)) AS TotalDeaths , SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date_
ORDER BY 1,2;

-- Total_Cases, TotalDeaths, DeathPercentage
SELECT SUM(new_cases) AS Total_Cases, SUM(CAST(new_deaths AS INT)) AS TotalDeaths , SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Total Cases
SELECT SUM(new_cases)
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY new_cases;

--Looking at Total Population vs.Vaccinations
SELECT dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations 
FROM CovidDeaths dea JOIN CovidVaccinations vac 
ON dea.location = vac.location
and dea.date_ = vac.date_
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3

--Looking at Total Population and vaccinations adding up over each new vaccination
SELECT dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date_ ) AS RollingPeopleVaccinated
FROM CovidDeaths dea JOIN CovidVaccinations vac 
ON dea.location = vac.location
and dea.date_ = vac.date_
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3


– USE CTE 

With PopvsVac(Continent, Location, Date_, Population, New_Vaccinations, RollingPeopleVaccinated)
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


--TEMP TABLE
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date_ DATE,
Population NUMERIC,
New_Vaccinations NUMERIC,
RollingPeopleVaccinated NUMERIC
)
INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location,
dea.date_ ) AS RollingPeopleVaccinated  
FROM CovidDeaths dea 
JOIN CovidVaccinations vac 
ON dea.location = vac.location
AND dea.date_ = vac.date_
WHERE dea.continent IS NOT NULL

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated
--Creating View to store data for later visualizations
Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations AS INT)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date_ = vac.date_
where dea.continent is not null 

