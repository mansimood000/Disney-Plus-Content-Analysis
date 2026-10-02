-- ============================================================
-- DISNEY+ CONTENT ANALYSIS
-- BUSINESS ANALYSIS PROJECT
-- ============================================================

USE disney_plus;


-- ============================================================
-- 1. UNDERSTAND THE DATA TIME PERIOD
-- Business Question:
-- What is the earliest and latest date on which titles
-- were added to the Disney+ catalog in this dataset?
-- ============================================================

SELECT
    MIN(date_added) AS earliest_added,
    MAX(date_added) AS latest_added
FROM disney_titles;


-- ============================================================
-- 2. CONTENT ADDITIONS BY YEAR
-- Business Question:
-- How many titles were added to the Disney+ catalog
-- in each year?
-- ============================================================

SELECT
    YEAR(date_added) AS Added_Year,
    COUNT(*) AS Titles_Added
FROM disney_titles
GROUP BY Added_Year
ORDER BY Added_Year;


-- ============================================================
-- 3. YEARS WITH THE HIGHEST CONTENT ADDITIONS
-- Business Question:
-- Which years had the highest number of titles added
-- to the Disney+ catalog?
-- ============================================================

SELECT
    YEAR(date_added) AS Added_Year,
    COUNT(*) AS Titles_Added
FROM disney_titles
GROUP BY Added_Year
ORDER BY Titles_Added DESC;


-- ============================================================
-- 4. CONTENT TYPE DISTRIBUTION
-- Business Question:
-- How many Movies and TV Shows are available in the
-- Disney+ catalog?
-- ============================================================

SELECT
    type,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY type;


-- ============================================================
-- 5. CONTENT RATING DISTRIBUTION
-- Business Question:
-- What are the most common content ratings in the
-- Disney+ catalog?
-- ============================================================

SELECT
    rating,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY rating
ORDER BY title_count DESC;


-- ============================================================
-- 6. CONTENT BY RELEASE YEAR
-- Business Question:
-- How many titles were released in each year?
-- ============================================================

SELECT
    release_year,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY release_year
ORDER BY release_year;


-- ============================================================
-- 7. MOVIES VS TV SHOWS BY RELEASE YEAR
-- Business Question:
-- How does the number of Movies and TV Shows vary
-- across release years?
-- ============================================================

SELECT
    release_year,
    type,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY release_year, type
ORDER BY release_year, type;


-- ============================================================
-- 8. TOP CONTENT CATEGORIES
-- Business Question:
-- Which content categories appear most frequently
-- in the Disney+ catalog?
-- ============================================================

SELECT
    primary_list,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY primary_list
ORDER BY title_count DESC;


-- ============================================================
-- 9. CONTENT BY COUNTRY
-- Business Question:
-- Which countries contribute the most titles to
-- the Disney+ catalog?
-- ============================================================

SELECT
    country,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY country
ORDER BY title_count DESC;


-- ============================================================
-- 10. CONTENT ADDED BY TYPE
-- Business Question:
-- How many Movies and TV Shows were added to the catalog
-- over time?
-- ============================================================

SELECT
    YEAR(date_added) AS Added_Year,
    type,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY Added_Year, type
ORDER BY Added_Year, type;


-- ============================================================
-- END OF BUSINESS ANALYSIS
-- ============================================================

SELECT
    rating,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY rating
ORDER BY title_count DESC;
-- ============================================================
-- 6. CONTENT BY RELEASE YEAR
-- Business Question:
-- How many titles were released in each year?
-- ============================================================

SELECT
    release_year,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY release_year
ORDER BY release_year;
-- ============================================================
-- 7. MOVIES VS TV SHOWS BY RELEASE YEAR
-- Business Question:
-- How does the number of Movies and TV Shows vary
-- across release years?
-- ============================================================

SELECT
    release_year,
    type,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY release_year, type
ORDER BY release_year, type;
-- ============================================================
-- 8. TOP CONTENT CATEGORIES
-- Business Question:
-- Which content categories appear most frequently
-- in the Disney+ catalog?
-- ============================================================

SELECT
    primary_list,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY primary_list
ORDER BY title_count DESC;
-- ============================================================
-- 9. CONTENT BY COUNTRY
-- Business Question:
-- Which countries contribute the most titles to
-- the Disney+ catalog?
-- ============================================================

SELECT
    country,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY country
ORDER BY title_count DESC;
-- ============================================================
-- 10. TITLES INVOLVING THE UNITED STATES
-- Business Question:
-- How many titles have the United States listed as
-- one of their contributing countries?
-- ============================================================

SELECT
    COUNT(*) AS US_involved_titles
FROM disney_titles
WHERE country LIKE '%United States%';

-- ============================================================
-- 11. CONTENT CATEGORY BY TYPE
-- Business Question:
-- How are Movies and TV Shows distributed across
-- the major content categories?
-- ============================================================

SELECT
    primary_list,
    type,
    COUNT(*) AS title_count
FROM disney_titles
GROUP BY
    primary_list,
    type
ORDER BY
    primary_list,
    title_count DESC;
    
    -- ============================================================
-- 12. CATEGORY COMPOSITION
-- Business Question:
-- How many Movies and TV Shows exist within each
-- content category?
-- ============================================================

SELECT
    primary_list,

    SUM(CASE
        WHEN type = 'Movie' THEN 1
        ELSE 0
    END) AS movie_count,

    SUM(CASE
        WHEN type = 'TV Show' THEN 1
        ELSE 0
    END) AS tv_show_count,

    COUNT(*) AS total_titles

FROM disney_titles

GROUP BY primary_list

ORDER BY total_titles DESC;


-- ============================================================
-- 13. CONTENT ADDITIONS BY YEAR AND TYPE
-- Business Question:
-- How many Movies and TV Shows were added to the
-- Disney+ catalog each year?
-- ============================================================

SELECT
    YEAR(date_added) AS added_year,

    SUM(CASE
        WHEN type = 'Movie' THEN 1
        ELSE 0
    END) AS movie_additions,

    SUM(CASE
        WHEN type = 'TV Show' THEN 1
        ELSE 0
    END) AS tv_show_additions,

    COUNT(*) AS total_additions

FROM disney_titles

WHERE date_added IS NOT NULL

GROUP BY YEAR(date_added)

ORDER BY added_year;

-- ============================================================
-- 14. DATE ADDED DATA QUALITY CHECK
-- Business Question:
-- Are there unusual concentrations in the date_added field?
-- ============================================================

SELECT
    date_added,
    COUNT(*) AS title_count
FROM disney_titles
WHERE date_added IS NOT NULL
GROUP BY date_added
ORDER BY title_count DESC
LIMIT 15;

-- ============================================================
-- 15. INVESTIGATE SUSPICIOUS DATE
-- Business Question:
-- Which titles are associated with the unusually
-- concentrated date 2012-11-19?
-- ============================================================

SELECT
    show_id,
    title,
    type,
    release_year,
    date_added
FROM disney_titles
WHERE date_added = '2012-11-19'
ORDER BY show_id
LIMIT 20;

-- ============================================================
-- 16. DATA QUALITY IMPACT
-- Business Question:
-- What percentage of the dataset is affected by the
-- suspicious date 2012-11-19?
-- ============================================================

SELECT
    COUNT(*) AS affected_titles,

    (SELECT COUNT(*)
     FROM disney_titles) AS total_titles,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM disney_titles),
        2
    ) AS affected_percentage

FROM disney_titles
WHERE date_added = '2012-11-19';

-- ============================================================
-- 17. MISSING DATE VALUES
-- Business Question:
-- How many titles have a missing date_added value,
-- and which titles are affected?
-- ============================================================

SELECT
    show_id,
    title,
    type,
    release_year,
    date_added
FROM disney_titles
WHERE date_added IS NULL
ORDER BY show_id;

-- ============================================================
-- 18. LONGEST MOVIES
-- Business Question:
-- Which Movies have the longest durations?
-- ============================================================

SELECT
    title,
    duration,
    CAST(
        REPLACE(duration, ' min', '')
        AS UNSIGNED
    ) AS duration_minutes

FROM disney_titles

WHERE type = 'Movie'
  AND duration LIKE '% min%'

ORDER BY duration_minutes DESC

LIMIT 10;

-- ============================================================
-- 19. CATEGORY RANKING
-- Business Question:
-- How do content categories rank by total number of titles?
-- ============================================================

WITH CategoryCounts AS (
    SELECT
        primary_list,
        COUNT(*) AS title_count
    FROM disney_titles
    GROUP BY primary_list
)

SELECT
    primary_list,
    title_count,

    RANK() OVER (
        ORDER BY title_count DESC
    ) AS category_rank

FROM CategoryCounts

ORDER BY category_rank;

-- ============================================================
-- 20. CONTENT TYPE SHARE OF CATALOG
-- Business Question:
-- What percentage of the Disney+ catalog is represented
-- by each content type?
-- ============================================================

WITH TypeCounts AS (
    SELECT
        type,
        COUNT(*) AS title_count
    FROM disney_titles
    GROUP BY type
)

SELECT
    type,
    title_count,

    ROUND(
        title_count * 100.0 /
        (SELECT COUNT(*) FROM disney_titles),
        2
    ) AS catalog_percentage

FROM TypeCounts

ORDER BY title_count DESC;