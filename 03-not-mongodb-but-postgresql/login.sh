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
N=$(sudo -u ${USER} psql --quiet --tuples-only --dbname=${DB} <<EOF
SELECT count(id) FROM account WHERE email='${EMAIL}' AND
  password = crypt('${PASSWD}', password);
EOF
)
[ "$N" -eq 1 ] || exit 1;
exit 0;
