#!/bin/bash
#===============================================================================
#
#         FILE: getip.sh
#
#        USAGE: ./getip.sh arg1
#
#  DESCRIPTION: Get all the local IP addresses, without "lo"
#
#===============================================================================

set -euo pipefail
IFS=$'\n\t'

for i in $(ip addr | grep "inet " | egrep -v "host lo" | egrep -v "virbr0" | awk {'print $2'} | cut -f 1 -d "/")
do
        echo $i | cut -f 2
done
