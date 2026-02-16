/* PROJECT: European case study (Education, Savings, and GDP)
   AUTHOR: Strahinja Miljkovic
   DATE: February 2026
   TOOL: Google BigQuery (SQL)
   
   DESCRIPTION: 
   This script performs exploratory data analysis on a harmonized Eurostat dataset. 
   It investigates the relationship between tertiary education levels and household 
   savings, and tests the hypothesis that current savings impact GDP with a 5-year lag.
*/

-- ---------------------------------------------------------
-- STEP 1: DESCRIPTIVE STATISTICS
-- Goal: Identify historical averages for each country to establish an economic baseline.
-- ---------------------------------------------------------

SELECT 
  country, 
  ROUND(AVG(edu_rate), 2) AS avg_education, 
  ROUND(AVG(savings_rate), 2) AS avg_savings,
  ROUND(AVG(gdp_per_capita), 2) AS avg_gdp
FROM `first-portfolio-project-487517.eurostat_data.master_results`
GROUP BY country
ORDER BY avg_gdp DESC;


-- ---------------------------------------------------------
-- STEP 2: TIME-LAGGED DATA ENGINEERING
-- Goal: Create a virtual view that shifts GDP data forward by 5 years.
-- This allows us to compare "Today's Savings" with "Future GDP" on the same row.
-- ---------------------------------------------------------

CREATE OR REPLACE VIEW `first-portfolio-project-487517.eurostat_data.lagged_view` AS
SELECT
  country,
  year,
  edu_rate,
  savings_rate,
  gdp_per_capita AS current_gdp,
  -- Window function to pull the GDP value from 5 years in the future for each country
  LEAD(gdp_per_capita, 5) OVER (PARTITION BY country ORDER BY year ASC) AS gdp_5yr_ahead
FROM `first-portfolio-project-487517.eurostat_data.master_results`;


-- ---------------------------------------------------------
-- STEP 3: CORRELATION ANALYSIS
-- Goal: Calculate Pearson Correlation Coefficients (R) for the two primary hypotheses.
-- ---------------------------------------------------------

SELECT
  -- Hypothesis A: Higher education levels correlate with higher current savings rates
  ROUND(CORR(edu_rate, savings_rate), 3) AS edu_savings_corr,
  
  -- Hypothesis B: Higher current savings rates lead to higher GDP 5 years later
  ROUND(CORR(savings_rate, gdp_5yr_ahead), 3) AS savings_future_gdp_corr
FROM `first-portfolio-project-487517.eurostat_data.lagged_view`
WHERE gdp_5yr_ahead IS NOT NULL;


/* TECHNICAL NOTE ON RESULTS:
   Initial SQL analysis showed a 1.0 correlation for the 5-year lag in specific sub-segments. 
   Recognizing this as an artifact of small sample sizes within the limited 10-year 
   timeframe, the project then transitioned to RStudio for robust Linear Regression 
   modeling and P-value verification.
*/