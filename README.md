# CA675_Cloud_Assignment 

Email Classification and Analysis
This repository contains scripts and queries to analyze email data, classify emails as spam or ham, and extract valuable information from the dataset.

Overview
This project focuses on classifying emails as spam or ham and extracting meaningful insights from the dataset. It includes steps for data loading, spam word classification, email classification, and analysis of top emails. Additionally, term frequency (TF) and TF-IDF calculations are performed to identify key terms in spam emails.

Prerequisites:

Hive installed and configured
Access to an S3 bucket for storing data (update the LOCATION in the SQL scripts)
Update the S3 bucket location in the SQL scripts.
Data Loading

Execute the SQL script load_data.sql to create an external table and load email data from a CSV file.

Check the record count of the loaded data:

View the top 10 classified emails:

Top Email Analysis

Analyze the top 10 spam emails:

Term Frequency and TF-IDF
