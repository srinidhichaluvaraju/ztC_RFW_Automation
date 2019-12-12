#!/usr/bin/bash
#T849.sh -- Script to take care of server side operations of Test case eE-849.
#Description : Accepts one or two VM names as arguments. When one is given executes a procedure to find and kill the process id of ax process.
#               When two are given executes a procedure to clear MTBF via command line. For the first VM name is used and for the second VM its VM Id is used.
#------------------------------------------------------------------------------------
Find_and_Kill-axpid()
{
    VMName=$1
    count=0
    null_axpid_count=0

    CMD="ps -ef | grep qemu | grep $VMName | awk \'{print \$2}\'"
    echo Executing the following command to find the process id of ax process for the given VM: $TestVM1
    echo $CMD

 while :
   do
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
}

#------------------------------------------------------------------------------------

Clear_MBTF_Via_CmdLine()
{
 echo Clearing MTBF for the given VMs via avcli command line:
 echo Clearing MTBF using name for $TestVM1
 echo Clearing MTBF using ID for $TestVM2

 echo Executing the below command to get VM Id of $TestVM2 VM ...
 echo 'avcli vm-info'  $TestVM2 '| grep id | grep vm | awk -F " "'  \'{print \$4}\'
 VMId=`avcli vm-info $TestVM2 | grep id | grep vm | awk -F " " '{print $4}'`

 avcli localvm-clear-mtbf $TestVM1 $VMId
 sleep 5
 echo Done.
}

#------------------------------------------------------------------------------------

TestVM1=$1
TestVM2=$2

echo Performing server side operations for T849:

echo Number of command line arguments supplied : $#

case $# in
1) Find_and_Kill-axpid  $TestVM1
   ;;
2) Clear_MBTF_Via_CmdLine $TestVM1 $TestVM2
   ;;
\?) echo Only two arguments are expected
esac


