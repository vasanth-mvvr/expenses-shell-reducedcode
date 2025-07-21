# **expenses-shell-reducedcode**

#**The main changes in this repository is making the common code into the one file and calling the common code where ever it is required**
#**Removing the VALIDATE function which is created by the user for a good user experience and replacing it with the inbuilt funtion with less UI**

#The below command needs to be kept in the starting of the file after shebang command
```
set -e
```
#As the above command does not show in which line error has occured so for that handle_error function is created.
```
handle_error(){
    echo "The error occured in line no : $1 and the command is $2"
}

trap 'handle_error ${LINENO} "$BASH_COMMAND"' ERR
```
#In the above function the trap command is used to get the error and ERR stands for error 

#**There are some disadvantages as well using the inbulit command in this repository there will be a error thrown in the "id expense" we should manually add the user in this case.**