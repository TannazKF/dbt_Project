WITH ratings_summary AS (
  SELECT
    movie_id,
    ROUND(AVG(rating), 2) AS average_rating,
    COUNT(*) AS total_ratings
  FROM {{ ref('fct_ratings') }}
  GROUP BY movie_id
  HAVING COUNT(*) > 100 -- Keep only movies with sufficient rating volume 
)
SELECT
  m.movie_title,
  rs.average_rating,
  rs.total_ratings
FROM ratings_summary rs
JOIN {{ ref('dim_movies') }} m ON m.movie_id = rs.movie_id
ORDER BY rs.average_rating DESC
LIMIT 20;
