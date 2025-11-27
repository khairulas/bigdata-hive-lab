# Big Data Lab: Hadoop & Hive on Docker

A fully containerized Big Data environment for teaching Hadoop HDFS and Apache Hive 4.0.

## Prerequisites
* Docker Desktop installed and running.
* 4GB+ RAM allocated to Docker.

## Quick Start

### 1. Start the Cluster
Open your terminal in this folder and run:
```bash
docker-compose up -d
2. Wait for Initialization
Wait about 60 seconds for the containers to fully initialize and for HDFS to leave "Safe Mode".

3. Set Permissions (Run once after starting)
Run these commands in your terminal to unlock HDFS and create the necessary folders:

Bash

docker exec -it namenode hdfs dfs -chmod -R 777 /
docker exec -it namenode hdfs dfs -mkdir -p /user/hive/warehouse
docker exec -it namenode hdfs dfs -chmod -R 777 /user/hive/warehouse
4. Connect to Hive
Access the Hive SQL CLI (Beeline) using this command:

Bash

docker exec -it hive-server beeline -u jdbc:hive2://localhost:10000
Lab Exercises
Exercise 1: External Tables
Once inside the Beeline console, you can run the following SQL commands to learn about External Tables.

Step 1: Create a raw folder in HDFS (Run this in a separate terminal window, NOT inside Beeline)

Bash

docker exec -it namenode hdfs dfs -mkdir -p /data/external_lab
docker exec -it namenode hdfs dfs -chmod -R 777 /data/external_lab
Step 2: Create the external table (Run this inside the Beeline console)

SQL

CREATE EXTERNAL TABLE lab_students (id INT, name STRING)
STORED AS PARQUET
LOCATION 'hdfs://namenode:9000/data/external_lab';
Step 3: Insert and Select

SQL

INSERT INTO lab_students VALUES (500, 'Student A');
SELECT * FROM lab_students;
Troubleshooting
Connection Refused? If beeline fails to connect, the server might still be starting. Wait 30 more seconds or run docker logs hive-server to check progress.

Permission Denied? Re-run the commands in Step 3 of the Quick Start to ensure HDFS is writable.


---

### **File: `.gitignore`**
(Just in case you need this clean copy as well)

```text
# Ignore Database Data
hive_data/
metastore_db/
derby.log

# Ignore Jupyter/IDE files
.ipynb_checkpoints/
*/.ipynb_checkpoints/
.idea/
.vscode/

# Ignore OS Files
.DS_Store
Thumbs.db

# Ignore Docker temporary files
.docker/