#!/usr/bin/env bash

Project_HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd | sed 's/\/sbin//')

echo "$Project_HOME"

APP_NAME=jrx.samples.springboot.RootApplication

tpid=`ps -ef|grep $APP_NAME|grep -v grep|grep -v kill|awk '{print $2}'`
if [ ${tpid} ]; then
        echo 'App is running.'
else
        echo 'App is NOT running.'
fi