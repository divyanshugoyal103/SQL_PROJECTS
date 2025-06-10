
--COUNT OF TITLES PER RATING--
SELECT
  rating,
  COUNT(*) AS rating_count
FROM NETFLIX_TITLES
GROUP BY rating
ORDER BY rating_count DESC;

--TITLES BY COUNTRIES--
SELECT
  country,
  COUNT(*) AS show_count
FROM NETFLIX_TITLES
WHERE country IS NOT NULL
GROUP BY country
ORDER BY show_count DESC
LIMIT 10;

--MOST COMMON GENRES--
WITH genre_exploded AS (
  SELECT
    TRIM(g) AS genre
  FROM NETFLIX_TITLES,
  UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS g
)
SELECT
  genre,
  COUNT(*) AS occurrences
FROM genre_exploded
GROUP BY genre
ORDER BY occurrences DESC
LIMIT 10;

--RANK DIRECTOR WITH MOST TITLES--
WITH dir_exploded AS (
  SELECT
    TRIM(d) AS director
  FROM NETFLIX_TITLES,
  UNNEST(STRING_TO_ARRAY(director, ',')) AS d
  WHERE director IS NOT NULL AND director <> ''
)
SELECT
  director,
  COUNT(*) AS title_count,
  RANK() OVER (ORDER BY COUNT(*) DESC) AS director_rank
FROM dir_exploded
GROUP BY director
HAVING COUNT(*) > 1
ORDER BY title_count DESC
LIMIT 10;

--RANK COUNTRIES WITH MOST TITLES--
WITH country_count AS(
SELECT 
country,
count(*)as title_count
from NETFLIX_TITLES
WHERE COUNTRY IS NOT NULL AND COUNTRY<>''
GROUP BY COUNTRY
)
SELECT
COUNTRY,
TITLE_COUNT,
RANK() OVER(ORDER BY TITLE_COUNT DESC) AS COUNTRY_RANK
FROM COUNTRY_COUNT
ORDER BY COUNTRY_RANK
LIMIT 10;
