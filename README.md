
# Customer Churn Prediction & Retention Strategy for a Telecommunications Company

## Project Overview

This project provides an end-to-end data analysis and machine learning solution for a telecommunications company facing significant customer churn. The primary goal is to identify key drivers of churn, build a predictive model to identify at-risk customers, and propose actionable strategies to improve customer retention.

## Problem Statement

Customer churn (the rate at which customers stop doing business with an entity) is a critical challenge for telecommunications companies, leading to substantial revenue loss and increased customer acquisition costs. Our company is experiencing a churn rate of approximately **26.6%**, necessitating a data-driven approach to understand and mitigate this issue.

## Project Goals

* **Identify Churn Drivers:** Uncover the primary factors contributing to customer churn.
* **Predict Churners:** Develop a machine learning model to accurately predict which customers are likely to churn.
* **Provide Actionable Recommendations:** Translate analytical findings into concrete business strategies for customer retention.

## Dataset

The analysis is based on the **IBM Telco Customer Churn Dataset**, which contains information about a fictional telecommunications company's customers, including their services, account information, and whether they churned.

* **Source:** [You can add a link to the Kaggle dataset here if you downloaded it from there, e.g., `https://www.kaggle.com/datasets/blastchar/telco-customer-churn` ]
* **Size:** 7,043 customer records with 20 features.

## Tools and Technologies

* **Database:** MySQL (for simulating data acquisition and initial SQL exploration)
* **Programming Language:** Python
* **Python Libraries:**
    * `pandas`, `numpy` (for data manipulation and cleaning)
    * `matplotlib`, `seaborn` (for data visualization)
    * `scikit-learn` (for machine learning models: Logistic Regression, Decision Tree, Random Forest, Gradient Boosting)
    * `imbalanced-learn` (for handling imbalanced datasets with SMOTE)
* **Development Environment:** Google Colaboratory (Colab)
* **Version Control:** Git & GitHub

## Project Phases

This project followed a structured data analysis lifecycle:

1.  **Data Acquisition & Understanding (SQL Focus):**
    * Defined hypothetical database schema.
    * Used MySQL queries to simulate data extraction and perform initial data profiling (e.g., churn rate, distribution of key features).
    * **Key SQL Findings:** Identified initial correlations between `Contract` type, `InternetService`, and `SeniorCitizen` status with churn.
    
2.  **Data Cleaning & Preprocessing (Python Focus):**
    * Loaded the `Telco-Churn.csv` dataset into a Pandas DataFrame in Google Colab.
    * Handled the `TotalCharges` column: converted empty strings/spaces to `NaN` and then imputed with `0.0` (for new customers with 0 tenure) before converting to `float64`.
    * Encoded binary categorical features (e.g., `gender`, `Partner`, `Churn`) into numerical (0/1).
    * One-Hot Encoded multi-category nominal features (e.g., `InternetService`, `Contract`, `PaymentMethod`).
    * Dropped the `customerID` column as it's not a predictive feature.
    
3.  **Exploratory Data Analysis (EDA) & Visualization:**
    * Analyzed the distribution of churn and other key features.
    * Explored relationships between numerical features and churn (e.g., `tenure`, `MonthlyCharges`, `TotalCharges`).
    * Visualized churn rates across various categorical segments (e.g., contract types, internet service, payment methods, senior citizen status).
    * **Key EDA Insights:**
        * **High Churn Risk:** Month-to-month contracts, Fiber Optic internet, Electronic check payment, Senior Citizens, shorter tenure, paperless billing.
        * **Retention Factors:** Longer contracts, presence of `OnlineSecurity` and `TechSupport`, customers with partners/dependents.
    
