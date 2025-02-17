# Layoffs sights 

## Overview: 
This project focuses on the analysis of a dataset related to layoffs, aiming to explore trends, patterns, and insights through Exploratory Data Analysis (EDA). The raw data was cleaned and processed using MYSQL to ensure accuracy and reliability.


## Data Cleaning: ...

I went throw a Data cleaning process made up with 4 main steps:

1. Deleting duplicates:
   - Created new table for keeping my data safe
   - Inserted the data in the new table with a new column row_num using the ROW_NUM window function
   - then deleted any row with row_num greater than 1
2. Stadradizing data
   - Removing white spaces from the company column
   - Utilizing industries names
   - Updatting some companies industry
   - Altered date column to be a DATE type
   - Utilizing some countries names
3. Removing Nulls and Blanks
   - Looking in the NULL values I found that it was normal and didn't need to be removed or replaced
4. Removing any columns and row not necessary
   - Removed row where total_laid_off and percentage_laid_off were NULL
   - Finally removed the added colunm before row_num as it becomes unnessacary


## Data Exploratory Analysis: ...

The dataset includes the layoffs around the world in the interval from 2020 to 2023 which had some terrible time with the Corona disaster. 

- Looked for how big was these layoffs
- Which companies totally laid off their employees and found out most of it was startups
- Looked for some patterns with the funds the companies had and the percentage of layoffs
- Looked for the top 5 companies in layying off finding out that most of them were big companies and their layoff percentage was small
- Tried to look for patterns in total layoffs with companies, industries, countries and even cities 
- Finally, I looked at top companies layying off each year and even each month 

