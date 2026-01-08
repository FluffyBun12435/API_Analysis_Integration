# Automated Data Integration Pipeline: API to MySQL

## Project Overview
This project demonstrates a professional **ETL (Extract, Transform, Load)** workflow. It automates the process of fetching real-time repository data from the **GitHub REST API** and persisting it into a **MySQL database**.

## Technical Workflow
1. **Extraction**: Programmatically retrieved repository metadata using `requests`.
2. **Transformation**: Processed unstructured JSON into structured `Pandas` DataFrames, selecting key metrics like `name`, `id`, and `stargazers_count`.
3. **Storage**: Leveraged `SQLAlchemy` to build a modular database handler for seamless data ingestion.
4. **Validation**: Implemented a Python-based verification script to ensure data consistency without relying on GUI tools.

## Why This Matters
- **Modularity**: Separation of concerns between API logic and Database logic.
- **Automation**: Replaces manual CSV imports with a "one-click" synchronization script.
- **Scalability**: The architecture can be easily adapted for other data sources (e.g., Google Analytics, Financial APIs).