# COVID-19 SQL Data Exploration

This explores global COVID-19 data using **SQL (T-SQL, SQL Server)**.  
It analyzes cases, deaths, testing, and vaccination progress across countries and continents.

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

---

## 🔹 Dashboard
Explore the interactive dashboard built in **Tableau Public**:  
👉 [COVID-19 Dashboard – Tableau](https://public.tableau.com/app/profile/maryam.valipour/viz/covid19_dashboard_17593376812050/Dashboard1)  

### Preview
![Dashboard Preview](images/dashboard.png)

---

## 🔹 Project Structure
covid19-sql-data-exploration/
│
├── covid_data_exploration.sql # Main SQL script with data exploration & analysis
├── README.md # Project documentation
├── data
│ └── CovidDeaths.xlsx
│ └── CovidVaccinations.xlsx
├── images/ # Folder for screenshots & dashboard previews
│ └── covid19_dashboard.png

---

## 🔹 How to Run
1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/covid19-sql-data-exploration.git
2. Open `covid_exploration.sql` in **SQL Server Management Studio** or **Azure Data Studio**.  
3. Update schema prefixes if needed (e.g., `PortfolioProject..` → `dbo.`).  
4. Execute queries incrementally, or run all to create helper **views** for BI tools.  

## 🔹 Analyses Summary

- Descriptive KPIs: Total cases, deaths, infection % per population, country & continent leaderboards
- Vaccination Coverage: Rolling sums and coverage % via window functions
- Global Timeline: Daily totals + global CFR
- Trends: Monthly and weekly case/death rollups
- Testing vs Cases: Positivity proxies using tests vs cases
- Top 10 Vaccinated Countries: Vaccination coverage leaderboard
