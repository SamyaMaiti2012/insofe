echo "No. of rows in departments table"
hdfs dfs -cat /user/2618B56/Cute_Big_data/web_sales/* | wc -l
echo "No. of rows in dept_emp table"
hdfs dfs -cat /user/2618B56/Cute_Big_data/warehouse/* | wc -l
echo "No. of rows in dept_manager table"
hdfs dfs -cat /user/2618B56/Cute_Big_data/item/* | wc -l
