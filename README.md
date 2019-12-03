# moloch-sandbox
HW reqs
~~~~
Memory:  4GB
Network: 2 network cards, one for management, one for capture
~~~~
Elasticsearch reqs
~~~~
moloch_version: 2.1.0-1
elasticsearch_version: 6.8.5

This is a fresh Moloch install
Currently using Elasticsearch version  5.6.16  which isn't supported
 * < 6.7.0 is not supported
 * 7.0.x is not supported
~~~~
Common bugs that may need to be addressed:
~~~~


The memlock must be set to unlimited or the elasticsearch will close the moloch capture. Prep the elasticsearch machines by increasing max file descriptors and allowing memory locking. On CentOS and others this is done by adding the following to bottom of: /etc/security/limits.conf: - nofile 128000 - memlock unlimited

If this is a dedicated machine, disable swap by commenting out the swap lines in /etc/fstab and either reboot or use the swapoff command.

Make sure the network card is configured correctly by increasing the ring buf to max size and turning off most of the card's features.since we want to capture what is on the network instead of what the local OS sees.
Set ring buf size, see max with
ethtool -g eth0

$ ethtool -G eth1 rx 4096 tx 4096
$ ethtool -g eth1
Ring parameters for eth1:
Pre-set maximums:
RX:             4096
RX Mini:        0
RX Jumbo:       0
TX:             4096
Current hardware settings:
RX:             4096
RX Mini:        0
RX Jumbo:       0
TX:             4096


see available features
$ ethtool -k eth1
$ sudo ethtool -K eth1 rx off tx off tso off gso off

<https://github.com/sofwerx/pcas/wiki/Moloch-User-Guide>
~~~~
Install moloch
~~~~
$ sudo /data/moloch/bin/Configure
Found interfaces: eth0;eth1;lo
Semicolon ';' seperated list of interfaces to monitor [eth1] eth1
Install Elasticsearch server locally for demo, must have at least 3G of memory, NOT recommended for production use (yes or no) [no] no
Elasticsearch server URL [http://localhost:9200]
Password to encrypt S2S and other things [no-default] no
Moloch - Creating configuration files
Installing systemd start files, use systemctl
Moloch - Installing /etc/logrotate.d/moloch to rotate files after 7 days
Moloch - Installing /etc/security/limits.d/99-moloch.conf to make core and memlock unlimited
Download GEO files? (yes or no) [yes] yes
Moloch - Downloading GEO files
~~~~

~~~~
sudo /data/moloch/db/db.pl http://localhost:9200 init
npm update
sudo /data/moloch/bin/moloch_add_user.sh admin admin admin123 --admin

sudo systemctl start molochcapture.service
sudo systemctl status molochcapture.service

sudo systemctl start molochviewer.service
sudo systemctl status molochviewer.service

sudo lsof -i | grep 8005
sudo lsof -i | grep 9200

<http://192.168.16.9:8005>

~~~~
smoketest moloch
~~~~
live capture
$ sudo /data/moloch/bin/./moloch-capture -r ~capture.pcap
index a directory
$ sudo /data/moloch/bin/./moloch-capture -R ~/
~~~~

~~~~
Publicly available PCAP files
<https://www.netresec.com/?page=PcapFiles>
SharkFest EUROPE Retrospective
<https://sharkfesteurope.wireshark.org/retrospective>
~~~~
