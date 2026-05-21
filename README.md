# MovieLens Analytics Engineering Project with dbt + Snowflake

## Overview
This project demonstrates an end-to-end analytics engineering workflow built with **dbt** and **Snowflake** using MovieLens-style movie, rating, tag, and genome relevance data.

The project organizes raw data into a layered transformation architecture:

- **Staging models** standardize raw source tables
- **Dimension models** define reusable descriptive entities
- **Fact models** support analytical reporting and downstream analysis
- **Mart models** enrich transformed data for business-facing use cases
- **Seeds, snapshots, macros, and tests** demonstrate key dbt development patterns

## Project Goals
The purpose of this project is to showcase practical dbt concepts in a compact portfolio project, including:

- Source definitions and model dependency management with `source()` and `ref()`
- Layered SQL transformations across staging, dimensional, fact, and mart models
- Incremental model logic
- Snapshot configuration for historical tracking
- Seed-based reference data enrichment
- Custom macro usage
- Schema and singular data testing
- Reusable analytical SQL in the `analyses/` folder

## Tech Stack
- **Data warehouse:** Snowflake
- **Transformation framework:** dbt Core
- **SQL:** Snowflake SQL 

## Data Inputs
The project is structured around raw MovieLens-style tables stored in Snowflake, including:

- Movies
- Ratings
- Tags
- Genome tags
- Genome scores
- Links

A small seed file is also included to demonstrate how dbt seeds can enrich model outputs with reference data:

- `seed_movie_release_dates.csv`

## Project Structure
```text
dbt_Project/
├── analyses/
│   └── movie_analysis.sql
├── macros/
│   └── no_null_in_columns.sql
├── models/
│   ├── dim/
│   │   ├── dim_genome_tags.sql
│   │   ├── dim_movies.sql
│   │   ├── dim_movies_with_tags.sql
│   │   └── dim_users.sql
│   ├── fct/
│   │   ├── fct_genome_scores.sql
│   │   └── fct_ratings.sql
│   ├── mart/
│   │   └── mart_movie_releases.sql
│   ├── staging/
│   │   ├── src_genome_score.sql
│   │   ├── src_genome_tags.sql
│   │   ├── src_links.sql
│   │   ├── src_movies.sql
│   │   ├── src_ratings.sql
│   │   └── src_tags.sql
│   ├── schema.yml
│   └── sources.yml
├── seeds/
│   └── seed_movie_release_dates.csv
├── snapshots/
│   └── snap_tags.sql
├── tests/
│   └── relevence_score_test.sql
├── dbt_project.yml
├── packages.yml
└── package-lock.yml
```

## Modeling Layers

### 1. Staging Models
The staging layer standardizes raw source data by:
- Renaming columns into consistent snake_case naming
- Converting timestamp fields into Snowflake timestamp types
- Creating clean, reusable source-aligned models

### 2. Dimension Models
Dimension models provide descriptive entities used in analysis:
- `dim_movies`: standardized movie metadata
- `dim_users`: unique users across ratings and tags
- `dim_genome_tags`: cleaned tag definitions
- `dim_movies_with_tags`: a reusable intermediate model that combines movies, tags, and genome scores

### 3. Fact Models
Fact models capture measurable analytical events:
- `fct_ratings`: rating-level fact table with incremental processing logic
- `fct_genome_scores`: relevance scores between movies and tags

### 4. Mart Model
- `mart_movie_releases`: enriches ratings with release-date availability using a seed-based reference table

## dbt Features Demonstrated

### Sources
Raw Snowflake tables are declared in `sources.yml` and referenced through dbt source configuration.

### Seeds
The project includes a CSV seed to demonstrate lightweight reference-data ingestion.
```bash
dbt seed
```

### Incremental Models
`fct_ratings` is configured as an incremental model and loads only rows with a newer rating timestamp on incremental runs.

### Snapshots
`snap_tags` is included as a compact demonstration of dbt’s timestamp snapshot pattern for historical tracking, using:
- `timestamp` strategy
- `updated_at`
- hard-delete invalidation
Run with:
```bash
dbt snapshot
```

### Macros
The `no_nulls_in_columns` macro checks whether any column in a model contains null values.

### Testing
The project includes:
- Schema tests defined in `schema.yml`
- A custom singular test file in `tests/`
Run with:
```bash
dbt test
```

### Analysis SQL
`analyses/movie_analysis.sql` contains an analytical query that identifies highly rated movies with a minimum rating-count threshold.

## Key Learning Outcomes
This project demonstrates how dbt can be used to:
- Build a maintainable SQL transformation workflow
- Organize a warehouse into clear modeling layers
- Improve model reusability through `ref()` relationships
- Add data quality validation with tests and macros
- Track historical changes with snapshots
- Enrich transformation logic with seeds
- Support analytical exploration through reusable analysis queries

## Notes
This is a learning and portfolio project designed to demonstrate dbt patterns in a compact environment. Some model choices intentionally prioritize concept coverage and readability over production-scale design complexity.



