/*
    COVID-19 Data Exploration

    Skills Demonstrated:
    - Joins
    - CTEs
    - Temp Tables
    - Window Functions
    - Aggregate Functions
    - Creating Views
    - Data Type Conversion
*/

-- Preview data (only countries/regions, not aggregate rows)
SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;

SELECT *
FROM PortfolioProject..CovidVaccinations
ORDER BY location, date;

/* =====================================================================
1) Core KPIs & Descriptive Views
===================================================================== */


-- 1.1 Total cases, new cases, total deaths, population
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;


-- 1.2 Total Cases vs Total Deaths over time for a target country
-- Likelihood of dying if you contract COVID-19 in a given country
SELECT location, date, total_cases, total_deaths,
       (total_deaths / total_cases) * 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
  AND location LIKE '%Canada%'
ORDER BY location, date;

-- 1.3 Percent of population infected over time (target country) (Total Cases vs Population)

SELECT location, date, population, total_cases,
       (total_cases / population) * 100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
  AND location LIKE '%Canada%'
ORDER BY location, date;

-- 1.4 Countries with highest infection rate (max since start)
SELECT location,
       population,
       MAX(total_cases) AS HighestInfectionCount,
       MAX((total_cases / population)) * 100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

-- 1.5 Countries with highest total death count (cumulative)
SELECT location,
       MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;


-- 1.6 Continents by total death count
SELECT continent,
       MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- 1.7 Global daily totals and global case fatality rate
SELECT SUM(new_cases) AS TotalCases,
       SUM(CAST(new_deaths AS INT)) AS TotalDeaths,
       SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL;


/* =====================================================================
2) Joining Deaths & Vaccinations + Rolling Coverage
===================================================================== */


-- 2.1 Raw join (countries only)
SELECT *
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
     ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY dea.location, dea.date;


-- 2.2 Rolling sum of new vaccinations by country
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(CONVERT(INT, vac.new_vaccinations)) OVER (
           PARTITION BY dea.location ORDER BY dea.location, dea.date
       ) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
     ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY dea.location, dea.date;


-- 2.3 CTE for reuse (calculate vaccination percentage)
WITH PopVsVac AS (
    SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
           SUM(CONVERT(INT, vac.new_vaccinations)) OVER (
               PARTITION BY dea.location ORDER BY dea.location, dea.date
           ) AS RollingPeopleVaccinated
    FROM PortfolioProject..CovidDeaths dea
    JOIN PortfolioProject..CovidVaccinations vac
         ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT *,
       (RollingPeopleVaccinated / population) * 100 AS PercentPopulationVaccinated
FROM PopVsVac;


-- 2.4 Temp table version (calculate vaccination percentage)
DROP TABLE IF EXISTS #PercentPopulationVaccinated;

CREATE TABLE #PercentPopulationVaccinated (
    Continent NVARCHAR(255),
    Location NVARCHAR(255),
    Date DATETIME,
    Population NUMERIC,
    New_Vaccinations NUMERIC,
    RollingPeopleVaccinated NUMERIC
);

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(CONVERT(INT, vac.new_vaccinations)) OVER (
           PARTITION BY dea.location ORDER BY dea.location, dea.date
       ) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
     ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

SELECT *,
       (RollingPeopleVaccinated / population) * 100 AS PercentPopulationVaccinated
FROM #PercentPopulationVaccinated;


-- 2.5 Create a View for visualization tools (Tableau, BI)
DROP VIEW IF EXISTS dbo.PercentPopulationVaccinated;
CREATE VIEW dbo.PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       SUM(CONVERT(INT, vac.new_vaccinations)) OVER (
           PARTITION BY dea.location ORDER BY dea.location, dea.date
       ) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
     ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

/* =====================================================================
3) Advanced Analyses (Add?On Portfolio Queries)
===================================================================== */


-- 3.1 Monthly trend analysis (cases & deaths)

WITH Monthly AS (
    SELECT location, 
    CONVERT(VARCHAR(7), date, 23) AS YearMonth,
    SUM(new_cases) AS MonthlyCases, 
    SUM(CAST(new_deaths AS BIGINT)) AS MonthlyDeaths
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, CONVERT(VARCHAR(7), date, 23)
)

SELECT *
FROM Monthly
ORDER BY location, YearMonth

-- 3.2 Weekly trend analysis using ISO week
SELECT location,
       DATEPART(YEAR, date) AS Yr,
       DATEPART(ISO_WEEK, date) AS IsoWeek,
       SUM(new_cases) AS WeeklyCases,
       SUM(CAST(new_deaths AS BIGINT)) AS WeeklyDeaths
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, DATEPART(YEAR, date), DATEPART(ISO_WEEK, date)
ORDER BY location, Yr, IsoWeek;