#!/usr/bin/bash
#Script name    : T848.sh
#Description    : Script to take care of server side operations of Test case eE-848.
#Initial author : N.V. Anil Kumar
#Company        : Stratus Technologies Inc.
#Created date   : October 14, 2019
#Last modified  :
#=======================================================================================================================

VMName=$1
count=0
CMD="ps -ef | grep qemu | grep $VMName | awk '{print \$2}'"
null_axpid_count=0

echo Performing server side operations for T848:

while :
do
    echo Executing the following command to find the process id of ax process for the given VM:
    echo $CMD

    axpid=$(ps -ef | grep qemu | grep $VMName | awk '{print $2}')
    echo Got the process id : $axpid

    if [ -n "$axpid" ]; then
        echo Killing the ax process id : $axpid
        kill -9 $axpid
        sleep 180
    else
        echo axpid=$axpid
        ((null_axpid_count++))
        sleep 60
    fi

    ((count++))
    echo "Retry Count number : "  $count
    echo "Null axpid count : "    $null_axpid_count

    if [ $null_axpid_count -gt 5 ]; then
       break
    fi

    if [ $count -gt 10 ]; then
       break
    fi

done
