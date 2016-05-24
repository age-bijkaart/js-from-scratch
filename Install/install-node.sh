#!/bin/bash
#set -x
SYS=linux-x64
ME=$(whoami)
INSTALLED_VERSION=$(which node >/dev/null && node -v || echo 'NONE')
echo "### node.js installed version = ${INSTALLED_VERSION}"

NEW_VERSION=$(./nodejs-latest-version)
echo "### node.js new version = ${NEW_VERSION}"

NODE_IS_CURRENT=$([ "${NEW_VERSION}" = "${INSTALLED_VERSION}" ] && echo "yes" || echo "" )
# echo "NODE_IS_CURRENT=${NODE_IS_CURRENT=}"

if [ "${NODE_IS_CURRENT}" ] 
then
  echo "installed node.js ${INSTALLED_VERSION} is current"; 
else
  echo "installing new version ${NEW_VERSION}"
  # DIR="node-${NEW_VERSION}-${SYS}"
  DIR="node-${NEW_VERSION}"
  rm -fr ${DIR}
  TAR="${DIR}.tar.xz"
  rm -fr ${TAR}*
  URL="https://nodejs.org/dist/${NEW_VERSION}/${TAR}"
  echo "wget ${URL} => ${TAR}"
  wget ${URL} &&
    echo "tar ${TAR} => ${DIR}" &&
    tar xf ${TAR} &&
    echo "cd ${DIR} && make" &&
    cd ${DIR} && ./configure && make && make test && sudo make install &&
    sudo chown -R ${ME}:${ME} /usr/local
fi
