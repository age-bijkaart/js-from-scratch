#!/bin/bash
# From https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-16-04
#
TMPFILE=/tmp/mongod.conf
trap "rm -f ${TMPFILE}" 0 

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" |
  sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt-get update
sudo apt-get install -y --allow-unauthenticated mongodb-org

cat >${TMPFILE} <<EOF
[Unit]
Description=High-performance, schema-free document-oriented database
After=network.target

[Service]
User=mongodb
ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

[Install]
WantedBy=multi-user.target

EOF
# See https://stackoverflow.com/questions/10134901/why-sudo-cat-gives-a-permission-denied-but-sudo-vim-works-fine
cat ${TMPFILE} | sudo tee /etc/systemd/system/mongodb.service >/dev/null

sudo systemctl enable mongodb && sudo systemctl start mongodb &&

cat <<EOF

  The MongoDB instance stores its data files in /var/lib/mongodb
  and its log files in /var/log/mongodb by default, and runs
  using the mongodb user account. You can specify alternate log
  and data file directories in /etc/mongod.conf. 

EOF


