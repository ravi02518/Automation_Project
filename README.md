# Automation_Project
Written condition to check if apache is installed
if not installed apache will be installed with commands sudo apt install and we will start the apache with service apache start
creating the timestamp and storing into variable
create the TAR of apache logs to tmp folder, while creating TAR appending the Timestamp to this
Now copying this TAR from tmp to amazon s3 bucket which we have created earlier.
Checking if inventory file is available or not in /var/www/html if not create the file and update the file with type,size.time created
Checking if cron job file is available or not in /etc/cron.d if not create it for first time so that cron job is scheduled.
