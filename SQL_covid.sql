--SELECT * FROM Covid..covid_deaths
--order by 3,4

--SELECT * FROM Covid..covid_vaccinations
--order by 3,4

---- Select data that will be used:
--SELECT Location, date, total_cases, new_cases, total_deaths, population
--FROM Covid..covid_deaths
--order by 1,2 --just so it's in the same format as the original data we saw in Excel

---- Looking at Total Cases vs Total Deaths. What does the mortality look like?
--SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'death%'
--FROM Covid..covid_deaths
--WHERE location = 'Brazil'
--order by 1,2 

---- Total Cases vs Population. What % got covid?
--SELECT Location, date, total_cases, Population, (total_cases/Population)*100 as 'case%'
--FROM Covid..covid_deaths
--WHERE location = 'Brazil'
--order by 1,2 

---- Looking at countries with highest infection rate compared to population.
--SELECT Location, Population, MAX(total_cases) as 'Highest_Infection_Count', MAX((total_cases/Population)*100) as '%_pop_infected'
--FROM Covid..covid_deaths
--GROUP BY Location, Population
--ORDER by 4 DESC 

---- Looking at countries with highest death count per population.
--SELECT Location, MAX(cast(total_deaths as INT)) as Total_Death_Count
--FROM Covid..covid_deaths
--WHERE continent is not null
--GROUP BY Location
--ORDER by 2 DESC

---- What about by continent?
--SELECT location, MAX(CAST(total_deaths as INT)) as TotalDeathCount
--FROM Covid..covid_deaths
--WHERE continent is null
--GROUP BY location
--ORDER BY 2 DESC


---- GLOBAL NUMBERS
--SELECT date, SUM(new_cases) as 'total_cases', SUM(CAST(new_deaths as int)) as 'total_deaths', SUM(CAST(new_deaths as INT))/SUM(new_cases)*100 as 'death%' 
--FROM Covid..covid_deaths
--WHERE continent is not null
--GROUP BY date
--ORDER BY 1,2

---- Looking at Total Population VS Vaccination
--SELECT dea.continent, dea.location, dea.date, vac.new_vaccinations
--FROM Covid..covid_deaths dea
--JOIN Covid..covid_vaccinations vac
--	ON dea.location = vac.location
--	AND dea.date = vac.date -- location and date
--WHERE dea.continent is not null
--ORDER BY 2,3


---- A partition by is super useful here
--SELECT dea.continent, dea.location, dea.date, vac.new_vaccinations,
--	SUM(CAST(vac.new_vaccinations as BIGINT)) OVER
--	(PARTITION BY dea.location ORDER BY dea.location, dea.date) as 'total_vaccinations'
--FROM Covid..covid_deaths dea
--JOIN Covid..covid_vaccinations vac
--	ON dea.location = vac.location
--	AND dea.date = vac.date -- location and date
--WHERE dea.continent is not null
--ORDER BY 2,3

---- A partition by is super useful here
--SELECT dea.continent, dea.location, dea.date, vac.new_vaccinations,
--	SUM(CAST(vac.new_vaccinations as BIGINT)) OVER
--	(PARTITION BY dea.location ORDER BY dea.location, dea.date) as 'total_vaccinations'
--	--,(total_vaccinations/population)*100 as 'pop_vs_vac'
--FROM Covid..covid_deaths dea
--JOIN Covid..covid_vaccinations vac
--	ON dea.location = vac.location
--	AND dea.date = vac.date
--WHERE dea.continent is not null
--ORDER BY 2,3

-- CTE to use our created variable total_vaccinations

--WITH pop_vs_vac (continent, location, date, population, new_vaccinations, total_vaccinations)
--AS -- and I will copy the query above
--(
--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--	SUM(CAST(vac.new_vaccinations as BIGINT)) OVER
--	(PARTITION BY dea.location ORDER BY dea.location, dea.date) as 'total_vaccinations'
--	--,(total_vaccinations/population)*100 as 'percent_pop_vac' -- we wish to do this! CTE!
--FROM Covid..covid_deaths dea
--JOIN Covid..covid_vaccinations vac
--	ON dea.location = vac.location
--	AND dea.date = vac.date
--WHERE dea.continent is not null
----ORDER BY 2,3 --this wont work here
--)
--SELECT *, (total_vaccinations/population)*100 as 'percent_pop_vac' FROM pop_vs_vac
--ORDER BY 2,3

-- Another option would to be to use a Temp table.

--DROP TABLE IF EXISTS #percent_pop_vaxx -- just in case of alterations
--CREATE TABLE #percent_pop_vaxx
--(
--continent nvarchar(255),
--location nvarchar(255),
--date datetime,
--population numeric,
--new_vaccinations bigint,
--total_vaccinations bigint
--)
--INSERT INTO #percent_pop_vaxx
---- The original query remains the same
--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--	SUM(CAST(vac.new_vaccinations as BIGINT)) OVER
--	(PARTITION BY dea.location ORDER BY dea.location, dea.date) as 'total_vaccinations'
--	--,(total_vaccinations/population)*100 as 'percent_pop_vac' -- we wish to do this! CTE!
--FROM Covid..covid_deaths dea
--JOIN Covid..covid_vaccinations vac
--	ON dea.location = vac.location
--	AND dea.date = vac.date
--WHERE dea.continent is not null
---- ORDER BY 2,3 

--SELECT *, (total_vaccinations/population)*100 as 'percent_pop_vac'
--FROM #percent_pop_vaxx
--ORDER BY 2,3


---- Finally, let's create a view to store data for later visualizations
--CREATE VIEW percent_pop_vaxxx as
--(
--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--	SUM(CAST(vac.new_vaccinations as BIGINT)) OVER
--	(PARTITION BY dea.location ORDER BY dea.location, dea.date) as 'total_vaccinations'
--	--,(total_vaccinations/population)*100 as 'percent_pop_vac' -- we wish to do this! CTE!
--FROM Covid..covid_deaths dea
--JOIN Covid..covid_vaccinations vac
--	ON dea.location = vac.location
--	AND dea.date = vac.date
--WHERE dea.continent is not null
----ORDER BY 2,3
--)

--
--
-- Straighforward queries for Tableau purposes
-- 1)

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Covid..covideaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

-- 2)
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Covid..covid_deaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc

-- 3)
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Covid..covid_deaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc

-- 4)
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Covid..covid_deaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc
