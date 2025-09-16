-- Displaying the table
SELECT *
FROM MINI_PROJECTS.YOUTUBE_ANALYSIS.SUBS;


-- Checking Null values and duplicates
SELECT COUNT(*) AS Null_count
FROM MINI_PROJECTS.YOUTUBE_ANALYSIS.SUBS
WHERE VIDEO_VIEWS IS NULL;

SELECT youtuber, COUNT(*) AS count_duplicates
FROM MINI_PROJECTS.YOUTUBE_ANALYSIS.SUBS
GROUP BY youtuber
HAVING COUNT(*) > 1;

-- Key statistics
SELECT 
    ROUND(AVG(SUBSCRIBERS)) AS Avg_subscribers,
    ROUND(SUM(SUBSCRIBERS)) AS Total_subscribers,
    ROUND(AVG(VIDEO_VIEWS)) AS Avg_video_views,
    MIN(SUBSCRIBERS) AS Min_subscribers,
    MAX(SUBSCRIBERS) AS Min_subscribers,
    MIN(STARTED) AS Min_year,
    MAX(STARTED) AS Max_year
FROM MINI_PROJECTS.YOUTUBE_ANALYSIS.SUBS;
--------------------------------------------------------

SELECT 
    ROUND(AVG(VIDEO_VIEWS)) AS Avg_video_views,
    IFNULL(CATEGORY, 'Uncategorized') AS content_category,
 
-- Categorizing the years

    CASE 
        WHEN STARTED < 2005 THEN 'Pre-YouTube Era <2005'
        WHEN STARTED BETWEEN 2005 AND 2009 THEN 'Early YouTube Era 2005-2009'
        WHEN STARTED BETWEEN 2010 AND 2014 THEN 'Growth Era 2010-2014'
        WHEN STARTED BETWEEN 2015 AND 2019 THEN 'Mainstream Era 2015-2019'
        WHEN STARTED >= 2020 THEN 'Modern Era 2020+'
    END AS Year_started_bucket,
   

-- Average subscribers per content category
ROUND(AVG(SUBSCRIBERS)) AS Average_subscribers,

-- Top category by subscribers
ROUND(SUM(SUBSCRIBERS)) AS Total_subscribers,

-- TOP content category by video views
ROUND(SUM(VIDEO_VIEWS)) AS Total_views,

-- Top Youbers by subscribers 
YOUTUBER,
    
FROM MINI_PROJECTS.YOUTUBE_ANALYSIS.SUBS
GROUP BY YOUTUBER, CATEGORY, Year_started_bucket
ORDER BY Year_started_bucket, Average_subscribers, Total_subscribers;
