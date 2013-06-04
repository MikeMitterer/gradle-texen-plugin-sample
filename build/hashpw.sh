#!/bin/bash

SALT=0123456789abcde
#SALT=4f9krRZ0GyD8ARl
ADMINPW=test123A#
ITERATIONS=1024

echo Admin PW: $ADMINPW
echo -e

java -jar shiro-tools-hasher-1.2.1-cli.jar -pnc -i $ITERATIONS -s $SALT -ngs
