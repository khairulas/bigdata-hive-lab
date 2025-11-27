-- 1. Create a Managed Table (Stores data in HDFS /user/hive/warehouse)
CREATE TABLE internal_students (id INT, name STRING);
INSERT INTO internal_students VALUES (100, 'Internal Student');

-- 2. Verify it lives in HDFS
-- (You can check http://localhost:9870 in your browser to see the file)

-- 3. TEACHING EXTERNAL TABLES
-- First, we need a folder in HDFS that is NOT managed by Hive
-- (Run this command in a separate terminal window, NOT inside Beeline)
-- docker exec -it namenode hdfs dfs -mkdir -p /data/external_class
-- docker exec -it namenode hdfs dfs -chmod -R 777 /data/external_class

-- 4. Create the External Table pointing to that custom HDFS location
CREATE EXTERNAL TABLE external_students (id INT, name STRING)
STORED AS PARQUET
LOCATION 'hdfs://namenode:9000/data/external_class';

-- 5. Insert data
INSERT INTO external_students VALUES (200, 'External Student');

-- 6. Verify data
SELECT * FROM external_students;


CREATE EXTERNAL TABLE external_students_2 (id INT, name STRING)
STORED AS PARQUET
LOCATION '/data/external_students_2';