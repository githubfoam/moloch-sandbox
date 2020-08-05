# moloch-sandbox

[![Build Status](https://travis-ci.com/githubfoam/moloch-sandbox.svg?branch=master)](https://travis-ci.com/githubfoam/moloch-sandbox)  

Install moloch
~~~~

>vagrant up "vg-moloch-01"
>vagrant ssh "vg-moloch-01"

$ whoami
vagrant
$ id vagrant
uid=1000(vagrant) gid=1000(vagrant) groups=1000(vagrant),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),110(lxd),115(lpadmin),116(sambashare)


$ sudo /data/moloch/bin/Configure
Found interfaces: eth0;eth1;lo
Semicolon ';' seperated list of interfaces to monitor [eth1]
Install Elasticsearch server locally for demo, must have at least 3G of memory, NOT recommended for production use (yes or no) [no] yes
/usr/bin/java
Password to encrypt S2S and other things [no-default] no
Moloch - Creating configuration files
Installing systemd start files, use systemctl
Moloch - Downloading and installing demo OSS version of Elasticsearch
--2020-08-05 12:05:17--  https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-6.8.2.deb
Resolving artifacts.elastic.co (artifacts.elastic.co)... 151.101.114.222, 2a04:4e42:3::734
Connecting to artifacts.elastic.co (artifacts.elastic.co)|151.101.114.222|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 68347988 (65M) [application/octet-stream]
Saving to: ‘elasticsearch-oss-6.8.2.deb’

elasticsearch-oss-6.8.2.deb             100%[=============================================================================>]  65.18M  5.76MB/s    in 12s

2020-08-05 12:05:30 (5.59 MB/s) - ‘elasticsearch-oss-6.8.2.deb’ saved [68347988/68347988]

Selecting previously unselected package elasticsearch-oss.
dpkg: regarding elasticsearch-oss-6.8.2.deb containing elasticsearch-oss:
 elasticsearch-oss conflicts with elasticsearch
  elasticsearch (version 6.8.5) is present and installed.

dpkg: error processing archive elasticsearch-oss-6.8.2.deb (--install):
 conflicting packages - not installing elasticsearch-oss
Errors were encountered while processing:
 elasticsearch-oss-6.8.2.deb
Moloch - Installing /etc/logrotate.d/moloch to rotate files after 7 days
Moloch - Installing /etc/security/limits.d/99-moloch.conf to make core and memlock unlimited
Download GEO files? (yes or no) [yes] yes
Moloch - Downloading GEO files
2020-08-05 12:05:39 URL:https://www.iana.org/assignments/ipv4-address-space/ipv4-address-space.csv [23322/23322] -> "ipv4-address-space.csv" [1]
WARNING: timestamping does nothing in combination with -O. See the manual
for details.

Username/Password Authentication Failed.
WARNING: timestamping does nothing in combination with -O. See the manual
for details.

Username/Password Authentication Failed.
2020-08-05 12:05:41 URL:https://raw.githubusercontent.com/wireshark/wireshark/master/manuf [1733449/1733449] -> "oui.txt" [1]

Moloch - Configured - Now continue with step 4 in /data/moloch/README.txt

      /sbin/start elasticsearch # for upstart/Centos 6/Ubuntu 14.04
      systemctl start elasticsearch.service # for systemd/Centos 7/Ubuntu 16.04
 5) Initialize/Upgrade Elasticsearch Moloch configuration
  a) If this is the first install, or want to delete all data
      /data/moloch/db/db.pl http://ESHOST:9200 init
  b) If this is an update to moloch package
      /data/moloch/db/db.pl http://ESHOST:9200 upgrade
 6) Add an admin user if a new install or after an init
      /data/moloch/bin/moloch_add_user.sh admin "Admin User" THEPASSWORD --admin
 7) Start everything
   a) If using upstart (Centos 6 or sometimes Ubuntu 14.04):
      /sbin/start molochcapture
      /sbin/start molochviewer
   b) If using systemd (Centos 7 or Ubuntu 16.04 or sometimes Ubuntu 14.04)
      systemctl start molochcapture.service
      systemctl start molochviewer.service
 8) Look at log files for errors
      /data/moloch/logs/viewer.log
      /data/moloch/logs/capture.log
 9) Visit http://MOLOCHHOST:8005 with your favorite browser.
      user: admin
      password: THEPASSWORD from step #6

