-- Data Cleaning Project
-- A. Remove Duplicates
-- B. Standardize the data
-- C. Null values or Blank values
-- D. Remove any columns

SELECT * FROM layoffs1;

-- A. Remove Duplicates
CREATE TABLE layoffs_prep LIKE layoffs1;

INSERT layoffs_prep
SELECT * FROM layoffs1;

SELECT * FROM layoffs_prep;

SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_prep;

WITH double_cte AS (
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_prep)
SELECT * FROM double_cte
WHERE row_num > 1;

SELECT * FROM layoffs_prep
WHERE company = 'Cazoo';

CREATE TABLE `layoffs_prep2` (
  `company` varchar(512) DEFAULT NULL,
  `location` varchar(512) DEFAULT NULL,
  `industry` varchar(512) DEFAULT NULL,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` varchar(512) DEFAULT NULL,
  `date` varchar(512) DEFAULT NULL,
  `stage` varchar(512) DEFAULT NULL,
  `country` varchar(512) DEFAULT NULL,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_prep2;

INSERT INTO layoffs_prep2
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_prep;

SELECT * FROM layoffs_prep2
WHERE row_num > 1;

DELETE FROM layoffs_prep2 WHERE row_num > 1;

SELECT * FROM layoffs_prep2
WHERE row_num > 1;

-- B. Standardizing Data
-- 1. company
SELECT DISTINCT company FROM layoffs_prep2 ORDER BY 1;

SELECT company, TRIM(company) FROM layoffs_prep2;

UPDATE layoffs_prep2
SET company = TRIM(company);

-- 2. Location
SELECT DISTINCT location FROM layoffs_prep2 ORDER BY 1;

-- 3. Industry
SELECT DISTINCT industry FROM layoffs_prep2 ORDER BY 1;

SELECT * FROM layoffs_prep2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_prep2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- 4. Country
SELECT DISTINCT country FROM layoffs_prep2 ORDER BY 1;

UPDATE layoffs_prep2
SET country = 'United States'
WHERE country LIKE 'United States%';

-- 5. Date
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y') FROM layoffs_prep2;

UPDATE layoffs_prep2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_prep2
MODIFY COLUMN `date` DATE;

-- 5. Stage
SELECT DISTINCT stage FROM layoffs_prep2;

-- C. Null or Blank Values
-- 1. Company
SELECT DISTINCT company FROM layoffs_prep2 ORDER BY 1;

-- 2. Location
SELECT DISTINCT location FROM layoffs_prep2 ORDER BY 1;

-- 3. Industry
SELECT DISTINCT industry FROM layoffs_prep2 ORDER BY 1;

SELECT * FROM layoffs_prep2 WHERE industry is NULL OR industry ='';

UPDATE layoffs_prep2
SET industry = NULL
WHERE industry = '';

SELECT * FROM layoffs_prep2 WHERE company = 'Airbnb';

SELECT t1.industry, t2.industry FROM layoffs_prep2 t1
JOIN layoffs_prep2 t2
	ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE layoffs_prep2 t1
JOIN layoffs_prep2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT * FROM layoffs_prep2 WHERE industry is NULL OR industry ='';

-- 4. Laid off 
SELECT * FROM layoffs_prep2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

DELETE FROM layoffs_prep2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- D. Remove any Columns
ALTER TABLE layoffs_prep2
DROP COLUMN row_num;

SELECT * FROM layoffs_prep2;