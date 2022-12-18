# Covid_SQL
 
![GitHub top language](https://img.shields.io/github/languages/top/hbatistuzzo/Covid_SQL)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/hbatistuzzo/Covid_SQL)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/hbatistuzzo/Covid_SQL)
![GitHub last commit](https://img.shields.io/github/last-commit/hbatistuzzo/Covid_SQL)

# Project objective

*** Exploratory Analysis of a Covid-19 Dataset using SQL ***
I've done this project to showcase my skills related to:

- Joins
- CTE's
- Temporary Tables
- Windows Functions
- Aggregate Functions
- Creating Views
- Converting Data Types

Datasets can be found at : https://ourworldindata.org/covid-deaths (btw, super useful repository for projects in data science 🤘)

---

# Technologies

- Python 3.8.13
	- Pandas 1.4.4
	- Numpy 1.21.5
	- Pycaret 2.3.10
	- Seaborn 0.11.2
	- Matplotlib 3.5.2
	- Scikit-learn 1.1
- Tableau 2022.3
- Microsoft SQL Server Management Studio (SSMS) 18.12.1

---

## The files

I have artificially divided the original dataset with all the info (available on the site above) into two separate datasets: `covid_deaths.csv` and `covid_vaccinations.csv`. This was done in order to demonstrate the usefulness of SQL joins when data comes in broken pieces.

## The dataset

- Myriad info on Covid cases per country. The dataset has a total of *68* attributes so rather than detailing each and every column, I will bring them up as needed.
- An initial exploration will be focused on the *population* attribute. Later, I expect to do some additional tinkering with other attributes that look particularly useful (e.g. is the patient a smoker? Do they have comorbidities?).

## SSMS

- This was a good opportunity to try out a new tool, Microsoft SSMS. MySQL and PostgreSQL are my tools of choice for relational databases, but it never hurts to explore!
- That being said, with the back-end being coded in the ancient eldritch tongues of the elder Microsoft gods, it is impossible to avoid a plethora of system conflicts (especially related to 32/64bit issues).
	- Say you want to import that `covid_deaths.csv` file into SSMS. Its own tools will not suffice, as you will run into more and more errors of duplicitous meaning. 

<p align="center"><img src="images/sql1.png"width="100%"/></p>

- Thankfully, SSMS's sister program, _Microsoft SQL Server_, comes packaged with its own "SQL Server Import and Export data" 64-bit application.

<p align="center"><img src="images/sql2.png"width="100%"/></p>

... Which works! Will this be the last time we are confounded by this Microsoft treachery? I highly doubt it. Anyway:




