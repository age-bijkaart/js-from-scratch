#!/bin/bash
# This is not called pg-install to avoid accidentally calling it using autocompletion.
VERSION=9.5
set -x
# lsb_release prints distribution specific info, at the time
# of writing, lsb_release -cs prints 'xenial', i.e. the name for Ubuntu 16.04
# Do lsb_release -a to see all.
sudo sh -c \
  'echo 
     "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" 
    > /etc/apt/sources.list.d/pgdg.list' &&
sudo apt-get --yes install wget ca-certificates &&
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - &&
sudo apt-get --yes update &&
sudo apt-get --yes upgrade && 
sudo apt-get --yes install postgresql-${VERSION} 
# pgadmin is graphical tool, see https://www.pgadmin.org/index.php
# sudo apt-get install pgadmin3

