#!/bin/bash
usage="$0 name linux-passwd"
[ $# -eq 2 ] || { echo ${usage}; exit 1; }
set -x
# 1. Add linux user
sudo useradd $1 &&
sudo chpasswd <<EOF
$1:$2
EOF
# 2. Add corresponding postgres user
# 3. Add database with the same name as the user
[ $? -eq 0 ] &&
sudo -u postgres createuser --createdb $1 &&
sudo -u $1 createdb $1

