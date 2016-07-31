#!/bin/bash
# See
# http://www.meetspaceapp.com/2016/04/12/passwords-postgresql-pgcrypto.html
# for a good and short explanation.
USAGE="$0 email password"
[ $# -eq 2 ] || { echo "$USAGE"; exit 1; }
# set -x
USER=js
EMAIL=$1
PASSWD=$2;
X=$( { sudo -u ${USER} psql --quiet --dbname=${DB} <<EOF
  INSERT INTO account (email, password) VALUES
    ('${EMAIL}', crypt('${PASSWD}', gen_salt('bf', 8)));
EOF
} 2>&1 )
echo ${X} | grep ERROR >/dev/null  && exit 1
exit 0

