#!/bin/bash

echo "XXXXXXXY"
echo $1

echo 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
echo $PORT
echo 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
echo $PORT > /var/local/port.txt

sed -i 's/:80/:'$PORT'/g' /etc/apache2/sites-available/pirdslogger.org.conf
sed -i 's/80/'$PORT'/g' /etc/apache2/ports.conf

cat /etc/apache2/ports.conf
cat /etc/apache2/sites-available/pirdslogger.org.conf

service apache2 start
#From here: https://docs.docker.com/config/containers/multi-service_container/
# We want the pirds_logger to log to /data, which
# is a volume, leaving the files accessible to the outside
cd /data
/var/www/cgi-bin/pirds_logger -D 6111 > debug_log.out 2> debug_log.err
