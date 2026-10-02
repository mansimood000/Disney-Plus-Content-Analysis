# Disney+ Content Analysis

## Project Overview

This project analyzes Disney+ content using **MySQL, Excel, and Power BI** to understand content distribution, categories, ratings, countries, release trends, content additions, and data-quality patterns.

The project follows an end-to-end data analysis workflow:

**Data Preparation → Data Validation → SQL Analysis → Data Modeling → Star Schema → Power BI Visualization → Business Insights**

The objective is to demonstrate practical skills in **Business Analysis, SQL, data cleaning, data modeling, data visualization, and analytical storytelling**.

---

## Business Objective

The analysis focuses on answering the following business questions:

* How many Movies and TV Shows are available?
* How has the Disney+ catalog changed over time?
* Which years had the highest number of content additions?
* Which content ratings are most common?
* Which categories appear most frequently?
* Which countries contribute the most titles?

---

# Dataset

The dataset contains information about Disney+ titles and their associated metadata.

### Dataset Details

* **Original Records:** 16,524
* **Columns:** 12
* **Content Types:** Movies and TV Shows

### Dataset Columns

| Column         | Description                              |
| -------------- | ---------------------------------------- |
| `show_id`      | Unique identifier for each title         |
| `type`         | Content type — Movie or TV Show          |
| `title`        | Title of the content                     |
| `director`     | Director of the title                    |
| `cast`         | Cast members associated with the title   |
| `country`      | Country associated with the title        |
| `date_added`   | Date the title was added to the platform |
| `release_year` | Original release year                    |
| `rating`       | Content rating                           |
| `duration`     | Duration of the title                    |
| `listed_in`    | Categories associated with the title     |
| `description`  | Description of the title                 |

---

# Data Cleaning & Preparation

The dataset was inspected and prepared before performing SQL and Power BI analysis.

### Data Cleaning Steps

* Checked for missing values.
* Checked for duplicate `show_id` values.
* Validated content types.
* Standardized selected missing values.
* Prepared category information for analysis.
* Validated date fields.
* Created a `primary_list` field for category analysis.
* Checked the dataset for potential data-quality issues.

### Missing Value Handling

Missing values were handled during data preparation.

* Missing director values were represented as **`missing directors`**.
* Missing country values were represented as **`United States`** for this project.
* Missing `date_added` values were retained where the original dataset did not contain a date.

### Category Preparation

The original `listed_in` field can contain multiple categories in a single record.

For category-level analysis, a `primary_list` field was created using the first category before the first comma.

This provided a consistent category field for aggregation and visualization.

---

# Data Validation

The cleaned dataset was validated before analysis.

| Validation Check           | Result |
| -------------------------- | -----: |
| Missing `show_id`          |      0 |
| Missing `type`             |      0 |
| Missing `title`            |      0 |
| Missing `director`         |      0 |
| Missing `cast`             |      0 |
| Duplicate `show_id` values |      0 |

After validation, the dataset was imported into MySQL and Power BI.

---

# MySQL Database

The dataset was imported into a MySQL database named:

```text
disney_plus
```

The primary analysis table was:

```text
disney_titles
```

SQL was used for:

* Data validation
* Exploratory analysis
* Aggregation
* Trend analysis
* Data-quality investigation
* Category analysis
* Content-type analysis
* Ranking
* Percentage calculations

---

# SQL Analysis

The SQL analysis contains **8 business-oriented queries**.

The queries were designed to translate business questions into measurable data analysis.

## Business Questions Covered

|  # | Business Question                                    | SQL Concepts                    |
| -: | ---------------------------------------------------- | ------------------------------- |
|  1 | What is the available date range?                    | `MIN()`, `MAX()`                |
|  2 | How many titles were added each year?                | `YEAR()`, `COUNT()`, `GROUP BY` |
|  3 | Which years had the highest additions?               | `ORDER BY`, aggregation         |
|  4 | How many Movies and TV Shows are available?          | `GROUP BY`, `COUNT()`           |
|  5 | What are the most common ratings?                    | `GROUP BY`, `COUNT()`           |
|  6 | How many titles were released each year?             | `GROUP BY`                      |
|  7 | How do Movies and TV Shows vary by release year?     | Multiple grouping               |
| 8  | How many titles involve the United States?           | `LIKE`                          |

SQL Used for checking/exploring the data.
---

#  Key SQL Findings

### Content Type

The cleaned analysis contains:

* **1,052 Movies**
* **398 TV Shows**

### Content Ratings

Selected rating counts include:

| Rating | Titles |
| ------ | -----: |
| TV-G   |    318 |
| TV-PG  |    304 |
| G      |    253 |
| PG     |    236 |
| TV-Y7  |    131 |

### Top Categories

Selected category counts include:

| Category         | Titles |
| ---------------- | -----: |
| Action-Adventure |    452 |
| Animation        |    320 |
| Comedy           |    193 |
| Animals & Nature |    173 |

### Country

The United States represents the largest country grouping in the cleaned analysis, with:

**1,224 titles**

---

## Missing Date Values

Some titles do not contain a `date_added` value.

Examples identified during the analysis include:

* Disney Kirby Buckets
* Disney Mech-X4
* Imagination Movers

These missing values were retained rather than assigning invented dates.

This demonstrates the importance of identifying and documenting data-quality limitations before interpreting trends.

---

# Category Analysis

The `primary_list` field was used to analyze category distribution.

The analysis identified several frequently occurring categories, including:

* Action-Adventure
* Animation
* Comedy
* Animals & Nature

