#!/bin/bash
#===============================================================================
#
#         FILE: hostprep-config.sh
#
#        USAGE: ./hostprep-config.sh
#
#  DESCRIPTION: Prepare the host and firewall
#
#===============================================================================

# Vars and the usual suspects
. /etc/profile
MYNAME=$(hostname -s)
CFGDIR=/etc/hostfw

# Proper bash prompt
#cp -f $CFGDIR/host/ps1.sh /etc/profile.d/

## Create an rc.local service to run the firewall script at boot-up
mkdir -p /etc/init.d
cp -f $CFGDIR/host/rc.local /etc/init.d/
sed -i -e "s/MYSHORTNAME/$MYNAME/g" /etc/init.d/rc.local
chmod +x /etc/init.d/rc.local
ln -sf /etc/init.d/rc.local /etc/rc.local
cp -f $CFGDIR/host/rc-local.service /etc/systemd/system/rc-local.service
systemctl enable rc-local.service

## Ensure that IP Forwarding is switched on.
cp -f $CFGDIR/host/sysctl.conf /etc/sysctl.conf
/usr/sbin/sysctl -p /etc/sysctl.conf

# Add your public key to root's authorized keys
cat >> /root/.ssh/authorized_keys << 'EOF'

ssh-rsa [your_ssh_key_here]

EOF
chmod 600 /root/.ssh/authorized_keys
