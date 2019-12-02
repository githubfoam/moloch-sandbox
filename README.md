# moloch-sandbox

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
sudo /data/moloch/bin/Configure
sudo /data/moloch/db/db.pl http://localhost:9200 init
npm update
sudo /data/moloch/bin/moloch_add_user.sh admin admin admin123 --admin

sudo systemctl start molochcapture.service
sudo systemctl status molochcapture.service

sudo systemctl start molochviewer.service
sudo systemctl status molochviewer.service

<http://192.168.16.9:8005>
~~~~
~~~~
sudo lsof -i | grep 8005
sudo lsof -i | grep 9200
~~~~
