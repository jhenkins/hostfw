#!/bin/bash
#===============================================================================
#
#         FILE: getallip.sh
#
#        USAGE: ./getallip.sh arg1
#
#  DESCRIPTION: Get all IP addresses, including lo
#
#===============================================================================


set -euo pipefail
IFS=$'\n\t'

for i in $(ip addr | grep "inet " | egrep -v "virbr0" | awk {'print $2'} | cut -f 1 -d "/")
do
        echo $i | cut -f 2
done

