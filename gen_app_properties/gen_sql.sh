#!/bin/bash

echo "CREATE DATABASE  IF NOT EXISTS \`${DB_ARROWHEAD}\` /*!40100 DEFAULT CHARACTER SET utf8 */;" >> create_iot_user.sql

echo "CREATE DATABASE  IF NOT EXISTS \`${DB_ARROWHEAD_LOG}\`;" >> create_iot_user.sql

echo "CREATE USER '${DEFAULT_DB_ARROWHEAD_USR}'@'%' IDENTIFIED BY '${DEFAULT_DB_ARROWHEAD_PSW}';" >> create_iot_user.sql
echo "GRANT ALL PRIVILEGES ON ${DB_ARROWHEAD_LOG}.* TO '${DEFAULT_DB_ARROWHEAD_USR}'@'%';" >> create_iot_user.sql
echo "GRANT ALL PRIVILEGES ON ${DB_ARROWHEAD}.* TO '${DEFAULT_DB_ARROWHEAD_USR}'@'%';" >> create_iot_user.sql

echo "USE \`${DB_ARROWHEAD_LOG}\`;" >> create_iot_user.sql

echo "DROP TABLE IF EXISTS \`logs\`;" >> create_iot_user.sql
echo "CREATE TABLE \`logs\` (" >> create_iot_user.sql
echo "  \`id\` int(10) unsigned NOT NULL AUTO_INCREMENT," >> create_iot_user.sql
echo "  \`date\` datetime NOT NULL," >> create_iot_user.sql
echo "  \`origin\` varchar(255) COLLATE utf8_unicode_ci NOT NULL," >> create_iot_user.sql
echo "  \`level\` varchar(10) COLLATE utf8_unicode_ci NOT NULL," >> create_iot_user.sql
echo "  \`message\` varchar(1000) COLLATE utf8_unicode_ci NOT NULL," >> create_iot_user.sql
echo "  PRIMARY KEY (\`id\`)" >> create_iot_user.sql
echo ") ENGINE=InnoDB AUTO_INCREMENT=1557 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;" >> create_iot_user.sql

cp create_iot_user.sql database_scripts
rm create_iot_user.sql
