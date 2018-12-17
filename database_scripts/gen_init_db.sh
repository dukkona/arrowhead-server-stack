#!/bin/bash

echo "CREATE DATABASE IF NOT EXISTS ${DB_ARROWHEAD_LOG};" >> init_db.sql
echo "CREATE DATABASE IF NOT EXISTS ${DB_ARROWHEAD};" >> init_db.sql
echo "/* test comment */" >> init_db.sql
echo "CREATE USER '${DEFAULT_DB_ARROWHEAD_USR}'@'localhost' IDENTIFIED BY '${DEFAULT_DB_ARROWHEAD_PSW}';" >> init_db.sql
echo "CREATE USER '${DEFAULT_DB_ARROWHEAD_USR}'@'%' IDENTIFIED BY '${DEFAULT_DB_ARROWHEAD_PSW}';" >> init_db.sql 

echo "USE ${DB_ARROWHEAD_LOG};" >> init_db.sql
echo "CREATE TABLE logs ( id int(10) unsigned NOT NULL AUTO_INCREMENT, date datetime NOT NULL, origin varchar(255) COLLATE utf8_unicode_ci NOT NULL, level varchar(10) COLLATE utf8_unicode_ci NOT NULL, message varchar(1000) COLLATE utf8_unicode_ci NOT NULL, PRIMARY KEY (id) ) ENGINE=InnoDB AUTO_INCREMENT=1557 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;" >> init_db.sql

echo "GRANT ALL PRIVILEGES ON ${DB_ARROWHEAD_LOG}.* TO '${DEFAULT_DB_ARROWHEAD_USR}'@'%';" >> init_db.sql
echo "GRANT ALL PRIVILEGES ON ${DB_ARROWHEAD_LOG}.* TO '${DEFAULT_DB_ARROWHEAD_USR}'@'localhost';" >> init_db.sql

echo "GRANT ALL PRIVILEGES ON ${DB_ARROWHEAD}.* TO '${DEFAULT_DB_ARROWHEAD_USR}'@'%';" >> init_db.sql
echo "GRANT ALL PRIVILEGES ON ${DB_ARROWHEAD}.* TO '${DEFAULT_DB_ARROWHEAD_USR}'@'localhost';" >> init_db.sql

