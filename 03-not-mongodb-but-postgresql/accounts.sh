#!/bin/bash

USER=js
sudo -u ${USER} psql --quiet --dbname=${DB} <<EOF
SELECT * FROM account 
EOF
