#!/bin/bash
#===============================================================================
#
#         FILE: compile-fw.sh
#
#        USAGE: ./compile-fw.sh
#
#  DESCRIPTION: This compiles the firewall script based on informtation found
#		in the various rules and iplists.
#
#===============================================================================

# Vars and the usual suspects
. /etc/profile
IFS=$'\n\t'                     # Make the IFS sensible again...
MYNAME=$(hostname -s)
CFGDIR=/etc/hostfw
IPCALC=/etc/hostfw/ipcalc
# Harvest all the info we need
MYDATE=$(date)
MYTAG=$(cat $CFGDIR/version.txt)


# Create the template script
(
for directory in $(find . -type d | sort | grep -v docs | grep -v globalipsets | tail -n +2)
do
	for snippet in $(ls $directory/)
	do
		cat $directory/$snippet
	done
done

) > $CFGDIR/host/ipset/fwtemplate.sh


# Substitute place-holders in new fw template
sed -i -e "s/HOSTNAME/$MYNAME/g" $CFGDIR/host/ipset/fwtemplate.sh
sed -i -e "s/TAGVERSION/$MYTAG/g" $CFGDIR/host/ipset/fwtemplate.sh
sed -i -e "s/DATECREATED/$MYDATE/g" $CFGDIR/host/ipset/fwtemplate.sh

# Rename template and move into place

mv $CFGDIR/host/ipset/fwtemplate.sh $CFGDIR/host/ipset/$MYNAME.sh
mv /etc/$MYNAME.fw /etc/$MYNAME.fw-prev
cp $CFGDIR/host/ipset/$MYNAME.sh /etc/$MYNAME.fw
chmod +x /etc/$MYNAME.fw

sleep 1

# /bin/bash /etc/$MYNAME.fw
echo "Please run the following script to activate the firewall:"
echo "/etc/$MYNAME.fw"
echo
ls /etc/*.fw

# Done
