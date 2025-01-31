-- Data Cleaning Project: ...

-- # Process: 
-- 1. Deleting duplicates 
-- 2. Stadradizing data 
-- 3. Removing Nulls and Blanks
-- 4. Removing any columns and row not necessary  

Select * 
From layoffs;

Create Table layoffs_staging 
Like layoffs;

Select *
From layoffs_staging;

Insert Into layoffs_staging
Select *
From layoffs;

-- 1. Deleting duplicates

Select *,
ROW_NUMBER() OVER(Partition by company, location,
 industry, total_laid_off, percentage_laid_off, 'date',
 stage, country, funds_raised_millions) As row_num
 From layoffs_staging;


With duplicate_CTE As
(
Select *,
ROW_NUMBER() OVER(Partition by company, location,
 industry, total_laid_off, percentage_laid_off, 'date',
 stage, country, funds_raised_millions) As row_num
 From layoffs_staging
)
Select *
From duplicate_CTE
Where row_num > 1;

CREATE TABLE layoffs_staging2 (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select * 
From layoffs_staging2;

Insert Into layoffs_staging2
Select *,
ROW_NUMBER() OVER(Partition by company, location,
 industry, total_laid_off, percentage_laid_off, 'date',
 stage, country, funds_raised_millions) As row_num
 From layoffs_staging;
 
Select *
From layoffs_staging2
Where row_num > 1;


Delete 
From layoffs_staging2
Where row_num > 1;

-- 2. Standardizing Data

Select *
From layoffs_staging2;

Select Distinct company, Trim(company)
From layoffs_staging2
Order by 1;

Update layoffs_staging2
Set company = Trim(company);


Select Distinct industry
From layoffs_staging2;

Update layoffs_staging2
Set industry = 'Crypto'
Where industry Like 'Crypto%';

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

-- let's take a look at these
SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';
-- nothing wrong here
SELECT *
FROM layoffs_staging2
WHERE company LIKE 'airbnb%';

Update layoffs_staging2
Set industry = Null
Where industry = '';

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

Update layoffs_staging2 t1
Join layoffs_staging2 t2
	ON t1.company = t2.company
Set t1.industry = t2.industry
Where t1.industry Is NULL 
And t2.industry Is Not NULL;    

Select `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
From layoffs_staging2;

Update layoffs_staging2 
Set `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

Alter Table layoffs_staging2
Modify `date` Date;

Select Distinct country
From layoffs_staging2;

Update layoffs_staging2
Set country = Trim(TRAILING '.' From country);


-- 3. Look at Null Values

Select *
From layoffs_staging2;

-- the null values in total_laid_off, percentage_laid_off, and funds_raised_millions all look normal. I don't think I want to change that
-- I like having them null because it makes it easier for calculations during the EDA phase

-- so there isn't anything I want to change with the null values


-- 4. Remove any columns or row not necessary

Select *
From layoffs_staging2;

Select *
From layoffs_staging2
Where total_laid_off Is NULL;

Select *
From layoffs_staging2
Where total_laid_off IS NULL
And percentage_laid_off IS NULL;

Delete 
From layoffs_staging2
Where total_laid_off IS NULL
And percentage_laid_off IS NULL;

Select *
From layoffs_staging2;

Alter Table layoffs_staging2
Drop Column row_num;


Select *
From layoffs_staging2;



