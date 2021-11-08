#
# Makefile
# Jan Henkins, 2017-09-13 11:06
#

prefix=/usr/local
docs=/usr/share
OURTAG=`/usr/bin/git describe --tags`
OURSTAMP=`date +%Y%m%d%S`
LOCALTAG=`cat version.txt`
confdir=hostfw-$(LOCALTAG)

install: 
	rm -rf /etc/hostfw
	mkdir -p /etc/$(confdir)/
	mkdir -p $(docs)/doc/hostfw
	install -m 0755 ipcalc /etc/$(confdir)/
	install -m 0533 version.txt /etc/$(confdir)/
	install -m 0755 hostprep-* /etc/$(confdir)/
	install -m 0755 fw-flush.sh /etc/$(confdir)/
	install -m 0644 *.md $(docs)/doc/hostfw/
	cp -rf host/ /etc/$(confdir)/
	cp -f host/logrotate-iptables /etc/logrotate.d/iptables
	cp -f host/rsyslog-iptables.conf /etc/rsyslog.d/iptables.conf
	ln -sf /etc/$(confdir) /etc/hostfw
	touch /etc/remote-admin-ips
	touch /etc/remote-admin-nets
	$(info )
	$(info Important notice:)
	$(info * You should restart rsyslogd, since we have installed a new configuration file.)
	$(info )

uninstall:
	rm -rf $(docs)/doc/hostfw/
	/usr/bin/bash /etc/$(confdir)/fw-flush.sh
	rm -rf /etc/hostfw*
	rf -f /etc/remote-admin*

dist:   
	cp -r ../host-firewall/ ../host-firewall-$(OURTAG)
	rm -rf ../host-firewall-$(OURTAG)/.git/
	rm -rf ../host-firewall-$(OURTAG)/.gitlab/
	rm -rf ../host-firewall-$(OURTAG)/.gitignore
	echo $(OURTAG) > ../host-firewall-$(OURTAG)/version.txt
	tar zcvf ../host-firewall-$(OURTAG).tgz ../host-firewall-$(OURTAG)/
	rm -rf ../host-firewall-$(OURTAG)

.PHONY: install

# vim:ft=make
#
