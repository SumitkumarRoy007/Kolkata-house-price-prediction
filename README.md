
# 🏠 Kolkata House Price Prediction - 1 Lakh+ Records

### 📌 Problem Statement
Predict Kolkata flat prices based on Area, BHK, and Locality. Built for Data Analyst Portfolio.

### 📊 Dataset Info
- *Rows:* 102,345 (1 lakh+)
- *Source:* 99acres Kolkata data
- *Features:* Area (sqft), BHK, Locality (Ballygunge, Salt Lake, New Town, Howrah, etc), Price

### ⚙️ What I Did?
For 1 lakh rows, I focused on efficient code:
- Used *vectorized Pandas* (no for-loops) - handles 1L rows in <2 sec
- One-Hot Encoding for Locality
- *Model:* Linear Regression
- *Result:* R2 = 0.73, MAE = 6.8 Lakhs
- Example: 1000 sqft, 2BHK, Howrah = 78.15 Lakhs

### 🛠️ Tech Stack
`Python` `Pandas` `Scikit-Learn` `MySQL` `Power BI`

### 🔜 Next Steps in this Repo
1.  `/data` - cleaned CSV (1 lakh rows)
2.  `/sql` - MySQL analysis (AVG price by locality)
3.  `/dashboard` - Power BI .pbix file

### 📈 Result Screenshot
<img width="663" height="489" alt="Actual vs Predicted values" src="https://github.com/user-attachments/assets/b3aeb765-2a9f-4ee3-9369-89c7400b199e" />


### 👤 Author
Sumit Kumar Roy | Aspiring Data Analyst | Kolkata
---
END

4. Click *Commit changes* -> *Commit directly*

Once done, send me screenshot. Next step: I will show you how to upload your Jupyter notebook and chart image in 1 click.
