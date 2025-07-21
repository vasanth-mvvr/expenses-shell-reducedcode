#!/bin/bash

source ./common.sh
check_root




dnf install nginx -y &>>$LOGFILE
#VALIDATE $? "Installed nginx"

systemctl enable nginx &>>$LOGFILE
#VALIDATE $? "Enabled nginx"

systemctl start nginx &>>$LOGFILE
#VALIDATE $? "Started nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
#VALIDATE $? "Removed the default content"

curl -o /home/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
#VALIDATE $? "Received frontend file"

cd /usr/share/nginx/html &>>$LOGFILE
unzip /home/frontend.zip &>>$LOGFILE
#VALIDATE $? "unzipped the files"

cp /home/ec2-user/expenses-shell-reducedcode/expense.conf /etc/nginx/default.d/expense.conf  &>>$LOGFILE
#VALIDATE $? " copied"

systemctl restart nginx &>>$LOGFILE
#VALIDATE $? "Restarted successfully"