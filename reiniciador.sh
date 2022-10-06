#!/bin/bash

ssh -i ./pkey/s1 reiniciador@192.168.10.231 "sudo /sbin/reboot"
echo "LISTO"
