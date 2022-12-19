# COVID SQL Project

![GitHub top language](https://img.shields.io/github/languages/top/hbatistuzzo/Covid_SQL)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/hbatistuzzo/Covid_SQL)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/hbatistuzzo/Covid_SQL)
![GitHub last commit](https://img.shields.io/github/last-commit/hbatistuzzo/Covid_SQL)

> __Warning__ In Progress!

# Project objective

**Exploratory Analysis of a Covid-19 Dataset using SQL**

I've done this project to showcase my skills related to:

- Joins
- CTE's
- Temporary Tables
- Windows Functions
- Aggregate Functions
- Creating Views
- Converting Data Types

Datasets can be found at : https://ourworldindata.org/covid-deaths
- (btw, super useful repository for projects in data science 🤘)

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

- ... Which will also fail unless you have previously installed the Microsoft Integration Services.
	- You hadn't? Well uninstall Microsoft Server entirely and follow the custom instructions included [in this cryptic page from Microsoft itself](https://learn.microsoft.com/en-us/sql/integration-services/install-windows/install-integration-services?view=sql-server-ver16).
	- You might as well go prepare a cup of coffee and check your blood pressure in the meantime because this unninstaller will take its sweet time.
	- Now you are ready to perform a custom install. Mind the warnings that your Microsoft Firewall will probably block some of the ports necessary to run this whole operation.
	- After the inevitable failure of the first installation, you might be tempted to go down the internet rabbit hole that is the dreamlike experience of properly installing this godforsaken SQL package.
		- Instead, mind the footnote hanging at the __very end__ of the troubleshoot page, which tells you that this whole operation _will not work_ unless you *also* install the optional shared feature of Database Engine Services:

<p align="center"><img src="images/sql3.png"width="100%"/></p>

- While you reinstall everything, realize that Steve Jobs might have had a point after all, as only savants could possibly decypher these instructions from Microsoft on a first try.
- Eons will have passed, but time flows like a river and you will find yourself (hopefully, maybe) in possession of a semi-working version of Microsoft Server. I sure hope you have read the fine print of the terms and conditions where our Microsoft overlords ask nothing more from you than your undying loyalty, pity donations, and several liters of your blood to fuel their genesis device.
- Finally, fire up the import/export wizard and retrieve the .xlsx's. Will this be the last time we are confounded by this Microsoft treachery? I highly doubt it.

---

Anyway. With that out of the way, we are ready to run some queries. The syntax is, as usual, very similar to that used in other RMDBs.
- The feature to display more two or more outputs at the same time can be very convenient too:

<p align="center"><img src="images/sql4.png"width="100%"/></p>

- You can comment text from the editor with the command `ctrl-K --> ctrl-C`, which is absolutely bananas. Hard to forget though.

---
---
---

# Queries

- These will be focused on Brazillian cases, though the syntax is very easily changed on the sql file `SQL_covid.sql`.

## $\color{orange}{\textrm{Total Cases VS Total Deaths.}}$

- What does the mortality look like?

```
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'death%'
FROM Covid..covid_deaths
order by 1,2
```

| Location | Date                    | total_cases | total_deaths | death%           |
|----------|-------------------------|-------------|--------------|------------------|
| Brazil   | 2020-02-26 00:00:00.000 | 1           | NULL         | NULL             |
| Brazil   | 2020-02-27 00:00:00.000 | 1           | NULL         | NULL             |
| Brazil   | 2020-02-28 00:00:00.000 | 1           | NULL         | NULL             |
| Brazil   | 2020-02-29 00:00:00.000 | 2           | NULL         | NULL             |
| ---      | ---                     | ---         | ---          | ---              |
| Brazil   | 2022-12-13 00:00:00.000 | 35696918    | 691178       | 1.93623998576012 |
| Brazil   | 2022-12-14 00:00:00.000 | 35751411    | 691449       | 1.93404674293834 |
| Brazil   | 2022-12-15 00:00:00.000 | 35809832    | 691652       | 1.9314583771295  |
| Brazil   | 2022-12-16 00:00:00.000 | 35869526    | 691810       | 1.92868453293751 |

**insights**
- Most countries attain a Death% of ~2-4% after the infection is widespread.
	- Usually lower in 1st world countries.
	- Lethality is not a significative measure when gauging the impact that a pandemic will have on society as a whole.
	- Yet we are left to wonder the macabre outcomes that would result from a more lethal disease.


In Brazil, as of 12/16/2022, Brazil had close to 36 million registered cases. Close to 700.000 registered deaths. Roughly 10 Maracanã stadiums packed full. Most of these deaths avoidable after the development of a number of vaccines.
<p align="center"><img src="/images/maracana.jpeg" width="60%"/></p>

---

## $\color{orange}{\textrm{Total Cases VS Population.}}$

- What (rough) percentage of the population got infected?
	- Very similar to the last query, our last column is a ratio of the 2 previous ones.

```
SELECT Location, date, total_cases, Population, (total_cases/Population)*100 as 'case%'
FROM Covid..covid_deaths
WHERE location = 'Brazil'
order by 1,2 
```

| Location | Date                    | total_cases | Population | cases%               |
|----------|-------------------------|-------------|------------|----------------------|
| Brazil   | 2020-02-26 00:00:00.000 | 1           | 215313504  | 4.64439053483612E-07 |
| Brazil   | 2020-02-27 00:00:00.000 | 1           | 215313504  | 4.64439053483612E-07 |
| Brazil   | 2020-02-28 00:00:00.000 | 1           | 215313504  | 4.64439053483612E-07 |
| Brazil   | 2020-02-29 00:00:00.000 | 2           | 215313504  | 9.28878106967225E-07 |
| ---      | ---                     | ---         | ---        | ---                  |
| Brazil   | 2022-12-13 00:00:00.000 | 35696918    | 215313504  | 16.5790428082021     |
| Brazil   | 2022-12-14 00:00:00.000 | 35751411    | 215313504  | 16.6043514855436     |
| Brazil   | 2022-12-15 00:00:00.000 | 35809832    | 215313504  | 16.6314844794872     |
| Brazil   | 2022-12-16 00:00:00.000 | 35869526    | 215313504  | 16.6592087043458     |


- The last line being the most useful here, we see that almost 17% of the country registered Covid cases. This number is probably over 1/5 considering that a lot of patients were asymptomatic (or decided not to check into a hospital).
	> __Note__ at this point we must realize that SQL enables us to put the data under a microscope and query exactly what we want to see for, say, a specific range of date or a specific location. Later, however, we can input this same data into Tableau and get a bird-eye's view of the situation. Perhaps, even.. animate a global map?

---

## $\color{orange}{\textrm{Looking at countries with highest infection rate compared to population.}}$

```
SELECT Location, Population, MAX(total_cases) as 'Highest_Infection_Count', MAX((total_cases/Population)*100) as '%_pop_infected'
FROM Covid..covid_deaths
GROUP BY Location, Population
ORDER by 4 DESC 
```

| Location       | Population | Highest_Infection_Count | %_pop_infected   |
|----------------|------------|-------------------------|------------------|
| Cyprus         | 896007     | 625562                  | 69.8166420574839 |
| San Marino     | 33690      | 22615                   | 67.1267438409024 |
| Faeroe Islands | 53117      | 34658                   | 65.2484138787959 |
| Austria        | 8939617    | 5639992                 | 63.0898616797565 |
| Gibraltar      | 32677      | 20252                   | 61.9763136150809 |
| Slovenia       | 2119843    | 1285920                 | 60.6610961283453 |
| Andorra        | 79843      | 47606                   | 59.6245131069724 |
| Brunei         | 449002     | 264490                  | 58.9061964089247 |
| Denmark        | 5882259    | 3371791                 | 57.3213624221579 |
| France         | 67813000   | 38841776                | 57.2777726984502 |

- As of Dec. 2022, a staggering amount of people has been infected with Covid. Since many cases are recorded as re-infection, this number probably overshoots the mark somewhat.
	- Does it discern against tourists? Look into.

---

## $\color{orange}{\textrm{Looking at countries with highest death count per population.}}$

```
SELECT Location, MAX(cast(total_deaths as bigint)) as Total_Death_Count
FROM Covid..covid_deaths
GROUP BY Location
ORDER by 2 DESC 
```
> __Warning__ total_deaths is an nvarchar(255) attribute originally, so we need to cast it as an integer in order to make this work.

> __Warning__ the WHERE clause is necessary to avoid selecting groupings of countries e.g. by continents.

| Location       | Total_Death_Count |
|----------------|-------------------|
| United States  | 1087398           |
| Brazil         | 691810            |
| India          | 530667            |
| Russia         | 384974            |
| Mexico         | 330743            |
| Peru           | 217821            |
| United Kingdom | 213148            |
| Italy          | 183138            |
| France         | 160428            |
| Indonesia      | 160362            |
| Germany        | 159884            |
| Iran           | 144659            |
| Colombia       | 141881            |
| Argentina      | 130041            |
| Ukraine        | 118613            |
| Poland         | 118419            |
| Spain          | 116658            |
| South Africa   | 102568            |
| Turkey         | 101203            |
| Romania        | 67310             |

- The US, as expected, leads the world in deaths due to the sheer amount of transport/contact of people.
- Despite having about 1/7 of India's population, Brazil has surpassed it in deaths, sadly reflecting not the unpreparedness of our public health system (quite the opposite, as it is a world standard in quality together with the UK's NHS), but rather the systematic negationist views of the federal government when dealing with the pandemic.










