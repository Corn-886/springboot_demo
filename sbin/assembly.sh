#!/usr/bin/env bash

Project_HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd | sed 's/\/sbin//')

echo "$Project_HOME"


mvn -f $Project_HOME/pom.xml clean assembly:assembly -DskipTests