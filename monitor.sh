#!/usr/bin/env bash

while :
do 
	pid=`ps -fe | grep ETMDaemon | grep -v grep`
        if [ $? -ne 0 ]
        then
                echo "start process....."
                ./portal
        else
                echo "runing....."
        fi
	sleep 60
done

