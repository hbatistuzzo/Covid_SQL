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

-- Looking at countries with highest death count per population.
SELECT Location, MAX(cast(total_deaths as INT)) as Total_Death_Count
FROM Covid..covid_deaths
WHERE continent is not null
GROUP BY Location
ORDER by 2 DESC 