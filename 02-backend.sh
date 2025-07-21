#!/bin/bash

source ./common.sh
check_root

echo "please enter the password"
read -s my_sql_password



dnf module disable nodejs -y &>>$LOGFILE
#VALIDATE $? "Disabled nodejs"

dnf module enable nodejs:20 -y &>>$LOGFILE
#VALIDATE $? "Enabled nodejs version --20" 

dnf install nodejs -y &>>$LOGFILE
#VALIDATE $? "Installed nodejs successfully"

id=expense &>>$LOGFILE
if [ $id -ne 0 ]
then 
    useradd expense &>>$LOGFILE
 #   VALIDATE $? "user added successfully"
else
    echo -e "User is already created $Y Skipping $N"
fi

mkdir -p /app &>>$LOGFILE #Here -p is used for validating if the directory is present it ignores or else it creates a new directory
#VALIDATE $? "directory created successfully"

curl -o /home/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
#VALIDATE $? "Extracted backend code"

cd /app
rm -rf /app/* &>>$LOGFILE
unzip /home/backend.zip &>>$LOGFILE
#VALIDATE $? "Extracted file successfully"

npm install &>>$LOGFILE
#VALIDATE $? "Installed dependencies"

cp /home/ec2-user/expenses-shell-reducedcode/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
#VALIDATE $? "backend.service intiated successfully"

systemctl daemon-reload &>>$LOGFILE
#VALIDATE $? "deamon-reload backend"

systemctl start backend &>>$LOGFILE
#VALIDATE $? "Started backend"

systemctl enable backend &>>$LOGFILE
#VALIDATE $? "Enabled backend"

dnf install mysql -y &>>$LOGFILE
#VALIDATE $? "Installed mysql"

mysql -h db.vasanthreddy.space -uroot -p${my_sql_password} < /app/schema/backend.sql &>>$LOGFILE
#VALIDATE $? "Schema loaded"

systemctl restart backend &>>$LOGFILE
#VALIDATE $? "Restarted mysql"


