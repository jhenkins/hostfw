#!/bin/bash
#===============================================================================
#
#         FILE: hostprep-fwinstall.sh 
#
#        USAGE: ./hostprep-fwinstall.sh 
#
#  DESCRIPTION:	Install the firewall
#
#===============================================================================

# Vars and the usual suspects
. /etc/profile
MYNAME=$(hostname -s)
CFGDIR=/etc/hostfw
MYPWD=$(pwd)

## Flush old firewall rules
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables -X
ipset destroy

## Install relevant firewall scripts
# rsync -q $CFGDIR/templates/im-firewalls/ipset $CFGDIR/
cd $CFGDIR/host/ipset
chmod +x *.sh
# Compile the firewall script
./compile-fw.sh

# Done! Go back to where we started.
cd $MYPWD
