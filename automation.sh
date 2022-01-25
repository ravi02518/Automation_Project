#!/bin/bash
#!/bin/bash
if [ $(/etc/init.d/apache2 status | grep -v grep | grep 'Apache2 is running' | wc -l) > 0 ]
then
 echo "Process is running."
else
  echo "Process is not running."
  sudo apt update
  sudo apt install apache2
  service apache2 start
fi
echo "Creating TimeStamp"
ts=$(date +"%d%m%Y"-"%H%M%S")
echo $ts
echo "Navigating To Apache logs"
cd /var/log/apache2
echo "Listing logs file from apache dir"
ls -l
echo "Crating TAR File of Apache logs"
tar -cvf /tmp/Chenna-httpd-logs-$ts.tar ./access.log ./error.log ./other_vhosts_access.log
cd /tmp
echo "Printing the TAR file from TMP DIR"
ls
aws s3 cp ./Chenna-httpd-logs-$ts.tar s3://upgrad-chenna/