The category analysis was later visualized in Power BI using charts and a treemap.

---

# Content Addition Analysis

The `date_added` field was used to analyze catalog additions over time.

The SQL analysis included:

* Titles added by year
* Highest-addition years
* Movie additions by year
* TV Show additions by year
* Total additions by year
* Date concentration
* Missing date investigation

The year **2012** contained **763 titles associated with the `date_added` field** in the analysis.

---

# ⭐ Data Modeling

A dimensional data model was created in Power BI to support analysis and visualization.

The model contains:

### Fact Table

```text
Fact_Content
```

### Dimension Tables

```text
Dim_Date
Dim_Category
Dim_Rating
Dim_Type
```

The original content table was also retained:

```text
disney_plus_titles
```

The dimensional model was created to make filtering, aggregation, and analysis easier in Power BI.

---

# ⭐ Star Schema

The project uses a star-schema-style data model.

```text
                    ┌──────────────┐
                    │   Dim_Date   │
                    └──────┬───────┘
                           │
                           │
┌──────────────┐     ┌────▼───────┐     ┌────────────────┐
│   Dim_Type   │────►│Fact_Content│◄────│  Dim_Category  │
└──────────────┘     └────┬───────┘     └────────────────┘
                           │
                           │
                    ┌──────▼───────┐
                    │  Dim_Rating  │
                    └──────────────┘
```

The dimensions provide descriptive attributes used to filter and analyze the content data.

---

# Power BI Dashboard

The cleaned and modeled dataset was analyzed using Microsoft Power BI.

The dashboard contains:

### KPI Cards

* Total Titles
* Total Movies
* Total TV Shows

### Visualizations

* Disney+ Titles Added by Year
* Movie vs TV Show Distribution
* Content Category Analysis
* Rating Distribution
* Country Analysis
* Category Treemap
* Interactive slicers

---

# Interactive Analysis

Power BI slicers were used to allow users to interact with the dashboard.

The dashboard can be filtered using dimensions such as:

* Content Type
* Rating
* Category
* Date

This allows users to explore different sections of the Disney+ catalog interactively.

---

# Power BI Visualizations

## Titles Added by Year

This visualization shows the distribution of titles added to the catalog over time.

It helps identify changes and concentrations in content additions.

## Content Type Distribution

This visualization compares Movies and TV Shows within the catalog.

## Category Analysis

Category visualizations show the distribution of titles across primary content categories.

## Rating Distribution

Rating analysis shows the composition of the catalog by content rating.

## Country Analysis

Country analysis provides a view of the geographic distribution of titles.

## Category Treemap

The treemap provides a hierarchical visual representation of category size.

---

# Business Analysis Perspective

This project demonstrates an end-to-end approach to turning raw data into structured business information.

The workflow was:

```text
Business Questions
        ↓
Data Preparation
        ↓
Data Validation
        ↓
SQL Analysis
        ↓
Data Modeling
        ↓
Star Schema
        ↓
Power BI Visualization
        ↓
Insights
        ↓
Business Storytelling
```

The project focuses on more than dashboard creation.

It demonstrates the process of:

* Understanding the dataset
* Identifying business questions
* Validating data
* Cleaning and transforming data
* Structuring data for analysis
* Performing SQL analysis
* Building a dimensional model
* Creating visualizations
* Communicating analytical findings

---

# Tools & Technologies

| Tool                | Purpose                                   |
| ------------------- | ----------------------------------------- |
| **MySQL**           | Database and SQL analysis                 |
| **Microsoft Excel** | Data inspection and preparation           |
| **Power BI**        | Data modeling and visualization           |
| **GitHub**          | Version control and project documentation |
| **Markdown**        | Project documentation                     |

---

# Skills Demonstrated

## Business Analysis

* Business question formulation
* Data interpretation
* Data validation
* Analytical thinking
* Insight generation
* Documentation
* Business storytelling

## SQL

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `COUNT()`
* `MIN()`
* `MAX()`
* `SUM()`
* `CASE WHEN`
* `LIKE`
* `IS NULL`
* `REPLACE()`
* `CAST()`
* Common Table Expressions
* Window Functions
* `RANK()`
* Subqueries
* Conditional Aggregation

## Power BI

* Data import
* Data transformation
* Data modeling
* Relationships
* Star schema
* KPI cards
* Charts
* Treemaps
* Slicers
* Interactive dashboards

---

# 📸 SQL Analysis

The SQL analysis contains the complete set of business-oriented queries used during the project.

---

# Project Outcome

The final project provides an end-to-end example of analyzing a content dataset using SQL, data modeling, and Power BI.

The project demonstrates the complete workflow from:

**Raw Data → Cleaning → Validation → SQL → Data Modeling → Star Schema → Power BI → Business Insights**

It combines technical data-analysis skills with a Business Analyst approach to problem definition, data validation, analysis, and communication.

---

# Author

## Mansi Mood

**Aspiring Business Analyst | SQL | Power BI | Excel | Data Analytics**

### Portfolio

- [Framer Portfolio](https://mansimoodportfolio.framer.website)
- [Behance](https://www.behance.net/mansimood000)
- [Dribbble](https://dribbble.com/Mansii_00)
- [LinkedIn](https://www.linkedin.com/in/mansi-mood)
---

# Disclaimer

This project is created for educational and portfolio purposes.

The analysis reflects the data available in the dataset used for the project. Missing, incomplete, or unusual source data was documented and handled during the data preparation and analysis process.
