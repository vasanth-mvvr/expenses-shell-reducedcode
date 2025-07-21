#!/bin/bash

set -e

handle_error(){
    echo "The error occured at line no : $1 and the command is $2"
}

trap 'handle_error ${LINENO} "$BASH_COMMAND"' ERR
USERID=$(id -u)
TIMESTAMP=$(date +%F-%I:%M:%S-%p)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 $R Failed $N"
    else
        echo -e "$2 $G Success $N"
    fi
}

check_root(){
    if [ $USERID -ne 0 ]
    then 
        echo -e " $Y You need to have super user access $N"
        exit 1
    else 
        echo "you are super user"
    fi

}
