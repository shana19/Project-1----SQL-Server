# Project-1----SQL-Server

# 📊 Walmart Customer Purchase Behavior Analysis

## 📝 Project Overview  
This project analyzes **customer purchase data from Walmart** to understand **buying trends, sales patterns**, and **product category performance**. The goal is to explore the data using **Python (Pandas, Matplotlib, Seaborn)** and gain insights that can help businesses **optimize sales and customer targeting**.

---

## 📂 Files Used  
- **walmart_purchases.csv** → Main dataset with customer purchase records.  
- **categories.csv** → Contains product category names linked by `CategoryID`.

---

## 🧰 Tools and Libraries  
- `pandas` → Data loading and manipulation  
- `matplotlib.pyplot`, `seaborn` → Data visualization  
- `datetime` → Handling date formats and extracting months/days  

---

## 🔍 Key Steps in the Analysis  
1. **Data Cleaning**  
   - Handled missing values  
   - Converted date columns to proper datetime format  
   - Merged product categories into main dataset  

2. **Exploratory Data Analysis (EDA)**  
   - Purchase frequency by category  
   - Sales trends over time  
   - Average purchase amount per customer  
   - Sales during the **Christmas period**  
   - Correlation between age, spending, and ratings  

3. **Visualizations**  
   - Bar charts, line plots, density plots (KDE), correlation heatmap  

---

## 📌 Main Insights  
- **Electronics** is the top-selling and most profitable category.  
- Sales **peak before Christmas**, especially on **December 25th**.  
- Most customers spend moderately, but **a small group of high spenders** has a big impact.  
- No strong correlation between **age, spending, and product ratings**.  

---

## 🚀 How to Run the Project  
1. Open the Jupyter Notebook.  
2. Run the cells step by step.  
3. Make sure the CSV files are in the same folder.  
4. Install missing libraries with:  
```bash
pip install pandas matplotlib seaborn
