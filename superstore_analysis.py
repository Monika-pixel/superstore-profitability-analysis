
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Load the existing Superstore dataset
DATA_PATH = Path("/Users/macbookair/Desktop/SQL/Superstore/Sample - Superstore.csv")

df = pd.read_csv(DATA_PATH, sep=";")

print("Dataset loaded successfully!")
print("Rows:", len(df))
print("Columns:", len(df.columns))
print("\nColumn names:")
print(df.columns.tolist())
print("\nFirst 5 rows:")
print(df.head())

profit_by_category = df.groupby("Category")["Profit"].sum()
print(profit_by_category)
fig, ax = plt.subplots()
colors = ["#FFCB3D", "#5D9253", "#F1A344"]
profit_by_category.plot(kind="bar", ax=ax, color=colors)
ax.set_title("Total Profit by Product Category")
ax.set_xlabel("Product Category")
ax.set_ylabel("Total Profit ($)")
ax.tick_params(axis="x", rotation=0)
fig.tight_layout()
fig.savefig("charts/profit_by_category.png", dpi=300, bbox_inches="tight")
plt.show()

## Profit by state

profit_by_state = df.groupby("State")["Profit"].sum().sort_values(ascending=False)
print(profit_by_state)
fig, ax = plt.subplots()
colors = ["#7F9D68","#557945","#A8BE96"]
profit_by_state.plot(kind="barh", ax=ax, color=colors)
ax.set_title("Total Profit by State")
ax.set_xlabel("State")
ax.set_ylabel("Total Profit ($)")
ax.tick_params(axis="x", rotation=0)
fig.tight_layout()
fig.savefig("charts/profit_by_state.png", dpi=300, bbox_inches="tight")
plt.show()

top10_state_by_profit = df.groupby("State")["Profit"].sum().sort_values(ascending=False).head(10)
print(top10_state_by_profit)
fig, ax = plt.subplots()
colors = ["#7F9D68","#557945","#A8BE96"]
top10_state_by_profit.plot(kind="barh", ax=ax, color=colors)
ax.set_title("Total Profit by State")
ax.set_xlabel("State")
ax.set_ylabel("Total Profit ($)")
ax.tick_params(axis="x", rotation=0)
fig.tight_layout()
fig.savefig("charts/top_10_profit_by_state.png", dpi=300, bbox_inches="tight")
plt.show()

lowest_state_by_profit = df.groupby("State")["Profit"].sum().sort_values(ascending=True).head(10)
print(lowest_state_by_profit)
fig, ax = plt.subplots()
colors = ["#F1A344","#FFCB3D","#D99A32"]
lowest_state_by_profit.plot(kind="barh", ax=ax, color=colors)
ax.set_title("Lowest Profit by State")
ax.set_xlabel("State")
ax.set_ylabel("Total Profit ($)")
ax.tick_params(axis="x", rotation=0)
fig.tight_layout()
fig.savefig("charts/lowest_profit_by_state.png", dpi=300, bbox_inches="tight")
plt.show()


profit_by_segment = df.groupby(["Segment","Category"])["Profit"].sum().unstack()
print(profit_by_segment)
fig, ax = plt.subplots()
colors = ["#FFCB3D", "#5D9253", "#F1A344"]
profit_by_segment.plot(kind="bar", ax=ax, color=colors)
ax.set_title("Profit by Segment")
ax.set_xlabel("Segment")
ax.set_ylabel("Total Profit ($)")
ax.tick_params(axis="x", rotation=0)
fig.tight_layout()
fig.savefig("charts/profit_by_segment.png", dpi=300, bbox_inches="tight")
plt.show()

# SALES

sales_by_category = df.groupby("Category")["Sales"].sum()
print(sales_by_category)
fig, ax = plt.subplots()
colors = ["#FF933E", "#FFCB56", "#73A5CA"]
sales_by_category.plot(kind="bar", ax=ax, color=colors)
ax.set_title("Total Sales by Product Category")
ax.set_xlabel("Product Category")
ax.set_ylabel("Total Sales ($)")
ax.tick_params(axis="x", rotation=0)
fig.tight_layout()
fig.savefig("charts/sales_by_category.png", dpi=300, bbox_inches="tight")
plt.show()

