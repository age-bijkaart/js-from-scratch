#!/bin/bash
# This is not called pg-uninstall to avoid accidentally calling it using autocompletion.
./pg-stop
pkgs=$(dpkg -l | grep  postgres | awk '{print $2}')
for p in ${pkgs}
do
  sudo apt-get --yes purge ${p} || { echo "ERROR purging ${p}"; exit 1; }
done 
sudo apt autoremove
