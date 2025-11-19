/* =========================================================
   EQUIPMENT DOWNTIME & COST IMPACT ANALYSIS PROJECT
   Author: Goodness Akoma
   Database: offshore_analytics
   Description: This SQL file queries the equipment_master and equipment_logs tables
   to perform exploratory analysis, calculate downtime, MTTR, cost impact, and KPIs
   for equipment performance evaluation. Metrics can help identify underperforming
   equipment and prioritize maintenance activities.
   ========================================================= */

-- =========================================================
-- 1. VIEW MASTER DATA TABLES
-- =========================================================

-- 1.1 View all equipment details
SELECT *
FROM equipment_master;

-- 1.2 View all equipment activity logs
SELECT *
FROM equipment_logs;


-- =========================================================
-- 2. DOWNTIME ANALYSIS
-- =========================================================

-- 2.1 Total downtime per equipment (in minutes)
SELECT equipment_id,
       SUM(downtime_minutes) AS total_downtime
FROM equipment_logs
GROUP BY equipment_id
ORDER BY total_downtime DESC;

-- 2.2 Top 3 most frequent causes of downtime
SELECT cause,
       COUNT(*) AS frequency
FROM equipment_logs
GROUP BY cause
ORDER BY frequency DESC
LIMIT 3;

-- 2.3 Mean Time To Repair (MTTR) per equipment
-- MTTR represents the average downtime for each equipment
SELECT equipment_id,
       AVG(downtime_minutes) OVER (PARTITION BY equipment_id) AS mttr
FROM equipment_logs;

-- 2.4 Monthly downtime trend
-- Aggregates total downtime per month to identify seasonality or spikes
SELECT DATE_FORMAT(start_time, '%Y-%m') AS month,
       SUM(downtime_minutes) AS monthly_downtime
FROM equipment_logs
GROUP BY month
ORDER BY month;

-- 2.5 Cost impact by equipment type
-- Identifies which equipment categories contribute most to financial loss
SELECT equipment_type,
       SUM(cost_impact) AS total_cost
FROM equipment_logs
GROUP BY equipment_type
ORDER BY total_cost DESC;


-- =========================================================
-- 3. KEY PERFORMANCE INDICATORS (KPIs) FOR Q1 2024
-- =========================================================

-- 3.1 Total Downtime (Hours)
SELECT 
    SUM(downtime_minutes) / 60 AS total_downtime_hours
FROM equipment_logs
WHERE start_time BETWEEN '2024-01-01' AND '2024-03-31';

-- 3.2 Mean Time To Repair (MTTR)
-- Returns MTTR in minutes and hours
SELECT 
    (SUM(downtime_minutes) / COUNT(*)) AS mttr_minutes,
    (SUM(downtime_minutes) / COUNT(*)) / 60 AS mttr_hours
FROM equipment_logs
WHERE start_time BETWEEN '2024-01-01' AND '2024-03-31';

-- 3.3 Biggest Cause of Downtime
-- Identifies the downtime cause with highest total minutes in Q1
SELECT 
    cause,
    SUM(downtime_minutes) AS total_minutes,
    SUM(downtime_minutes) / 60 AS total_hours
FROM equipment_logs
WHERE start_time BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY cause
ORDER BY total_minutes DESC
LIMIT 1;

-- 3.4 Estimated Cost Loss
-- Total cost impact of downtime in Q1
SELECT 
    SUM(cost_impact) AS total_cost_loss
FROM equipment_logs
WHERE start_time BETWEEN '2024-01-01' AND '2024-03-31';

-- 3.5 Top 5 Highest-Risk Equipment
-- Ranked by total downtime; includes cost impact for prioritization
SELECT 
    equipment_id,
    equipment_type,
    SUM(downtime_minutes) AS total_downtime_minutes,
    SUM(downtime_minutes)/60 AS total_downtime_hours,
    SUM(cost_impact) AS total_cost_impact
FROM equipment_logs
WHERE start_time BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY equipment_id, equipment_type
ORDER BY total_downtime_minutes DESC
LIMIT 5;


-- =========================================================
-- 4. SUMMARY OF INSIGHTS
-- =========================================================
-- 4.1 Equipment with the highest downtime can be prioritized for maintenance.
-- 4.2 The most frequent downtime causes reveal areas for process improvement.
-- 4.3 MTTR per equipment highlights repair efficiency and resource allocation.
-- 4.4 Monthly downtime trends help detect patterns and plan preventive actions.
-- 4.5 Cost impact analysis identifies the financial priority for maintenance investments.
-- 4.6 KPIs for Q1 provide a snapshot for reporting to management and decision-making.