4.  **Predictive Modeling:**
    * Split the cleaned data into training (80%) and testing (20%) sets, stratified to maintain churn ratio.
    * Scaled numerical features (`tenure`, `MonthlyCharges`, `TotalCharges`) using `StandardScaler`.
    * Addressed class imbalance using **SMOTE (Synthetic Minority Over-sampling Technique)** on the training data to ensure the model doesn't overlook churners.
    * Trained and evaluated four classification models: Logistic Regression, Decision Tree, Random Forest, and Gradient Boosting Classifier.
    * **Model Evaluation Focus:** Precision, Recall, F1-Score, and ROC AUC, as they are more informative for imbalanced classification than accuracy alone.
    * **Best Model:** **Gradient Boosting Classifier**
        * **Accuracy:** 0.7509
        * **Precision (Class 1 - Churn):** 0.5215
        * **Recall (Class 1 - Churn):** **0.7460** (meaning it correctly identified 74.6% of actual churners)
        * **F1-Score (Class 1 - Churn):** **0.6139**
        * **ROC AUC:** **0.8360** (excellent discriminative power)
    
5.  **Insights, Recommendations & Storytelling:**
    * Extracted **Feature Importances** from the best model to understand the most influential churn drivers.
    * Synthesized all findings into concrete, actionable business recommendations.
    * Prepared a structured outline for presenting findings to stakeholders.

## Key Findings & Feature Importances

The Gradient Boosting Model identified the following as the most important features for predicting churn, confirming the EDA insights:

| Feature                            | Importance | Insight                                                              |
| :--------------------------------- | :--------- | :------------------------------------------------------------------- |
| `tenure`                           | 0.224      | Shorter tenure is the strongest indicator of churn.                  |
| `Contract_Two year`                | 0.163      | Long-term contracts significantly reduce churn risk.                 |
| `PaymentMethod_Electronic check`   | 0.141      | Customers using this method are at higher risk.                      |
| `InternetService_Fiber optic`      | 0.114      | Fiber optic users show significantly higher churn.                   |
| `Contract_One year`                | 0.088      | One-year contracts also indicate lower churn risk.                   |
| `MonthlyCharges`                   | 0.052      | Higher monthly charges show a slight correlation with churn.         |
| `InternetService_No internet service` | 0.050      | Customers without internet service churn less.                       |
| `OnlineSecurity`                   | 0.041      | Presence of online security services reduces churn.                  |
| `TechSupport`                      | 0.027      | Having tech support is a retention factor.                           |
| `Dependents`                       | 0.021      | Customers with dependents tend to churn less.                        |

## Actionable Business Recommendations

Based on the analysis, the following strategic recommendations are proposed to mitigate customer churn:

1.  **Proactive Early Engagement:** Implement targeted outreach programs (e.g., welcome calls, loyalty incentives) for new customers, especially those on month-to-month contracts, during their first 3-6 months.
2.  **Incentivize Longer Contracts:** Offer discounts or bundled services to encourage customers to switch from month-to-month to one-year or two-year contracts.
3.  **Address Fiber Optic Service Issues:** Investigate and resolve potential pain points (e.g., reliability, customer support) specifically for Fiber Optic internet users, as they represent a high-churn segment.
4.  **Optimize Electronic Check Payment Experience:** Analyze the friction points associated with electronic check payments and promote migration to more stable payment methods (e.g., automatic bank transfer, credit card) with incentives.
5.  **Tailored Support for Senior Citizens:** Develop specific programs or simplified support channels catering to the needs of senior customers, given their higher churn rate.
6.  **Highlight Value-Added Services:** Proactively market and offer trials of retention-driving services like `OnlineSecurity` and `TechSupport` to at-risk or new customer segments.

## How to Run the Project

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/YourUsername/telco-churn-analysis.git](https://github.com/YourUsername/telco-churn-analysis.git)
    cd telco-churn-analysis
    ```
2.  **Open in Google Colab:**
    * Upload the `Telco_Churn_Analysis.ipynb` notebook to Google Colab.
    * Ensure the `Telco-Churn.csv` file is also uploaded to your Colab session or linked via Google Drive (as described in the notebook).
3.  **Run Cells Sequentially:** Execute the cells in the notebook sequentially to reproduce the analysis, cleaning, modeling, and insights.

## Contact

For any questions or collaborations, feel free to reach out:

* **Your Name:** Mayur More
* **Email:** mayuraikido@gmail.com

---
