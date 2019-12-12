#!/usr/bin/bash
#Script Name    :T1092.sh --  Script to take care of server side operations of Test case eE-1092
#Description    : Accepts one VM name as argument. Executes the command to crash the given VM continuously in a loop until the VM is stopped and blacklisted.
#                 Verifies an alert has been logged for the same.
#Initial author : N.V. Anil Kumar
#Company        : Stratus Technologies Inc.
#Created date   : November 05, 2019
#Last modified  :
#=======================================================================================================================

VMName=$1
while :
 do
    standing_state=$(/usr/bin/avcli vm-info $VMName | grep state | awk '$2=="standing-state" {print $4}')
    CMD="avcli vm-info $VMName | grep state | awk '\$2=="standing-state" {print \$4}'"
    echo $CMD

    state=$(/usr/bin/avcli vm-info $VMName | grep state | awk '$2=="state" {print $4}')
    CMD="avcli vm-info $VMName | grep state | awk '\$2=="state" {print \$4}'"
    echo $CMD

    if [ "$standing_state" == "blacklisted" -a "$state" == "stopped" ]; then

        echo "Alert-info:"
        avcli alert-info | grep description | grep $VMName | grep "failed too often and will not be restarted"

        echo VM $VMName has been stopped and blacklisted. It can no longer restart without resetting the device from everRun Active Console.
        break
    fi

    echo Executing the below command to crash the given VM : $VMName
    CMD="virsh qemu-monitor-command $VMName  --hmp --cmd \"mce -b 0 0 0xA000000000000001 4 0 0\""
    echo $CMD

    virsh qemu-monitor-command $VMName  --hmp --cmd "mce -b 0 0 0xA000000000000001 4 0 0"
    echo Sleeping for 3 minutes to allow VM to come up yet again...
    sleep 180
 done

