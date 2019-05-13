echo " Sqoop to incremental import to all tables "
sqoop job --delete inc_imp_emp_2618B56
sqoop job --delete inc_imp_dept_2618B56
sqoop job --delete inc_imp_deptemp_2618B56
sqoop job --delete inc_imp_deptmgr_2618B56
sqoop job --delete inc_imp_sal_2618B56
sqoop job --delete inc_imp_titles_2618B56


sqoop job \
--create inc_imp_emp_2618B56 \
-- import \
--connect jdbc:mysql://$1/$2 \
--username insofeadmin \
--password-file sqoop.password \
--table employees \
--incremental append \
--check-column emp_no \
--last-value 300024 \
--target-dir '/user/2618B56/employeesDB/employees/' \
-m 1

sqoop job --exec inc_imp_emp_2618B56



sqoop job \
--create inc_imp_dept_2618B56 \
-- import \
--connect jdbc:mysql://$1/$2 \
--username insofeadmin \
--password-file sqoop.password \
--table departments \
--incremental lastmodified \
--check-column last_modified \
--last-value "2018-11-04 06:50:00" \
--target-dir '/user/2618B56/employeesDB/departments/' \
-m 1 \
--merge-key dept_no

sqoop job --exec inc_imp_dept_2618B56



sqoop job \
--create inc_imp_deptemp_2618B56 \
-- import \
--connect jdbc:mysql://$1/$2 \
--username insofeadmin \
--password-file sqoop.password \
--table dept_emp \
--incremental lastmodified \
--check-column last_modified \
--last-value "2018-11-04 06:50:00" \
--target-dir '/user/2618B56/employeesDB/dept_emp/' \
--merge-key seq_no \
--split-by seq_no

sqoop job --exec inc_imp_deptemp_2618B56

sqoop job \
--create inc_imp_deptmgr_2618B56 \
-- import \
--connect jdbc:mysql://$1/$2 \
--username insofeadmin \
--password-file sqoop.password \
--table dept_manager \
--incremental lastmodified \
--check-column last_modified \
--last-value "2018-11-04 06:50:00" \
--target-dir '/user/2618B56/employeesDB/dept_manager/' \
--merge-key seq_no \
--split-by seq_no

sqoop job --exec inc_imp_deptmgr_2618B56


sqoop job \
--create inc_imp_sal_2618B56 \
-- import \
--connect jdbc:mysql://$1/$2 \
--username insofeadmin \
--password-file sqoop.password \
--table salaries \
--incremental lastmodified \
--check-column last_modified \
--last-value "2018-11-04 06:50:00" \
--target-dir '/user/2618B56/employeesDB/salaries/' \
--merge-key seq_no \
--split-by seq_no

sqoop job --exec inc_imp_sal_2618B56


sqoop job \
--create inc_imp_titles_2618B56 \
-- import \
--connect jdbc:mysql://$1/$2 \
--username insofeadmin \
--password-file sqoop.password \
--table titles \
--incremental lastmodified \
--check-column last_modified \
--last-value "2018-11-04 06:50:00" \
--target-dir '/user/2618B56/employeesDB/titles/' \
--merge-key seq_no \
--split-by seq_no

sqoop job --exec inc_imp_titles_2618B56
