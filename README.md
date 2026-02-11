This project performs Exploratory Data Analysis (EDA) on the Netflix Movies and TV Shows dataset using Python.

The objective is to analyze content trends, country contributions, genre popularity, ratings distribution, and duration patterns to generate meaningful business insights.

🛠 Tools & Technologies

Python

Pandas

Matplotlib

Seaborn

Jupyter Notebook

🧹 Data Cleaning & Preparation

Converted date_added to datetime format

Extracted year from date column

Removed missing values from key columns (rating, country, date_added)

Filled missing values in director and cast columns

Extracted numeric duration from text column

Split and exploded multi-value columns (country, genres)

📊 Analysis Performed
✔ Content Distribution

Movies vs TV Shows count

Percentage comparison

✔ Country Analysis

Top 8 content-producing countries

Countries with more TV Shows than Movies

Country vs Type heatmap

✔ Trend Analysis

Titles released per year

Movies vs TV Shows trend over time

Stacked area visualization

✔ Genre Analysis

Most popular genres

Top 10 genres

Multi-genre content analysis

India vs United States genre comparison

✔ Duration & Ratings

Average movie duration

Duration distribution (Histogram)

Duration by rating (Box plot)

Most common content ratings

📈 Key Insights

Movies dominate the platform, but TV Shows are increasing over time.

The United States and India produce the most content.

Drama and International genres are highly popular.

Most movies range between 80–120 minutes.

Some countries focus more on TV Shows than Movies.
