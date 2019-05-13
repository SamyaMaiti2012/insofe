
DROP database IF EXISTS insofe_batch56_empdb;
CREATE DATABASE IF NOT EXISTS insofe_batch56_empdb;
USE insofe_batch56_empdb;

CREATE TABLE employees (
emp_no INT NOT NULL,
birth_date DATE NOT NULL,
first_name VARCHAR(14) NOT NULL,
last_name VARCHAR(16) NOT NULL,
gender ENUM ('M','F') NOT NULL,
hire_date DATE NOT NULL,
last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (emp_no)
);



CREATE TABLE departments (
dept_no CHAR(4) NOT NULL,
dept_name VARCHAR(40) NOT NULL,
last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (dept_no),
UNIQUE KEY (dept_name)
);

CREATE TABLE dept_manager (
seq_no INT NOT NULL AUTO_INCREMENT,
dept_no CHAR(4) NOT NULL,
emp_no INT NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
KEY (emp_no),
KEY (dept_no),
UNIQUE (seq_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
PRIMARY KEY(emp_no,dept_no)
);

CREATE TABLE dept_emp (
seq_no INT NOT NULL AUTO_INCREMENT,
emp_no INT NOT NULL,
dept_no CHAR(4) NOT NULL,
from_date DATE NOT NULL,
to_date DATE,
last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
KEY (emp_no),
KEY (dept_no),
UNIQUE KEY (seq_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
FOREIGN KEY (dept_no) REFERENCES departments (dept_no) ON DELETE CASCADE,
PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE titles (
seq_no INT NOT NULL AUTO_INCREMENT,
emp_no INT NOT NULL,
title VARCHAR(50) NOT NULL,
from_date DATE NOT NULL,
to_date DATE,
last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
KEY (emp_no),
UNIQUE KEY (seq_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
PRIMARY KEY (emp_no,title, from_date)
);

CREATE TABLE salaries (
seq_no INT NOT NULL AUTO_INCREMENT,
emp_no INT NOT NULL,
salary INT NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL, 
last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
KEY (emp_no),
UNIQUE KEY (seq_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
PRIMARY KEY (emp_no,from_date)
);

select count(*) from employees;
select count(*) from departments;
select count(*) from dept_emp;
select count(*) from dept_manager;
select count(*) from salaries;
select count(*) from titles;

