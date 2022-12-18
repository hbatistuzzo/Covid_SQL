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


