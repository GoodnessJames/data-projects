/* =========================================================
   OFFSHORE EQUIPMENT ANALYTICS DATABASE
   Author: Goodness Akoma
   Database: offshore_analytics
   Description: This SQL script creates the database and core tables
   for equipment performance and downtime analysis.
   ========================================================= */

-- =========================================================
-- 1. Create and select database
-- =========================================================
CREATE DATABASE IF NOT EXISTS offshore_analytics;
USE offshore_analytics;

-- =========================================================
-- 2. Create equipment_master table
-- =========================================================
CREATE TABLE IF NOT EXISTS equipment_master (
    equipment_id VARCHAR(20) PRIMARY KEY,
    equipment_type VARCHAR(50),
    location VARCHAR(50),
    install_date DATE
);

-- =========================================================
-- 3. Create equipment_logs table
-- =========================================================
CREATE TABLE IF NOT EXISTS equipment_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    equipment_id VARCHAR(20),
    equipment_type VARCHAR(50),
    start_time DATETIME,
    end_time DATETIME,
    downtime_minutes INT,
    cause VARCHAR(50),
    severity VARCHAR(20),
    cost_impact DECIMAL(10,2),
    FOREIGN KEY (equipment_id) REFERENCES equipment_master(equipment_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
