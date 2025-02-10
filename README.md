# Layoffs_sights

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


