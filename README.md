# EU-GDP-Growth-Policy-Analysis
# EU Economic Analysis: Impact of Education & Savings on GDP (2013–2023)

## 🌎 Project Overview
This project evaluates the relationship between education, a proxy for financial literacy(savings rates) and economic outcome in terms of real gdp per capita in Europe.

### 📊 [View the Interactive Dashboard on Tableau Public](https://public.tableau.com/views/EuropeanSavingsVSEducation10yearAnalysisPrediction/Dashboard1)

![Dashboard Preview](https://github.com/user-attachments/assets/874f9308-1745-41dd-9447-93c07921d1aa)

---

## 💡 Key Policy Insights
Based on multiple linear regression models conducted in R, the analysis revealed:

* **Financial Literacy:** It is a major factor influencing economic prosperity. While the **savings rate** is used as a proxy for financial literacy here, it is important to acknowledge that many different factors influence savings rates and that being financialy literate does not necessarily mean you are able to have savings.
* **Education as a Key:** The education rate showed a significant positive correlation with economic performance ($p = 5.42 \times 10^{-09}$). However, as seen in the statistical tests, this relationship does not account for a very high percentage of the data(meaning that even though education correlates with savings rates accross countries obviously it is just a piece of the puzzle and many other factors impact savings rates as well)
* **Long-Term Predictability:** Using a 5-year lag model, the model uses the beta value calculated for the relationship between savings rates in one year and real gdp 5 years ahead. The data shows a rough projection of just one relationship and is not to be seen as a definitive prediction because many factors influence real gdp growth.

---

## 🛠️ Technical Stack & Workflow
This project utilizes a full-cycle data pipeline:

* **Data Sourcing:** Extracted longitudinal economic indicators from **Eurostat**.
* **Storage & Querying (SQL):** Used **BigQuery** to clean, join, and aggregate datasets and perform initial base analysis.
* **Statistical Analysis (R):** Performed data cleaning and linear regression in **RStudio**.
* **Visualization (Tableau):** Developed an interactive dashboard to communicate complex economic trends.

---

## 📂 Repository Structure
* `data/`: Contains `raw` Eurostat data and `processed` master files.
* `r/`: R scripts for data tidying and regression analysis.
* `sql/`: SQL queries used for data extraction and transformation.
* `tableau/`: The packaged workbook (.twbx) for the interactive dashboard.
* `reports/`: High-level Executive Summary and a detailed Technical Report (PDF).
* `images/`: Visual assets and statistical model outputs.

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
