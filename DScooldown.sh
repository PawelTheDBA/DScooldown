#!/bin/bash
#
# Script Name: DScooldown.sh
# Author: Pawel Podkul
# Date: 2022-06-01
#
# Description: This script is intend to reduce Cooldown Time from Dynamic Scaling for Exadata. This script checks 
# if the Cooldown time is set to default 120 mins and updates it to 5 mins. It also logs the changes to a log file.
#
# Usage: ./DScooldown.sh

json_file="/acfs01/ODYS/.ds-scalingtime.json"
json_file_prev="/acfs01/ODYS/.ds-scalingtime.json_prev"
log_file="/acfs01/ODYS/logs/DScooldown.log"

if diff $json_file $json_file_prev; then
        echo "no changes"
        echo "`date +"%Y-%m-%d %H:%M:%S"`: no changes" >> $log_file
        exit;
else
        echo "changes"
        orig_message=`cat $json_file`

        #reseting sopnum
        sed -i 's/"sopnum": "."/"sopnum": "0"/g' $json_file

        #change wait time
        sed -i 's/"wait": "120"/"wait": "5"/g' $json_file

        #Create copy for compare
        cp $json_file $json_file_prev

        new_message=`cat $json_file`

        #Print to log file
        echo -e "`date +"%Y-%m-%d %H:%M:%S"`: changing from: \n $orig_message \n to \n $new_message" >> $log_file

        chown opc:opc $json_file
        chown opc:opc $json_file_prev
fi

