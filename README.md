# Automation_Project
1.written condition to check if apache is installed
2. if not installed apache will be installed with commands sudo apt install and we will start the apache with service apache start
3. creating the timestamp and storing into variable
4. create the TAR of apache logs to tmp folder, while creating TAR appending the Timestamp to this
5.Now copying this TAR from tmp to amazon s3 bucket which we have created earlier.