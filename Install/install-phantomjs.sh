#!/bin/bash
set -x
#
# PhantomJS is a headless WebKit scriptable with a JavaScript API
# We use it to retrieve the DOM (after javascript processing)
# corresponding to a url and compare it with an expected version.
#
# Update this to newer version if appropriate
phantom_version=phantomjs-2.1.1-linux-x86_64
archive=${phantom_version}.tar.bz2
# Where a link to the binary will live
bin=/usr/local/bin
# Where the phantomjs download and 'content.js' will live
src=/usr/local/src
#
rm -fr ${src}/${phantom_version}
rm -fr ${src}/phantomjs
rm -f ${bin}/phantomjs
[ -f ${src}/${archive} ] ||
  wget --directory-prefix ${src} https://bitbucket.org/ariya/phantomjs/downloads/${archive} &&
  tar -C ${src} -xjf ${src}/${archive} || exit 1;
ln -s ${src}/${phantom_version}/bin/phantomjs ${bin}/phantomjs && 
  ln -s ${src}/${phantom_version} ${src}/phantomjs || exit 1;


# 'phantomjs_get url' prints the contents of the url
# 'phantomjs_time url' prints a nice timed trace of page loading
cp phantomjs_get phantomjs_time  ${bin}
chmod +x ${bin}/phantomjs_get ${bin}/phantomjs_time


