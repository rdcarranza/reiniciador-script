#!/bin/bash

printf "DATOS: sip.conf\n"
while read sip;
do
    echo "$sip"
done <sip.conf

echo "Reinciando s1..."
#ssh -i ./pkey/s1 reiniciador@192.168.10.230 "sudo /sbin/reboot"
echo "Reinciando s2..."
#ssh -i ./pkey/s2 reiniciador@172.16.22.230 "sudo /sbin/reboot"
echo "Reinciando s3..."
#ssh -i ./pkey/s3 reiniciador@172.16.22.231 "sudo /sbin/reboot"
echo "LISTO"
