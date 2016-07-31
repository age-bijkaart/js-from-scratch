#!/bin/bash
usage="$0 postgres-user-name"
[ $# -eq 1 ] || { echo ${usage}; exit 1; }
set -x
# 1. Remove database with that name, if any
sudo -u postgres dropdb $1 || { echo "no database called $1"; }
# 2. Remove postgres user
sudo -u postgres dropuser $1 || { echo "no postgresql user called $1?"; }
sudo userdel $1 || { echo "no Linux user called $1?"; }
