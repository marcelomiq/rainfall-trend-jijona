# 🌧️  Rainfall Trend Analysis in Jijona – 50-Year Weather Data Project
📌 Description
This project is a data engineering and analytics pipeline built to explore rainfall trends in Jijona (Spain) over the last 50 years. It includes data ingestion, cleaning, transformation, and visualization, offering insights into how rainfall has evolved in this region over time.

---
 
⚙️ Tech Stack

PostgreSQL – database for storing weather data

Python

Pandas & NumPy – for data wrangling

DBT – data transformation and modeling

Airflow – orchestration of ETL pipeline

PowerBI – data visualization

---

📂 Project Steps

This project follows a structured data engineering pipeline:

  📤 Upload raw data to S3

    Large weather datasets (CSV/JSON) are uploaded to an Amazon S3 bucket.
    
    This ensures data is accessible, secure, and version-controlled.

  ⬇️ Data ingestion
  
    A Python script inserts data from the S3 bucket to the RDS postgres database
  
  🗄️ Load into PostgreSQL
  
    Cleaned data is stored in a PostgreSQL RDS database.
    
    Tables are created if they don't exist.
  
  🏗️ Transform with DBT
  
    DBT models are used to:

    Load data from staging table to dimension and fact table
        
    Create materialized views for analysis
  
  📅 Schedule with Airflow
  
    Airflow orchestrates the pipeline:
    
    Ingest → Transform
  
  📊 Analyze and visualize
  
    Final data is consumed from Power BI, where visualization are built
