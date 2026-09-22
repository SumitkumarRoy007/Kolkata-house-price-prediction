# 🏠 Kolkata House Price Prediction - 1 Lakh+ Records | SQL + Power BI + ML

![Dashboard](Dashboard.png)

### 📌 Problem Statement
Predict Kolkata flat prices based on Area, BHK, and Locality. Built for Data Analyst Portfolio.

### 📊 Dataset Info
- **Rows:** 102,345 (1 Lakh+)
- **Source:** 99acres Kolkata data
- **Features:** Area (sqft), BHK, Locality (Ballygunge, Salt Lake, New Town, Howrah, etc), Price

### 🔍 What I Did?
For 1 lakh rows, I focused on efficient code:
- Used **vectorized Pandas** (no for-loops) - handles 1L rows in <2 sec
- One-Hot Encoding for Locality
- **Model:** Linear Regression
- **Result:** R2 = 0.73, MAE = 13.7 lakhs (₹13,72,885)

### 🛠️ Tech Stack
`Python` `Pandas` `Scikit-Learn` `MySQL` `Power BI`

### 📁 Project Structure
1. `/data` - cleaned CSV (1 lakh rows) - `sample_data_1000_.csv`
2. `/sql` - MySQL analysis (AVG price by locality, BHK analysis) - `Project_queries.sql`
3. `/python` - Python model (R2 = 0.73)
4. `/dashboard` - Power BI dashboard - `Dashboard.png`

### 📈 Result Screenshot
<img width="663" height="489" alt="Actual vs Predicted values" src="https://github.com/user-attachments/assets/b3aeb765-2a9f-4ee3-9369-89c7400b199e" />

### 📈 Model Performance
- **R2 Score:** 0.73
- **MAE:** 6.8 Lakhs

![Result Table] <img width="421" height="471" alt="Rsult_table" src="https://github.com/user-attachments/assets/1c2d1c60-4b8f-4a8d-bebd-dcc69155edef" />

### 💼 Key Business Insights (SQL + Dashboard)
- Top Locality: Ballygunge = 39Bn revenue
- Total Sold: 344Bn | Pipeline: 465Bn
- Sales Funnel: 42.66% Sold
- Avg days to sell: 59.41 days

## 👤 Author
**SumitkumarRoy007** | Data Analyst | Kolkata
Open to Data Analyst / BI Analyst Roles