top10_state_by_sales = df.groupby("State")["Sales"].sum().sort_values(ascending=False).head(10)
print(top10_state_by_sales)
fig, ax = plt.subplots()
colors = ["#FFCED8","#FFDDDD","#FFF4DE"]
top10_state_by_sales.plot(kind="barh", ax=ax, color=colors)
ax.set_title("Top 10 Sales by State")
ax.set_xlabel("State")
ax.set_ylabel("Total Sales ($)")
ax.tick_params(axis="x", rotation=0)
fig.tight_layout()
fig.savefig("charts/top_10_profit_by_state.png", dpi=300, bbox_inches="tight")
plt.show()

lowest_state_by_sales = df.groupby("State")["Sales"].sum().sort_values(ascending=True).head(10)
print(lowest_state_by_sales)
fig, ax = plt.subplots()
colors = ["#FFCED8","#FFDDDD","#FFF4DE"]
lowest_state_by_sales.plot(kind="barh", ax=ax, color=colors)
ax.set_title("Lowest Sales by State")
ax.set_xlabel("State")
ax.set_ylabel("Total Sales ($)")
ax.tick_params(axis="x", rotation=0)
fig.tight_layout()
fig.savefig("charts/lowest_sales_by_state.png", dpi=300, bbox_inches="tight")
plt.show()


sales_by_segment = df.groupby(["Segment","Category"])["Sales"].sum().unstack()
print(profit_by_segment)
fig, ax = plt.subplots()
colors = ["#FFCB3D", "#5D9253", "#F1A344"]
sales_by_segment.plot(kind="bar", ax=ax, color=colors)
ax.set_title("Sales by Segment")
ax.set_xlabel("Segment")
ax.set_ylabel("Total Sales($)")
ax.tick_params(axis="x", rotation=0)
fig.tight_layout()
fig.savefig("charts/sales_by_segment.png", dpi=300, bbox_inches="tight")
plt.show()

# the problem : why Furniture lossing money?

## Which subfurniture categories lose money?

furniture_df = df[df["Category"]=="Furniture"]

profit_by_subcategory_furniture = furniture_df.groupby ("Sub-Category")["Profit"].sum().sort_values(ascending=True)
print(profit_by_subcategory_furniture)
fig, ax = plt.subplots(figsize=(10, 6))
colors = ["#930031" if profit < 0 else "#BEDEFF" for profit in profit_by_subcategory_furniture]
profit_by_subcategory_furniture.plot(kind="barh", ax=ax, color=colors)
ax.axvline(x=0, color="black", linewidth=0.8)
ax.set_title("Furniture Profit")
ax.set_xlabel("Sub Category")
ax.set_ylabel("Total Profit($)")
ax.tick_params(axis="x", rotation=0)
fig.tight_layout()
fig.savefig("charts/profit_bu_subcat_furniture.png", dpi=300, bbox_inches="tight")
plt.show()

conditions = [furniture_df["Discount"]==0, furniture_df["Discount"]==0.20, furniture_df["Discount"]==0.40]
choices = ["0%","1-20%", "21-40%"]

furniture_df["Discount_Group"] = np.select(conditions,choices,default="Above 40%")
print(furniture_df[["Discount", "Discount_Group"]].head (10))

furniture_profit_discount = furniture_df.groupby(["Sub-Category","Discount_Group"])["Profit"].sum().unstack()

fig, ax = plt.subplots(figsize=(12, 7))
colors = ["#FFCB3D", "#5D9253", "#F1A344"]
furniture_profit_discount.plot(kind="bar", ax=ax, color=colors)
ax.axhline(y=0, color="black", linewidth=0.8)
ax.set_title("Furniture Discount Group")
ax.set_xlabel("Furniture Sub Categories")
ax.set_ylabel("Total Profit($)")
ax.tick_params(axis="x", rotation=0)
fig.tight_layout()
fig.savefig("charts/furniture_discount_group.png", dpi=300, bbox_inches="tight")
plt.show()

furniture_profit_margin = furniture_df.groupby(["Sub-Category","Discount_Group"])[["Profit","Sales"]].sum().unstack()
furniture_profit_margin2 = (
    furniture_profit_margin["Profit"]
    / furniture_profit_margin["Sales"]
    * 100
)                           
print(furniture_profit_margin2.round(2))      

fig, ax = plt.subplots(figsize=(10, 6))

im = ax.imshow(
    furniture_profit_margin2.to_numpy(),
    cmap="RdYlGn",
    aspect="auto"
)

plt.colorbar(im, ax=ax, label="Profit Margin (%)")

ax.set_title("Furniture Profit Margin by Subcategory and Discount Group")
ax.set_xlabel("Discount Group")
ax.set_ylabel("Subcategory")

