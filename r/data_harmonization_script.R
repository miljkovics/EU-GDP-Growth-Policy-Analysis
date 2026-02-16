#PROJECT NAME:
#Education level and savings level impact on real GDP per capita in Europe
#DATE:2/15/2026
#AUTHOR: Strahinja Miljkovic 

library(tidyverse)

#I had an error bellow with seting my directory I will leave the code as it is 

setwd("C:\Users\strah\Desktop\First_Project_for_Portfolio")

#Fixed code for the directory

setwd("C:/Users/strah/Desktop/First Project for Portfolio")

#Since the datasets where from Eurostat I had to open them in notepad
#In order to see which are the correct labels for the geographical data

#Now finaly time to load the datasets and clean them 
#By making na = ":" I cover for any data that could compromise the analysis 
#ALSO ONE IMPORTANT POINT I HAVE DOWNOADED CUSTOM DATASETS FROM EUROSTAT
#So I already know whats in them I had to check before

edu <- read_csv("Education_levels_2013-2023.csv", na = ":") %>%
  select(geo, TIME_PERIOD, OBS_VALUE)%>%
  rename(country = geo, year = TIME_PERIOD, edu_rate = OBS_VALUE)%>%
  mutate(year = as.integer(year))

View(edu)

#I had an error message so I had to check for anything however nothing happend
#Entire table is fine so I will continue with cleaning other datasets the same way

savings <- read.csv("Savings_levels_2013-2023.csv", na = ":")%>%
  select(geo, TIME_PERIOD, OBS_VALUE)%>%
  rename(country = geo, year = TIME_PERIOD, savings_rate = OBS_VALUE)

#So before going to the third dataset I cought an issue 
#Year is numeric in the edu dataset so I will have to mutate it to intiger
#I will fix it now in the upper part for the edu data 
#And I will have it mutated for the third dataset 

gdp <- read.csv("Real_gdp_per_capita_2013-2023.csv", na = ":")%>%
  select(geo, TIME_PERIOD, OBS_VALUE)%>%
  rename(country = geo, year = TIME_PERIOD, gdp_per_capita = OBS_VALUE)%>%
  mutate(year = as.integer(year))


#Now I will use joins to make everything into one dataset before going to SQL

master_data <- edu%>%
  inner_join(savings, by = c("country","year"))%>%
  inner_join(gdp, by = c("country","year"))%>%
  drop_na()

#I will save the master_data as a CSV so that I can move to SQL 

write_csv(master_data, "Europe_case_study_master.csv")

#Thank you for your patience now we shall move to SQL 

#After SQL analysis I found a positive correlation of 1 between -> 
#Savings and GDP per capita 5 years ahead (so 2013 savings and 2018 GDP )
#CORR OF 1 IS BASICALLY IMPOSSIBLE SO I HAVE TO COME BACK HERE TO TEST IT 
#That is extreme for a correlation so I had to come back here to see if its true
#Now I will run the code to find the p-value and R-squared

regression_data <- master_data %>%
  group_by(country) %>%
  mutate(gdp_5yr_future = lead(gdp_per_capita, 5)) %>%
  drop_na(gdp_5yr_future) 


model <- lm(gdp_5yr_future ~ savings_rate, data = regression_data)

summary(model)

#Now statistics for current education level and and savings
#Idea is to guage if the people are more educated now do they save more now?

edu_savings_model <- lm(savings_rate ~ edu_rate, data = master_data)

summary(edu_savings_model)

#Now that I have everything I need I will move to Tableu -> 
#To make interactive dashbord I wanted to with all of this info
