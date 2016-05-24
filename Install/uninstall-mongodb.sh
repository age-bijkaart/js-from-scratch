#!/bin/bash
usage="uninstall-mongodb [-f] -- -f will remove data & log"
echo "usage: ${usage}"
set -x
[ $# -eq 1 ] && [ "$1"='-f' ] && sudo rm -fr /var/lib/mongodb /var/log/mongodb
sudo systemctl stop mongodb || echo "mongodb was not running?"
sudo apt-get -y remove mongodb-org
sudo apt-get -y autoremove 
sudo rm -f /etc/systemd/system/mongodb.service /etc/systemd/system/multi-user.target.wants/mongodb.service
sudo userdel -f mongodb
sudo groupdel mongodb
