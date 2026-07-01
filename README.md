HR Analytics Dashboard | End-to-End Data Analytics Project
Project Overview

This project analyzes employee data from an HR dataset to identify factors influencing employee attrition, salary distribution, job satisfaction, overtime, and workforce performance. The project follows a complete data analytics workflow—from data preprocessing and exploratory analysis to SQL-based analytics, dimensional modeling, and interactive dashboard development in Power BI.

The objective is to demonstrate an end-to-end analytics solution that transforms raw HR data into actionable business insights for HR managers and decision-makers.

Business Objectives
Analyze employee attrition across different departments and job roles.
Identify factors affecting employee retention.
Understand salary distribution across experience levels and job roles.
Evaluate the impact of overtime, business travel, and satisfaction scores on attrition.
Build an interactive HR dashboard for business stakeholders.
 Tech Stack
Python
Pandas
NumPy
Matplotlib
SQL Server
Joins
Aggregations
CTEs
Window Functions
Star Schema Design
Power BI
Data Modeling
DAX Measures
Interactive Dashboard
KPI Cards
Slicers
Project Workflow
1. Data Cleaning & Feature Engineering (Python)
Imported HR dataset
Checked missing values and duplicates
Performed Exploratory Data Analysis (EDA)
Created new features including:
Salary Band
Experience Category
Identified business trends using statistical summaries and visualizations
2. SQL Analysis

Loaded the cleaned dataset into SQL Server and performed analytical queries including:

Employee Attrition Analysis
Salary Analysis by Job Role
Salary by Experience
Overtime vs Attrition
Business Travel vs Attrition
Gender-wise Salary Analysis
Relationship Satisfaction vs Attrition
Environment Satisfaction vs Attrition
Average Salary by Department
Employee Salary Ranking using Window Functions
Above/Below Average Salary Analysis
Common Table Expressions (CTEs) for reusable queries
3. Data Modeling

Designed a Star Schema by separating the dataset into fact and dimension tables.

Dimension Tables
DimEmployee
DimDepartment
DimEducation
DimJob
Fact Table
FactEmployee

This dimensional model improves data organization, simplifies reporting, and follows industry-standard data warehouse practices.

4. Power BI Dashboard

Built an interactive HR Analytics Dashboard featuring:

KPI Cards
Total Employees
Attrition Count
Attrition Rate
Average Salary
Average Experience
Average Salary Hike
Dashboard Visuals
Attrition by Department
Salary by Job Role
Salary by Experience
Overtime vs Attrition
Business Travel vs Attrition
Gender Distribution
Job Satisfaction Analysis
Environment Satisfaction Analysis
Relationship Satisfaction Analysis
Salary Distribution by Department
Interactive Features
Department Slicer
Job Role Slicer
Education Slicer
Gender Slicer
Cross-filtering between visuals
 Key Business Insights
Employees working overtime exhibit a higher attrition rate than those who do not.
Frequent business travel is associated with higher employee attrition.
Average salary increases consistently with employee experience.
Employees with low environment satisfaction have the highest attrition rate.
Relationship satisfaction has a relatively smaller impact on attrition compared to work environment satisfaction.
Salary hikes remain relatively consistent across employees regardless of the number of companies previously worked.
Job mobility contributes more to higher base salary than to higher salary hike percentages.
Skills Demonstrated
Data Cleaning
Exploratory Data Analysis (EDA)
Feature Engineering
SQL Query Optimization
Window Functions
Common Table Expressions (CTEs)
Star Schema Design
Data Modeling
DAX
Dashboard Design
Business Insight Generation
Data Visualization

 Outcome
Developed an end-to-end HR Analytics solution that transforms raw employee data into interactive business intelligence dashboards, enabling HR teams to monitor workforce trends, identify attrition drivers, and support data-driven decision-making.

📷 Dashboard Preview
