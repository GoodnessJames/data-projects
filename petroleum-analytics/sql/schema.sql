CREATE DATABASE offshore_analytics;
USE offshore_analytics;

CREATE TABLE equipment_master (
    equipment_id VARCHAR(20) PRIMARY KEY,
    equipment_type VARCHAR(50),
    location VARCHAR(50),
    install_date DATE
);

CREATE TABLE equipment_logs (
    log_id INT PRIMARY KEY,
    equipment_id VARCHAR(20),
    equipment_type VARCHAR(50),
    start_time DATETIME,
    end_time DATETIME,
    downtime_minutes INT,
    cause VARCHAR(50),
    severity VARCHAR(20),
    cost_impact DECIMAL(10,2),
    FOREIGN KEY (equipment_id) REFERENCES equipment_master(equipment_id)
);