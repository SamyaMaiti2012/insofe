
drop database if exists insofe_batch56_empdb cascade;
create database insofe_batch56_empdb;

use insofe_batch56_empdb;

CREATE EXTERNAL TABLE IF NOT EXISTS departments (
        dept_no STRING,
        dept_name STRING,
        last_modified TIMESTAMP)
    COMMENT 'Hive Table Definition about departments table from employees database'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE
    LOCATION '/user/2618B56/employeesDB/departments/';

CREATE EXTERNAL TABLE IF NOT EXISTS dept_emp (
        seq_no INT,
        emp_no INT,
        dept_no STRING,
        from_date STRING,
        to_date STRING,
        last_modified TIMESTAMP)
    COMMENT 'Hive Table Definition about dept_emp table from employees database'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE
    LOCATION '/user/2618B56/employeesDB/dept_emp/';

CREATE EXTERNAL TABLE IF NOT EXISTS dept_manager (
        seq_no INT,
        dept_no STRING,
        emp_no INT,
        from_date STRING,
        to_date STRING,
        last_modified TIMESTAMP)
    COMMENT 'Hive Table Definition about dept_manager table from employees database'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE
    LOCATION '/user/2618B56/employeesDB/dept_manager/';

CREATE EXTERNAL TABLE IF NOT EXISTS employees (
        emp_no INT,
        birth_date STRING,
        first_name STRING,
        last_name STRING,
        gender STRING,
        hire_date STRING,
        last_modified TIMESTAMP)
    COMMENT 'Hive Table Definition about employees table from employees database'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE
    LOCATION '/user/2618B56/employeesDB/employees/';

CREATE EXTERNAL TABLE IF NOT EXISTS salaries (
        seq_no INT,
        emp_no INT,
        salary INT,
        from_date STRING,
        to_date STRING,
        last_modified TIMESTAMP)
    COMMENT 'Hive Table Definition about salaries table from employees database'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE
    LOCATION '/user/2618B56/employeesDB/salaries/';

CREATE EXTERNAL TABLE IF NOT EXISTS titles (
        seq_no INT,
        emp_no INT,
        title STRING,
        from_date STRING,
        to_date STRING,
        last_modified TIMESTAMP)
    COMMENT 'Hive Table Definition about titles table from employees database'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE
    LOCATION '/user/2618B56/employeesDB/titles/';

select count(*) from employees;
select count(*) from departments;
select count(*) from dept_emp;
select count(*) from dept_manager;
select count(*) from salaries;
select count(*) from titles;
