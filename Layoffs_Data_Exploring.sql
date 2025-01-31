-- Exploring Layoffs around the world over the 3 years from 2020 to 2023 
Select *
From layoffs_staging2;



-- Looking at Percentage to see how big these layoffs were
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;



-- Which companies had 1 which is basically 100 percent of they company laid off
SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1;
-- these are mostly startups it looks like who all went out of business during this time



-- if we order by funcs_raised_millions we can see how big some of these companies were
SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


-- if we order by funcs_raised_millions we can see how big some of these companies were
SELECT *
FROM layoffs_staging2
ORDER BY funds_raised_millions DESC;



-- Top 5 companies in layying off
Select company, total_laid_off, percentage_laid_off
From layoffs_staging2
Order By total_laid_off Desc
Limit 5;
-- Looks like most of them are big companies and their laying off percentage is small


-- Total laying off in companies ordered desc
Select company, Sum(total_laid_off)
From layoffs_staging2
Group By company
Order By 2 Desc
Limit 10;


-- Total laying off in industries ordered desc
Select industry, Sum(total_laid_off)
From layoffs_staging2
Group By industry
Order By 2 Desc
Limit 10;



-- Total laying off in countries ordered desc
Select country, Sum(total_laid_off)
From layoffs_staging2
Group By country
Order By 2 Desc;


-- Total laying off in cities ordered desc
Select location, Sum(total_laid_off)
From layoffs_staging2
Group By location
Order By 2 Desc;


-- Total laying off in years ordered desc
Select Year(date), Sum(total_laid_off)
From layoffs_staging2
Where date Is Not NULL
Group By Year(date)
Order By 1 Desc;




-- Let's look at Top companies laying off each year ...

With company_year As 
(
	Select company, Year(date) As years, Sum(total_laid_off) As total_laid_off
    From layoffs_staging2
    Group By company, Year(date)
), company_year_rank As
(
	Select company, years, total_laid_off, 
    Dense_Rank() Over(Partition By years Order By total_laid_off Desc) As ranking
    From company_year
)
Select  *
From company_year_rank
Where ranking <= 3 
And years is Not NULL
Order By years Asc, total_laid_off Desc;




-- rolling total of layoffs per month ...
Select substring(date, 1, 7) As dates, Sum(total_laid_off) As total_laid_off
From layoffs_staging2
Group By dates
Order by dates Asc;



-- Lets use it in CTE to be able to query off of it
With Dates_CTE As
(
	Select substring(date, 1, 7) As dates, Sum(total_laid_off) As total_laid_off
	From layoffs_staging2
	Group By dates
	Order by dates Asc
)
Select dates, Sum(total_laid_off) Over(Order By dates Asc) As rolling_total_layoffs
From Dates_CTE
Order By dates Asc;