ax.set_xticks(range(len(furniture_profit_margin2.columns)))
ax.set_xticklabels(furniture_profit_margin2.columns)

ax.set_yticks(range(len(furniture_profit_margin2.index)))
ax.set_yticklabels(furniture_profit_margin2.index)

for row in range(len(furniture_profit_margin2.index)):
    for col in range(len(furniture_profit_margin2.columns)):
        value = furniture_profit_margin2.iloc[row, col]

        if pd.notna(value):
            ax.text(
                col, row,
                f"{value:.1f}%",
                ha="center",
                va="center",
                color="black",
                fontsize=10
            )

fig.tight_layout()
plt.show()



furniture_correlation = furniture_df[
    ["Sales", "Quantity", "Discount", "Profit"]
].corr()

print(furniture_correlation)

fig, ax = plt.subplots(figsize=(9, 6))

im = ax.imshow(furniture_correlation, cmap="RdYlGn", vmin=-1, vmax=1)

ax.set_xticks(range(len(furniture_correlation.columns)))
ax.set_yticks(range(len(furniture_correlation.columns)))

ax.set_xticklabels(furniture_correlation.columns)
ax.set_yticklabels(furniture_correlation.columns)

for i in range(len(furniture_correlation.columns)):
    for j in range(len(furniture_correlation.columns)):
        ax.text(
            j, i,
            f"{furniture_correlation.iloc[i, j]:.2f}",
            ha="center",
            va="center"
        )

ax.set_title("Correlation Between Furniture Variables")
fig.colorbar(im, ax=ax, label="Correlation")

fig.tight_layout()
fig.savefig("charts/furniture_correlation.png", dpi=300, bbox_inches="tight")
plt.show()

furniture_df["Order Date"] = pd.to_datetime(furniture_df["Order Date"])
furniture_2017 = furniture_df[
    furniture_df["Order Date"].dt.year == 2017
].copy()
print(furniture_2017.shape)

discount_caps = {"Tables" : 0.10,
                 "Bookcases" : 0.10,
                 "Chairs" : 0.20,
                 "Furnishings" : 0.20}

furniture_2017["Proposed_Cap"] = furniture_2017["Sub-Category"].map(discount_caps)
print(furniture_2017[["Sub-Category", "Proposed_Cap"]].head())

furniture_2017["Capped_Discount"] = furniture_2017[
    ["Discount", "Proposed_Cap"]
].min(axis=1)

furniture_2017["Estimated_Sales"] = (
    furniture_2017["Sales"]
    / (1 - furniture_2017["Discount"])
    * (1 - furniture_2017["Capped_Discount"])
)

furniture_2017["Additional_Revenue"] = (furniture_2017["Estimated_Sales"]-furniture_2017["Sales"])
furniture_2017["Estimated_Profit"] = (furniture_2017["Profit"]+furniture_2017["Additional_Revenue"])
furniture_2017["Profit_Difference"] = (furniture_2017["Estimated_Profit"]-furniture_2017["Profit"])

print(furniture_2017[
    ["Sub-Category", "Discount", "Capped_Discount",
     "Sales", "Estimated_Sales", "Profit", "Estimated_Profit"]
].head(10))

print(furniture_2017[
    ["Sales", "Estimated_Sales", "Profit", "Estimated_Profit"]
].sum())

profit_comparison = furniture_2017.groupby("Sub-Category")[
    ["Profit", "Estimated_Profit", "Profit_Difference"]
].sum()
print(profit_comparison.round(2))

fig, ax = plt.subplots(figsize=(11, 6))
y = np.arange(len(profit_comparison))

ax.barh(
    y,
    profit_comparison["Profit_Difference"],
    left=profit_comparison["Profit"],
    color="#39966A",
    label="Additional Profit",
    height=0.55
)

ax.barh(
    y,
    profit_comparison["Profit"],
    color="#3985C9",
    label="Actual Profit",
    height=0.55
)

for i, value in enumerate(profit_comparison["Estimated_Profit"]):
    ax.text(
        value + 200,
        i,
        f"${value:,.2f}",
        va="center",
        fontsize=10
    )

ax.set_yticks(y)
ax.set_yticklabels(profit_comparison.index)
ax.invert_yaxis()
ax.set_title("Estimated Profit Under Proposed Furniture Discount")
ax.axvline(x=0, color="black", linewidth=0.8)
fig.tight_layout()
fig.savefig("charts/profit_comparison.png", dpi=300, bbox_inches="tight")
plt.show()