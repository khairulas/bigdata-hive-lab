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
```

2. Wait for Initialization
Wait about 60 seconds for the containers to fully initialize and for HDFS to leave "Safe Mode".

3. Set Permissions (Run once after starting)
Run these commands in your terminal to unlock HDFS and create the necessary folders:

```Bash

docker exec -it namenode hdfs dfs -chmod -R 777 /
docker exec -it namenode hdfs dfs -mkdir -p /user/hive/warehouse
docker exec -it namenode hdfs dfs -chmod -R 777 /user/hive/warehouse
```

4. Connect to Hive
Access the Hive SQL CLI (Beeline) using this command:

```Bash

docker exec -it hive-server beeline -u jdbc:hive2://localhost:10000
```
Lab Exercises
Exercise 1: External Tables
Once inside the Beeline console, you can run the following SQL commands to learn about External Tables.

Step 1: Create a raw folder in HDFS (Run this in a separate terminal window, NOT inside Beeline)

```Bash

docker exec -it namenode hdfs dfs -mkdir -p /data/external_lab
docker exec -it namenode hdfs dfs -chmod -R 777 /data/external_lab
```

Step 2: Create the external table (Run this inside the Beeline console)

```SQL

CREATE EXTERNAL TABLE lab_students (id INT, name STRING)
STORED AS PARQUET
LOCATION 'hdfs://namenode:9000/data/external_lab';
```

Step 3: Insert and Select

```SQL

INSERT INTO lab_students VALUES (500, 'Student A');
SELECT * FROM lab_students;
```

Troubleshooting
Connection Refused? If beeline fails to connect, the server might still be starting. Wait 30 more seconds or run docker logs hive-server to check progress.

Permission Denied? Re-run the commands in Step 3 of the Quick Start to ensure HDFS is writable.

## Hive & Power BI Integration using ODBC

### Step 1: Install the ODBC Driver
Power BI does not speak "Hive" natively; it speaks ODBC. You need to install the official driver.

Download the Microsoft Hive ODBC Driver.

Go to Microsoft's official download page (search "Microsoft Hive ODBC Driver").

Or use the direct link for the 64-bit version (assuming you are on 64-bit Windows): Download Here.

Install the .msi file.

### Step 2: Configure the Connection (ODBC DSN)
We need to create a saved connection setting in Windows.

Press Windows Key and type ODBC Data Sources (64-bit). Open it.

Go to the System DSN tab (so it works for all users).

Click Add...

Select Microsoft Hive ODBC Driver and click Finish.

Fill in the Configuration Form:

Data Source Name: DockerHive (or any name you want).

Host: localhost (or 127.0.0.1).

Port: 10000.

Database: default.

Mechanism: Select User Name (Simple Authentication).

User Name: hive (or root).

Password: (Leave this empty; our Docker setup uses "Simple" mode which trusts any login).

Click "Test".

If it says "SUCCESS", you are ready.

Note: If it fails, ensure your Docker container is running (docker ps) and HiveServer2 is active.

### Step 3: Connect in Power BI
Open Power BI Desktop.

Click Get Data -> More...

Search for ODBC and select it.

In the dropdown menu, select the DSN you just created (DockerHive).

Click OK.

Navigator Window:

You should see HIVE on the left side.

Expand it to see default and your other databases (like internal_students or external_students).

Select the tables you want and click Load.

