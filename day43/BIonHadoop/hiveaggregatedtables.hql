DROP DATABASE IF EXISTS employees_db cascade;

CREATE DATABASE IF NOT EXISTS employees_db;

USE employees_db;

DROP TABLE IF EXISTS active_emp_details;

CREATE EXTERNAL TABLE IF NOT EXISTS active_emp_details(
        emp_no                  INT,
        first_name              STRING,
        last_name               STRING,
        gender                  CHAR(1),
        birth_date              DATE,
        hire_date               DATE,
        dept_no                 CHAR(4),
        dept_name               STRING,
        dept_from_date          DATE,
        salary                  INT,
        salary_from_date        DATE,
        title                   STRING,
        title_from_date         DATE,
        manager_emp_no          INT,
        manager_first_name      STRING,
        manager_last_name       STRING,
        manager_gender          CHAR(1),
        manager_birth_date      DATE,
        manager_hire_date       DATE,
        manager_from_date       DATE,
        age                     INT,
        tenure                  INT,
        manager_age             INT,
        manager_tenure          INT,
        salary_since            INT,
        role_since              INT)
    COMMENT 'Data about all active employees derived from employees database'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE
    location '/user/2618B56/results/active_employees_data/';


INSERT OVERWRITE DIRECTORY '/user/2618B56/results/dept_aggr_by_gender/'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
SELECT
dept_no AS dept_no,
dept_name AS dept_name,
gender AS gender,
count(*) AS tot_emp,
sum(salary) AS tot_sal,
min(salary) AS min_sal,
max(salary) AS max_sal,
avg(salary) AS avg_sal,
min(age) AS min_age,
max(age) AS max_age,
avg(age) AS avg_age,
min(tenure) AS min_tenure,
max(tenure) AS max_tenure,
avg(tenure) AS avg_tenure,
avg(salary_since) AS avg_sal_change,
avg(role_since) AS avg_role_change
FROM active_emp_details
GROUP BY dept_no, gender, dept_name;


INSERT OVERWRITE DIRECTORY '/user/2618B56/results/dept_aggr/'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
SELECT
dept_no AS dept_no,
dept_name AS dept_name,
count(*) AS tot_emp,
sum(salary) AS tot_sal,
min(salary) AS min_sal,
max(salary) AS max_sal,
avg(salary) AS avg_sal,
min(age) AS min_age,
max(age) AS max_age,
avg(age) AS avg_age,
min(tenure) AS min_tenure,
max(tenure) AS max_tenure,
avg(tenure) AS avg_tenure,
avg(salary_since) AS avg_sal_change,
avg(role_since) AS avg_role_change
FROM employees_db.active_emp_details
GROUP BY dept_no, dept_name;
