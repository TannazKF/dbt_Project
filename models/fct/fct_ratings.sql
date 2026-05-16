{{
  config(
    materialized = 'incremental',
  unique_key = 'rating_key'
    on_schema_change='fail'
  )
}}

WITH src_ratings AS (
  SELECT * FROM {{ ref('src_ratings') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key([
        'user_id',
        'movie_id',
        'rating_timestamp'
    ]) }} AS rating_key,
  user_id,
  movie_id,
  rating,
  rating_timestamp
FROM src_ratings
WHERE rating IS NOT NULL

{% if is_incremental() %}
  AND rating_timestamp > (SELECT MAX(rating_timestamp) FROM {{ this }})
{% endif %}
