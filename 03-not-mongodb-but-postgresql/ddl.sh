#!/bin/bash
# See http://www.meetspaceapp.com/2016/04/12/passwords-postgresql-pgcrypto.html
# for a good and short explanation for the need of pgcrypto.
# set -x

# The name of the linux/postgres user is the same as the name of her
# database.
USER=js
DB=${USER}
PASS=${USER}

# Verify that the ${USER} (and her database) exist, otherwise create
# ${USER} and her DB
X=$(./pg-listusers | grep ${USER} | awk '{print $1;}')
[ "${X}" = ${USER} ]  || ./pg-adduser ${USER} ${PASS} || exit $?

# See
# https://www.postgresql.org/docs/current/static/client-authentication.html
# and /etc/postgresql/9.5/main/pg_hba.conf for figuring out why the
# following does not work.  PGPASSWORD=${USER}-password psql
# --username=${USER} --dbname=${DB}

# However, it seems that we can use 'ident' authentication: first we do
# some 'global' stuff as the postgres 'root' user, which is called
# 'postgres' (and who is also a Linux user, hence the 'sudo'. The 'DROP'
# commands are to make this script idempotent, i.e. executing it twice
# gives the same result: an empty database with an 'account' table set
# up.
sudo -u postgres psql --dbname=${DB}  <<\EOF
  DROP TABLE IF EXISTS account;
  DROP EXTENSION IF EXISTS citext;
  DROP EXTENSION IF EXISTS pgcrypto; 
  CREATE EXTENSION citext; 
  CREATE EXTENSION pgcrypto; 
EOF
[ $? -eq 0 ] || exit 1;
# Finally create the table. SERIAL is what you think it is: you cannot
# insert into it and each new instance gets an incremented id. CITEXT is
# case-insensitive (CI) text.
sudo -u ${USER} psql --dbname=${DB} <<\EOF
  CREATE TABLE account( 
    id SERIAL PRIMARY KEY,
    email CITEXT UNIQUE NOT NULL,
    password TEXT NOT NULL);
EOF