Any configuration changes can be made to /data/moloch/etc/config.ini
See https://molo.ch/faq#moloch-is-not-working for issues

Additional information can be found at:
  * https://molo.ch/faq
  * https://molo.ch/settings



$ sudo systemctl start elasticsearch.service
$ sudo systemctl status elasticsearch.service
● elasticsearch.service - Elasticsearch
   Loaded: loaded (/usr/lib/systemd/system/elasticsearch.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2020-08-05 12:03:11 UTC; 3min 19s ago
     Docs: http://www.elastic.co
 Main PID: 24675 (java)
    Tasks: 42
   Memory: 1.2G
      CPU: 38.482s
   CGroup: /system.slice/elasticsearch.service
           ├─24675 /usr/bin/java -Xms1g -Xmx1g -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -Des.networkad
           └─24911 /usr/share/elasticsearch/modules/x-pack-ml/platform/linux-x86_64/bin/controller

Aug 05 12:03:11 vg-moloch-01 systemd[1]: Started Elasticsearch.
Aug 05 12:03:12 vg-moloch-01 elasticsearch[24675]: warning: Falling back to java on path. This behavior is deprecated. Specify JAVA_HOME
Aug 05 12:06:26 vg-moloch-01 systemd[1]: Started Elasticsearch.


~~~~

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
a) If this is the first install, or want to delete all data
$ sudo /data/moloch/db/db.pl http://localhost:9200 init
It is STRONGLY recommended that you stop ALL moloch captures and viewers before proceeding.  Use 'db.pl http://localhost:9200 backup' to backup db first.
There is 1 elastic search data node, if you expect more please fix first before proceeding.
This is a fresh Moloch install
Erasing
Creating
Finished


$ sudo npm update

Add an admin user if a new install or after an init
$ sudo /data/moloch/bin/moloch_add_user.sh admin admin admin123 --admin
Added

