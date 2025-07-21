#!/bin/bash

source ./common.sh
check_root

echo "please enter the password"
read -s my_sql_password




dnf install mysql-server -y &>>$LOGFILE
#VALIDATE $? "Installing mysql-server"

systemctl enable mysqld &>>$LOGFILE
#VALIDATE $? "Enabling service of mysql-server"

systemctl start mysqld &>>$LOGFILE
#VALIDATE $? "Starting service of mysql-server"

#Here the disadvantage is that once we set up the password it cannot be repeated and we should make sure that it is idempotent in nature in the shell script .
#Idempotent means how many ever times you run it should of be the same.

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
# VALIDATE $? "Setting up the root password"

mysql -h db.vasanthreddy.space -uroot -p${my_sql_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ${my_sql_password}
 #   VALIDATE $? "Password setup " &>>$LOGFILE
else
    echo -e "Password is already set .. $Y Skipping $N"
fi
