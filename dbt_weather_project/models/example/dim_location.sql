
{{ config(materialized='table') }}

SELECT DISTINCT
  row_number() OVER (ORDER BY city_name, lat, lon) AS id,
  city_name,
  lat,
  lon
FROM (
    
    SELECT DISTINCT 
    city_name,
    lat,
    lon 
    FROM {{ ref('stg_weather_data') }} 
    )
