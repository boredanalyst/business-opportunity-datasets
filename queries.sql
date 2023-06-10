SELECT
	interest_business.entity,
	interest_business.code
	interest_business.year,
	interest_business.share_interested,
	interest_business.gdp_per_capita,
	interest_business.population_estimate,
	time_to_business.days_to_start
FROM time_to_business
INNER JOIN interest_business
ON time_to_business.entity = interest_business.entity 
AND time_to_business.year = interest_business.year

DROP TABLE IF EXISTS businessopp_2010;
CREATE TABLE businessopp_2010 AS
SELECT * FROM business_opp
WHERE year >= 2010

ALTER TABLE businessopp_2010
DROP COLUMN code;

ALTER TABLE businessopp_2010
ADD time_category VARCHAR(100) DEFAULT 'none';

UPDATE businessopp_2010 SET time_category = 'Very slow'
WHERE days_to_start > 100;

UPDATE businessopp_2010
SET time_category = 'Slow'
WHERE days_to_start > 50 AND days_to_start < 99;

UPDATE businessopp_2010
SET time_category = 'Fast'
WHERE days_to_start < 49 AND days_to_start > 20;

UPDATE businessopp_2010
SET time_category = 'Very Fast'
WHERE days_to_start < 19;