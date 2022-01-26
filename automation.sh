#!/bin/bash
if [ $(/etc/init.d/apache2 status | grep 'Apache2 is running' | wc -l) > 0 ]
then
 echo "Apache Process is running."
else
  echo "Apache Process is not running."
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
SIZE_OF_FILE=$(ls -lh ./$myname-httpd-logs-$ts.tar | awk '{print  $5}')
aws s3 cp ./$myname-httpd-logs-$ts.tar s3://upgrad-chenna/
echo "File Size:  $SIZE_OF_FILE"
INVENTORY_FILE=/var/www/html/inventory.html
if [ -f $INVENTORY_FILE ]; then
        echo "Inventory File exists. Updating the Inventory file."
        echo "httpd-logs        $ts             tar     $SIZE_OF_FILE" >> $INVENTORY_FILE
else
        touch $INVENTORY_FILE && echo "LogType TimeCreated            Type    Size" >>$INVENTORY_FILE
        echo "httpd-logs        $ts             tar     $SIZE_OF_FILE" >> $INVENTORY_FILE
fi
CRON_PATH=/etc/cron.d/automation
if [ -f $CRON_PATH ]; then
  echo "Cron Job is Scheduled."
else
  echo "Cron Job is not available. Scheduling the CronJob now."
  touch $CRON_PATH && echo "0 0 * * * root /root/Automation_Project/automation.sh" >> $CRON_PATH
fi