$ sudo systemctl start molochcapture.service
$ sudo systemctl status molochcapture.service
● molochcapture.service - Moloch Capture
   Loaded: loaded (/etc/systemd/system/molochcapture.service; disabled; vendor preset: enabled)
   Active: failed (Result: start-limit-hit) since Wed 2020-08-05 12:09:37 UTC; 19s ago
  Process: 25607 ExecStart=/bin/sh -c /data/moloch/bin/moloch-capture -c /data/moloch/etc/config.ini ${OPTIONS} >> /data/moloch/logs/capture.log 2>&1 (code=ex
  Process: 25595 ExecStartPre=/data/moloch/bin/moloch_config_interfaces.sh (code=exited, status=0/SUCCESS)
 Main PID: 25607 (code=exited, status=1/FAILURE)

Aug 05 12:09:37 vg-moloch-01 systemd[1]: molochcapture.service: Main process exited, code=exited, status=1/FAILURE
Aug 05 12:09:37 vg-moloch-01 systemd[1]: molochcapture.service: Unit entered failed state.
Aug 05 12:09:37 vg-moloch-01 systemd[1]: molochcapture.service: Failed with result 'exit-code'.
Aug 05 12:09:37 vg-moloch-01 systemd[1]: molochcapture.service: Service hold-off time over, scheduling restart.
Aug 05 12:09:37 vg-moloch-01 systemd[1]: Stopped Moloch Capture.
Aug 05 12:09:37 vg-moloch-01 systemd[1]: molochcapture.service: Start request repeated too quickly.
Aug 05 12:09:37 vg-moloch-01 systemd[1]: Failed to start Moloch Capture.
Aug 05 12:09:37 vg-moloch-01 systemd[1]: molochcapture.service: Unit entered failed state.
Aug 05 12:09:37 vg-moloch-01 systemd[1]: molochcapture.service: Failed with result 'start-limit-hit'.


$ sudo systemctl start molochviewer.service
$ sudo systemctl status molochviewer.service
● molochviewer.service - Moloch Viewer
   Loaded: loaded (/etc/systemd/system/molochviewer.service; disabled; vendor preset: enabled)
   Active: active (running) since Wed 2020-08-05 12:09:42 UTC; 1min 0s ago
 Main PID: 25616 (sh)
    Tasks: 12
   Memory: 35.8M
      CPU: 1.360s
   CGroup: /system.slice/molochviewer.service
           ├─25616 /bin/sh -c /data/moloch/bin/node viewer.js -c /data/moloch/etc/config.ini  >> /data/moloch/logs/viewer.log 2>&1
           └─25618 /data/moloch/bin/node viewer.js -c /data/moloch/etc/config.ini

Aug 05 12:09:42 vg-moloch-01 systemd[1]: Started Moloch Viewer.


$ sudo tail -n 20 /data/moloch/logs/viewer.log
Express server listening on port 8005 in development mode
Wed, 05 Aug 2020 12:09:50 GMT - GET /eshealth.json 200 455 bytes 29.140 ms
Wed, 05 Aug 2020 12:10:00 GMT - GET /eshealth.json 200 455 bytes 12.440 ms
Wed, 05 Aug 2020 12:10:10 GMT - GET /eshealth.json 200 455 bytes 11.167 ms
Wed, 05 Aug 2020 12:10:20 GMT - GET /eshealth.json 200 455 bytes 9.283 ms
Wed, 05 Aug 2020 12:10:30 GMT - GET /eshealth.json 200 455 bytes 30.133 ms
Wed, 05 Aug 2020 12:10:40 GMT - GET /eshealth.json 200 455 bytes 0.756 ms
Wed, 05 Aug 2020 12:10:50 GMT - GET /eshealth.json 200 455 bytes 6.628 ms
Wed, 05 Aug 2020 12:11:00 GMT - GET /eshealth.json 200 455 bytes 7.309 ms
Wed, 05 Aug 2020 12:11:11 GMT - GET /eshealth.json 200 455 bytes 11.053 ms
Wed, 05 Aug 2020 12:11:21 GMT - GET /eshealth.json 200 455 bytes 6.484 ms
Wed, 05 Aug 2020 12:11:31 GMT - GET /eshealth.json 200 455 bytes 18.125 ms
Wed, 05 Aug 2020 12:11:41 GMT - GET /eshealth.json 200 455 bytes 0.519 ms
Wed, 05 Aug 2020 12:11:51 GMT - GET /eshealth.json 200 455 bytes 11.925 ms
Wed, 05 Aug 2020 12:12:01 GMT - GET /eshealth.json 200 455 bytes 11.021 ms
Wed, 05 Aug 2020 12:12:11 GMT - GET /eshealth.json 200 455 bytes 0.596 ms
Wed, 05 Aug 2020 12:12:21 GMT - GET /eshealth.json 200 455 bytes 20.048 ms

$ sudo tail -n 10 /data/moloch/logs/capture.log
Aug  5 12:09:36 http.c:305 moloch_http_send_sync(): 1/1 SYNC 404 http://localhost:9200/stats/stat/vg-moloch-01 0/71 0ms 1ms
Aug  5 12:09:36 http.c:305 moloch_http_send_sync(): 1/1 SYNC 200 http://localhost:9200/fields/field/_search?size=3000 0/13200 0ms 6ms
Aug  5 12:09:36 config.c:819 moloch_config_monitor_file(): Couldn't stat country file file /data/moloch/etc/GeoLite2-Country.mmdb error No such file or directory
Aug  5 12:09:36 main.c:202 parse_args(): WARNING: gethostname doesn't return a fully qualified name and getdomainname failed, this may cause issues when viewing pcaps, use the --host option - vg-moloch-01
Aug  5 12:09:36 http.c:305 moloch_http_send_sync(): 1/1 SYNC 200 http://localhost:9200/_template/sessions2_template?filter_path=**._meta&include_type_name=true 0/80 4ms 10ms
Aug  5 12:09:36 http.c:305 moloch_http_send_sync(): 1/1 SYNC 200 http://localhost:9200/sequence/sequence/fn-vg-moloch-01 0/123 0ms 28ms
Aug  5 12:09:36 http.c:305 moloch_http_send_sync(): 1/1 SYNC 200 http://localhost:9200/sequence/sequence/fn-vg-moloch-01 2/177 0ms 8ms
Aug  5 12:09:36 http.c:305 moloch_http_send_sync(): 1/1 SYNC 404 http://localhost:9200/stats/stat/vg-moloch-01 0/71 0ms 1ms
Aug  5 12:09:36 http.c:305 moloch_http_send_sync(): 1/1 SYNC 200 http://localhost:9200/fields/field/_search?size=3000 0/13200 0ms 5ms
Aug  5 12:09:36 config.c:819 moloch_config_monitor_file(): Couldn't stat country file file /data/moloch/etc/GeoLite2-Country.mmdb error No such file or directory


$ sudo lsof -i | grep 8005
node     25618        nobody   20u  IPv6  61680      0t0  TCP *:8005 (LISTEN)
node     25618        nobody   30u  IPv6  62609      0t0  TCP vg-moloch-01.local:8005->192.168.16.1:23377 (ESTABLISHED)

$ sudo lsof -i | grep 9200
java     24675 elasticsearch  216u  IPv6  61679      0t0  TCP localhost:9200->localhost:59754 (ESTABLISHED)
java     24675 elasticsearch  217u  IPv6  60036      0t0  TCP localhost:9200 (LISTEN)
java     24675 elasticsearch  218u  IPv6  57865      0t0  TCP localhost:9200 (LISTEN)
java     24675 elasticsearch  242u  IPv6  61130      0t0  TCP localhost:9200->localhost:59756 (ESTABLISHED)
java     24675 elasticsearch  243u  IPv6  61131      0t0  TCP localhost:9200->localhost:59758 (ESTABLISHED)
java     24675 elasticsearch  254u  IPv6  61687      0t0  TCP localhost:9200->localhost:59760 (ESTABLISHED)
java     24675 elasticsearch  255u  IPv6  61688      0t0  TCP localhost:9200->localhost:59762 (ESTABLISHED)
java     24675 elasticsearch  256u  IPv6  61689      0t0  TCP localhost:9200->localhost:59764 (ESTABLISHED)
java     24675 elasticsearch  257u  IPv6  61690      0t0  TCP localhost:9200->localhost:59766 (ESTABLISHED)
java     24675 elasticsearch  258u  IPv6  61691      0t0  TCP localhost:9200->localhost:59768 (ESTABLISHED)
java     24675 elasticsearch  259u  IPv6  61692      0t0  TCP localhost:9200->localhost:59770 (ESTABLISHED)
java     24675 elasticsearch  260u  IPv6  61693      0t0  TCP localhost:9200->localhost:59772 (ESTABLISHED)
node     25618        nobody   19u  IPv4  61678      0t0  TCP localhost:59754->localhost:9200 (ESTABLISHED)
node     25618        nobody   21u  IPv4  61121      0t0  TCP localhost:59756->localhost:9200 (ESTABLISHED)
node     25618        nobody   22u  IPv4  61122      0t0  TCP localhost:59758->localhost:9200 (ESTABLISHED)
node     25618        nobody   23u  IPv4  61123      0t0  TCP localhost:59760->localhost:9200 (ESTABLISHED)
node     25618        nobody   24u  IPv4  61124      0t0  TCP localhost:59762->localhost:9200 (ESTABLISHED)
node     25618        nobody   25u  IPv4  61125      0t0  TCP localhost:59764->localhost:9200 (ESTABLISHED)
node     25618        nobody   26u  IPv4  61126      0t0  TCP localhost:59766->localhost:9200 (ESTABLISHED)
node     25618        nobody   27u  IPv4  61127      0t0  TCP localhost:59768->localhost:9200 (ESTABLISHED)
node     25618        nobody   28u  IPv4  61128      0t0  TCP localhost:59770->localhost:9200 (ESTABLISHED)
node     25618        nobody   29u  IPv4  61129      0t0  TCP localhost:59772->localhost:9200 (ESTABLISHED)

browse 
http://192.168.16.9:8005
http://192.168.16.9:9200/

~~~~
smoketest moloch
~~~~
live capture
$ sudo /data/moloch/bin/./moloch-capture -r ~capture.pcap
index a directory
$ sudo /data/moloch/bin/./moloch-capture -R ~/
~~~~
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

~~~~
Publicly available PCAP files
<https://www.netresec.com/?page=PcapFiles>

SharkFest EUROPE Retrospective
<https://sharkfesteurope.wireshark.org/retrospective>

https://molo.ch/
https://github.com/aol/moloch
~~~~
