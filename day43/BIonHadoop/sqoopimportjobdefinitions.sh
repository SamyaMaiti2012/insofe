echo " Sqoop to import all tables "
sqoop job --delete $1

sqoop job \
--create $1 \
-- import-all-tables \
--connect jdbc:mysql://$2/$3 \
--username insofeadmin \
--password-file /user/2618B56/sqoop.password \
--warehouse-dir $4 \
-m 1

sqoop job --exec $1
