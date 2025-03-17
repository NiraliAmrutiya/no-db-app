#!/bin/bash

if [ -z "$1" ]; then
    err 'Pass version number'
fi

export APP_VERSION = "$1"

PID=$(sudo lsof -i :8080 -t)
echo ${PID}

if [ -z "$PID" ]; then
    echo $PID
    echo 'No process is running on port 8080.'
else
    echo 'Process found on port 8080 with PID: $PID'
    echo 'Killing process...'
    sudo kill -9 $PID
    echo 'Process killed.'
fi

# Restart the application
echo 'Running JAR on remote server...'

cd /home/ec2-user/no-db-app/

nohup java -jar no-db-app-$APP_VERSION.jar > app.log 2>&1 &

echo 'Application restarted'