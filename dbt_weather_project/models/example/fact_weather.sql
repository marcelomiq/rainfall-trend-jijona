{{ config(materialized='table') }}

WITH base AS (

SELECT
  loc.id AS location_id,
  DATE(stg.dt_iso) as date,
  EXTRACT(YEAR FROM stg.dt_iso) AS year,

  COALESCE(AVG(COALESCE(stg.temp, 0)), 0) AS avg_temp,
  COALESCE(MIN(COALESCE(stg.temp_min, 0)), 0) AS min_temp,
  COALESCE(MAX(COALESCE(stg.temp_max, 0)), 0) AS max_temp,
  COALESCE(AVG(COALESCE(stg.feels_like, 0)), 0) AS avg_feels_like,
  COALESCE(AVG(COALESCE(stg.pressure, 0)), 0) AS avg_pressure,
  COALESCE(AVG(COALESCE(stg.humidity, 0)), 0) AS avg_humidity,
  COALESCE(AVG(COALESCE(stg.dew_point, 0)), 0) AS avg_dew_point,
  COALESCE(AVG(COALESCE(stg.wind_speed, 0)), 0) AS avg_wind_speed,
  COALESCE(AVG(COALESCE(stg.wind_deg, 0)), 0) AS avg_wind_deg,
  COALESCE(AVG(COALESCE(stg.wind_gust, 0)), 0) AS avg_wind_gust,
  COALESCE(AVG(COALESCE(stg.cloudiness, 0)), 0) AS avg_cloudiness,

  COALESCE(SUM(COALESCE(stg.rain_1h, 0)), 0) AS sum_rain_1h,
  COALESCE(SUM(COALESCE(stg.rain_3h, 0)), 0) AS sum_rain_3h,
  COALESCE(SUM(COALESCE(stg.snow_1h, 0)), 0) AS sum_snow_1h,
  COALESCE(SUM(COALESCE(stg.snow_3h, 0)), 0) AS sum_snow_3h,

  COALESCE(AVG(COALESCE(stg.visibility, 0)), 0) AS avg_visibility

FROM {{ ref('stg_weather_data') }} AS stg
JOIN {{ ref('dim_location') }} AS loc
  ON stg.city_name = loc.city_name
  AND stg.lat = loc.lat
  AND stg.lon = loc.lon

GROUP BY loc.id, DATE(stg.dt_iso), EXTRACT(YEAR FROM stg.dt_iso)

)

SELECT * FROM base
