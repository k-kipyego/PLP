# COVID-19 Global Data Tracker

## Project Description

This project involves building a data analysis and reporting Jupyter Notebook that tracks global COVID-19 trends. It focuses on analyzing cases, deaths, and vaccinations across selected countries (India, Kenya, and the United States) over time. The project includes cleaning and processing real-world data, performing exploratory data analysis (EDA), generating insights, and visualizing trends using Python data tools.

## Project Objectives

*   Import and clean global COVID-19 data from Our World in Data.
*   Analyze time trends for COVID-19 metrics (cases, deaths, vaccinations).
*   Compare these metrics across the selected countries/regions.
*   Visualize trends using charts (line plots, etc.).
*   Communicate findings and insights within a well-documented Jupyter Notebook.

## Tools and Libraries Used

*   **Python 3.x**
*   **Jupyter Notebook** (or VS Code with Jupyter Extension)
*   **Pandas:** For data loading, manipulation, and cleaning.
*   **Matplotlib & Seaborn:** For data visualization (creating charts and plots).
*   **(Potentially in future stages):** Plotly Express, Geopandas for maps.

## How to Run/View the Project

1.  **Prerequisites:**
    *   Ensure you have Python 3 installed.
    *   Install the necessary libraries:
        ```bash
        pip install pandas matplotlib seaborn notebook
        ```
2.  **Data:**
    *   The project uses the `owid-covid-data.csv` file from [Our World in Data](https://ourworldindata.org/coronavirus). This file should be present in the same directory as the Jupyter Notebook (`covid_data_analysis.ipynb`).
3.  **Running the Notebook:**
    *   Open the `covid_data_analysis.ipynb` file in Jupyter Notebook or an IDE with Jupyter support (like VS Code).
    *   Run the cells sequentially to see the data loading, cleaning, analysis, and visualizations.

## Initial Insights & Reflections (More in Notebook)

*   The scale of the pandemic in terms of total cases and deaths has been significantly different across the selected countries, with the United States and India showing much higher figures than Kenya.
*   Distinct waves of infection are visible in the data for the US and India, highlighting different phases of the pandemic.
*   An apparent data anomaly was noted in the most recent data points for India (around August 2024), suggesting a potential data quality issue for the latest entries that warrants caution.
*   Daily new case data tends to be noisy, and using smoothed averages (e.g., 7-day rolling average) can provide clearer trend insights.

(Further detailed insights, visualizations, and narrative explanations are available within the `covid_data_analysis.ipynb` notebook.) 