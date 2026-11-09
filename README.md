# Superstore Profitability Analysis

## 1. Project Overview

This project explores the Sample Superstore dataset to evaluate business performance, identify profitability issues, and develop data-driven recommendations.

The analysis focuses on sales performance, product profitability, discount strategies, customer segments, and regional performance.

## 2. Business Objectives

- Evaluate overall sales and profitability.
- Identify the most and least profitable product categories and sub-categories.
- Investigate the relationship between discounts and profit.
- Compare profitability across customer segments and geographic regions.
- Simulate the potential impact of revised discount policies on Furniture profitability.

## 3. Tools & Technologies

- **PostgreSQL** – Data cleaning, querying, and analysis.
- **Python** – Exploratory data analysis and visualization.
- **pandas** – Data manipulation and aggregation.
- **NumPy** – Numerical operations and discount scenario calculations.
- **Matplotlib** – Data visualization.
- **Git & GitHub** – Version control and project documentation.

## 4. Analysis & Methodology

The project includes:

1. Data cleaning and duplicate removal.
2. Sales and profitability analysis by category and sub-category.
3. Customer segment analysis.
4. Regional and state-level performance analysis.
5. Discount analysis, particularly for Furniture.
6. Correlation analysis between discount, sales, quantity, and profit.
7. A 2017 Furniture discount-cap simulation.

## 5. Key Findings

- Technology generated the highest total profit among the three main product categories.
- Furniture showed significant profitability challenges, particularly in the Tables and Bookcases sub-categories.
- Higher discount levels were associated with lower Furniture profitability.
- The correlation between discount and profit for Furniture was approximately -0.48, indicating a moderate negative relationship. This does not establish causation.
- California was among the strongest states in terms of sales and profit, while Texas recorded high sales but negative overall profit.

## 6. Discount Strategy Simulation

A hypothetical discount-cap scenario was developed for Furniture transactions in 2017.

Proposed discount caps:

| Sub-category | Proposed maximum discount |
|---|---:|
| Tables | 10% |
| Bookcases | 10% |
| Chairs | 20% |
| Furnishings | 20% |

The simulation estimated an increase in profit from approximately $3,018 to $30,083.

**Important limitation:** This is a scenario-based estimate, not a guaranteed business outcome. It assumes constant sales volume and costs and does not account for customer demand elasticity or changes in purchasing behavior.

## 7. Visualizations

The `charts/` folder contains visualizations covering:

- Sales and profit by category.
- Sales and profit by customer segment.
- State-level sales and profitability.
- Furniture sub-category profitability.
- Furniture discount-group analysis.
- Discount and profit correlation.
- Actual versus simulated Furniture profit.

## 8. Project Structure

```text
superstore-profitability-analysis/
│
├── charts/
│   ├── furniture_correlation.png
│   ├── furniture_discount_group.png
│   ├── profit_by_category.png
│   ├── profit_by_segment.png
│   ├── profit_by_state.png
│   └── ...
│
├── superstore_analysis.py
├── .gitignore
└── README.md
```

## 9. Dataset

The project uses the Sample Superstore dataset.

The raw dataset is excluded from this repository. Users should obtain the dataset separately and place it in the project directory before running the Python analysis.

## 10. Conclusion

This analysis demonstrates how SQL and Python can be combined to investigate business performance, identify profitability challenges, and evaluate potential pricing strategies.

The findings highlight the importance of balancing sales growth with sustainable profitability.