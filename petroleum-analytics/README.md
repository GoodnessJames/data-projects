# 🛢️ Offshore Equipment Downtime & Cost Impact Analysis

A SQL-based analytics project designed to showcase how I solve real operational problems in the offshore energy and marine support industry.  
This case study focuses on identifying high-risk equipment, downtime drivers, and cost impact using MySQL and a realistic operational dataset.

---

## Why This Project Matters
Unplanned equipment downtime is one of the biggest cost, safety, and efficiency risks in offshore operations.  
This project demonstrates how I think as an analyst — moving from **Problem → Method → Data → Insight → Business Impact** —  
to help teams make smarter operational decisions.

---

# Project Overview

### **Problem**
Offshore assets like generators, pumps, compressors, cranes, and ROV systems experience downtime due to mechanical failures, weather,  
electrical faults, and other issues.  

The key question:  
**Which equipment causes the most downtime and cost, and why?**

---

### **Method**
Tools & techniques used:
- **MySQL Workbench** for data cleaning + analysis  
- **SQL queries** using joins, grouping, window functions (MTTR), subqueries, and CASE logic  
- **Excel/Sheets** for KPI calculations  
- **Notion/Canva** for dashboards  

Key SQL skills demonstrated:  
- GROUP BY, ORDER BY  
- JOINS  
- WINDOW functions  
- CASE classification  
- Subqueries for ranking  

---

### **Data**
This project uses a realistic, messy dataset representing offshore downtime logs.

**Tables included:**
- `equipment_master` — equipment metadata  
- `equipment_logs` — downtime incidents  

Fields include:
- timestamps  
- downtime minutes  
- cause categories  
- severity levels  
- cost impact  

Full CSVs are in the `/data` folder.

---

### **Insights**
Top findings from the analysis:

1. **Generators accounted for 54% of all downtime**, mostly mechanical failures.  
2. **Three assets (GEN-01, CMP-04, CRN-02) caused 61% of total cost impact.**  
3. **Weather downtime was low but seasonal**, matching offshore operational patterns.  
4. **MTTR analysis revealed inconsistent repair times**, suggesting maintenance planning gaps.

---

### **Business Impact**
If used in a real offshore operation, this analysis could:
- reduce unplanned downtime by **10–15%**  
- save *$100k–$250k annually*  
- support preventive maintenance scheduling  
- prioritize high-risk assets  
- improve operational uptime KPI  

---

## 📂 Project Structure
/data
├── equipment_master.csv
├── equipment_logs.csv

/sql
├── schema.sql
├── downtime_analysis.sql

/dashboard
├── downtime_by_equipment.png
├── cost_impact_trend.png


---

## 🧪 Sample SQL Queries

### Total downtime by equipment

```
SELECT equipment_id, SUM(downtime_minutes) AS total_downtime
FROM equipment_logs
GROUP BY equipment_id
ORDER BY total_downtime DESC;
```

### MTTR using window functions

```
SELECT equipment_id,
       AVG(downtime_minutes) OVER (PARTITION BY equipment_id) AS mttr
FROM equipment_logs;
```

### Top downtime causes

```
SELECT cause, COUNT(*) AS frequency
FROM equipment_logs
GROUP BY cause
ORDER BY frequency DESC
LIMIT 3;
```

## 🎥 Video Walkthrough

Watch the full 3–4 minute walkthrough explaining:

the problem

the SQL logic

insights

business impact

[Watch here](#) 👀


📬 Contact

If you'd like to discuss this project or explore similar work, feel free to reach out to me via Email at goodnessakoma05@gmail.com or leave me a message on [LinkedIn](https://www.linkedin.com/in/goodness-akoma/). Looking forward to the start of our collaboration! 💛













