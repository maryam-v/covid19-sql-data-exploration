# COVID‑19 SQL Data Exploration (Portfolio Project)


This project explores global COVID‑19 dynamics using **SQL Server** across two tables:
# COVID-19 SQL Data Exploration

This project explores global COVID-19 data using **SQL (T-SQL, SQL Server)**.  
It analyzes cases, deaths, testing, and vaccination progress across countries and continents.

---

## 🔹 Project Overview
The purpose of this project is to:
- Showcase **SQL data exploration and analysis skills**.
- Derive meaningful insights from the COVID-19 dataset.
- Build reusable queries for **visualization in BI tools** (Power BI, Tableau, etc.).

**Skills demonstrated:**
- Joins, CTEs, Temp Tables, Views  
- Window Functions & Aggregate Functions  
- Data Type Conversion
- Time-series rollups (weekly, monthly trends)  
- KPI calculations (Case Fatality Rate, Positivity Rate, Vaccination Coverage)  

---

## 🔹 Dataset
- **CovidDeaths**: Daily cases, deaths, population, demographics, and health system indicators.  
- **CovidVaccinations**: Daily vaccinations, tests, and related indicators.  
- Source: [Our World in Data – COVID-19 Dataset](https://ourworldindata.org/covid-deaths)  

---

## 🔹 Key Analyses
1. **Descriptive Analysis**
   - Total cases, deaths, and infections per population  
   - Case Fatality Ratio (CFR) by country  
   - Global and continental leaderboards  

2. **Vaccination Insights**
   - Rolling vaccinations over time (window functions)  
   - Percent of population vaccinated (CTEs, Temp Tables, Views)  
   - Top 10 countries by vaccine coverage  

3. **Trend Analysis**
   - Monthly and weekly case/death rollups  
   - Daily global totals with CFR  
   - Continental comparisons over time  

4. **Advanced Metrics**
   - Testing vs cases → Positivity Rate  
   - Hospital capacity (beds/1k) vs deaths  
   - GDP per capita vs COVID outcomes
     
---

## 🔹 Dashboard
Explore the interactive dashboard built in **Tableau Public**:  
👉 [COVID-19 Dashboard – Tableau](https://public.tableau.com/app/profile/maryam.valipour/viz/covid19_dashboard_17593376812050/Dashboard1)  

### Preview
![Dashboard Preview](images/dashboard.png)

---

## 🔹 How to Run
1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/covid19-sql-data-exploration.git

- `CovidDeaths` – cases, deaths, and demographic/health indicators (by country, daily)
- `CovidVaccinations` – tests, vaccinations, and related indicators (by country, daily)

## How to Run
1. Open `covid_exploration.sql` in SQL Server Management Studio / Azure Data Studio.
2. Update schema prefixes if needed (e.g., `PortfolioProject..` -> `dbo.`).
3. Execute sections incrementally, or run all to create helper **views** for BI tools.


## Analyses
- **Descriptive KPIs**: Total cases, deaths, percent infected, country and continent leaderboards
- **Vaccination Coverage**: Rolling sums and coverage % via window functions
- **Global Timeline**: Daily totals + global CFR
- **Trends**: Monthly and weekly case/death rollups
- **Testing vs Cases**: Positivity proxies using tests vs cases
- **Top 10 Vaccinated Countries**: Coverage leaderboard
- **Capacity Proxies**: Hospital beds vs total deaths
- **Socioeconomic Proxies**: GDP per capita vs outcomes


---
