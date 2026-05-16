WITH ratings AS (
                SELECT DISTINCT user_id
                FROM {{ ref('src_ratings') }}
                ),

tags AS (
        SELECT DISTINCT user_id
        FROM {{ ref('src_tags') }}
        )

SELECT user_id
FROM ratings

UNION

SELECT user_id
FROM tags
