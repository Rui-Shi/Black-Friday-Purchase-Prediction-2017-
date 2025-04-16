# Black Friday Purchase Prediction Project

## Project Statement

A retail company, "ABC Private Limited," aims to understand customer purchase behavior, specifically the purchase amount for various products across different categories during Black Friday. They provided a dataset containing purchase summaries for selected high-volume products from the previous month, along with customer demographics and product details.

The primary goal is to build a predictive model to estimate the purchase amount for customers against various products. This model will help the company create personalized offers for customers based on predicted spending behavior.

## Data Description

The dataset includes the following variables:

* **User_ID:** Unique identifier for the customer.
* **Product_ID:** Unique identifier for the product.
* **Gender:** Sex of the user.
* **Age:** Age group of the user (provided in bins).
* **Occupation:** Occupation code for the user (masked).
* **City_Category:** Category of the city the user resides in (A, B, C).
* **Stay_In_Current_City_Years:** Number of years the user has stayed in the current city.
* **Marital_Status:** Marital status of the user (0 or 1).
* **Product_Category_1:** Primary product category (masked).
* **Product_Category_2:** Secondary product category (masked, a product might belong to multiple categories).
* **Product_Category_3:** Tertiary product category (masked, a product might belong to multiple categories).
* **Purchase:** The target variable representing the purchase amount.

*(Note: For computational reasons in the provided analysis, only the first 10,000 observations were used)*

## Methodology and Techniques

The analysis focuses on building a linear regression model to predict the 'Purchase' amount. Since the dataset contains many discrete categorical predictors, significant data preprocessing and model optimization steps were undertaken.

### 1. Data Preprocessing

* **Handling Missing Values:** Missing values (NA) in the dataset were replaced with zero.
* **Dummy Variables:** Categorical variables needed to be converted into a numerical format suitable for linear regression. Dummy (indicator) variables (0 or 1) were created for:
    * **Gender:** 'F' mapped to 1, 'M' to 0.
    * **City_Category:** Represented by two dummy variables ('City\_CategoryA', 'City\_CategoryB') to avoid multicollinearity. City A = (1, 0), City B = (0, 1), City C = (0, 0).
    * **Occupation:** 20 dummy variables were created for the 21 occupation codes (one category is represented by all zeros).
    * **Product_Category_1:** 17 dummy variables for 18 categories.
    * **Product_Category_2:** 18 dummy variables for 19 categories (including 0 for missing/no category).
    * **Product_Category_3:** 18 dummy variables for 19 categories (including 0 for missing/no category).
* **Scoring:** Ordinal categorical variables were converted into numerical scores:
    * **Age:** Mapped to scores 1-7 based on age intervals (youngest to oldest).
    * **Stay_In_Current_City_Years:** '4+' mapped to 4, then converted to numeric.

### 2. Model Fitting and Diagnostics (Initial)

* An initial linear regression model was fitted using all processed predictor variables against the 'Purchase' amount.
* Diagnostic plots (Standardized Residuals vs. Fitted Values, Normal Q-Q Plot) revealed violations of mean structure (heteroscedasticity, potentially σ² ∝ [E(Y)]²) and normality assumptions.

### 3. Transformation of Target Variable (Y)

To address the diagnostic issues, transformations on the 'Purchase' variable (Y) were explored:
* **Log Transformation:** `log(Purchase)` was used as the target variable. New diagnostic plots (Fig 3 & 4) showed improvement, particularly in addressing the mean structure violation.
* **Box-Cox Transformation:** The Box-Cox method was used to find the optimal lambda (λ ≈ 0.465) for power transformation (Fig 5). Diagnostic plots for this transformation (Fig 6 & 7) were also generated. The log transformation was ultimately considered better.

### 4. Model Selection

Using the log-transformed 'Purchase' (`ylog`) as the target, several stepwise variable selection methods based on the Akaike Information Criterion (AIC) were applied to the full model:
* Stepwise Forward Selection
* Stepwise Backward Selection
* Hybrid Stepwise Selection (Both Directions)
* Manual Backward Elimination (based on p-values > 0.05)

The adjusted R-squared (Adj. R²) and K-Fold Cross-Validation (K=5) prediction error (delta[1]) were compared for the resulting models. The model derived from **Stepwise Forward Selection** yielded the highest Adj. R² (0.6475) and the lowest cross-validation error (0.6800), making it the preferred model at this stage.

### 5. Model Diagnostics (Selected Model)

* **Multicollinearity:** Checked using Variance Inflation Factors (VIF) on the predictors selected by the forward stepwise method. Serious multicollinearity was detected (average VIF ≈ 5, max VIF ≈ 48.7).
* **Influential Observations:** Cook's distance was checked; no influential points (Cook's D > 1) were found.

### 6. Principal Component Analysis (PCA) Regression

To address the severe multicollinearity, PCA Regression was performed:
* **Standardization:** Predictor variables (X) were standardized before PCA. Formula: `Xj* = (Xj - μj) / sqrt(σjj)`.
* **PCA:** Principal components were calculated. A scree plot (Fig 8) was generated to visualize variance explained by components.
* **Regression on PCs:** A new regression model was fitted using the original 'Purchase' amount (Y) against the first 57 principal components (explaining ~90% of the variance).
* **Diagnostics (PCA Model):** Residual plots for this PCA model (Fig 9) indicated that the log transformation on Y (`ylog`) was still necessary.
* **Final Model Selection (PCA):** Stepwise backward selection (using AIC) was applied to the model regressing `ylog` on the first 57 principal components to obtain the final PCA regression model. The final model included 51 principal components.

## Code Overview

The analysis was performed using R. Key steps in the provided code (`project.R` output):

1.  **Load Libraries:** `readr`, `MASS`, `boot`.
2.  **Load Data:** Reads `train.csv`.
3.  **Preprocessing:** Handles NAs, selects the first 10,000 rows, creates dummy variables and score variables as described above.
4.  **Initial Model:** Fits `lm(y ~ xx)` and generates summary and diagnostic plots.
5.  **Log Transformation:** Calculates `ylog=log(y)`, fits `lm(ylog ~ .)` and generates diagnostic plots.
6.  **Box-Cox:** Performs Box-Cox transformation and generates diagnostic plots.
7.  **Model Selection:** Implements various stepwise selection methods (`step` function with different directions) and compares models using Adj. R² and `cv.glm` for K-Fold CV.
8.  **Multicollinearity & Influence Check:** Calculates VIF (`diag(solve(cor(xx)))`) and checks Cook's distance.
9.  **PCA Regression:** Standardizes data, performs PCA (`princomp`), generates scree plot, fits models on principal components (`lm(y ~ xxdatap)` and `lm(ylog ~ xxdatap)`), performs backward selection on the PCA model.

## Summary

This project demonstrates fitting a linear regression model to a dataset with primarily discrete predictors. Key techniques involved extensive data preprocessing using dummy variables and scoring, addressing model assumption violations through log transformation, employing stepwise methods (AIC) and K-Fold CV for model selection, and finally using PCA regression to mitigate multicollinearity. The stepwise forward selection model on the log-transformed data initially performed best based on Adj. R² and CV error, but PCA regression was applied to address multicollinearity issues.
