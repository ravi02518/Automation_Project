#!/bin/bash
if [ $(/etc/init.d/apache2 status | grep 'Apache2 is running' | wc -l) > 0 ]
then
 echo "Process is running."
else
  echo "Process is not running."
  sudo apt update
  sudo apt install apache2
  sudo service apache2 start
fi
myname=chenna
echo "Creating TimeStamp"
ts=$(date +"%d%m%Y"-"%H%M%S")
echo $ts
echo "Navigating To Apache logs"
cd /var/log/apache2
echo "Listing logs file from apache dir"
ls -l
echo "Crating TAR File of Apache logs"
tar -cvf /tmp/$myname-httpd-logs-$ts.tar ./access.log ./error.log ./other_vhosts_access.log
cd /tmp
echo "Printing the TAR file from TMP DIR"
ls
