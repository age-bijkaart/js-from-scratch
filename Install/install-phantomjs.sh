#!/bin/bash
# set -x
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


cat >${src}/phantomjs/content.js <<\EOF
var system = require('system');

var args = system.args;
if (system.args.length == 2) 
  url = system.args[1];
else {
  console.log("usage: phantomjs contents.js url");
  phantom.exit(1);
}

var webPage = require('webpage');
var page = webPage.create();

page.open(url, function (status) { 
  if (status=='success') {
    console.log(page.content); 
    phantom.exit(0); 
  }
  else
    phantom.exit(2);
});
EOF

# Convenience script 
cat >${bin}/phantomjs_get <<\EOF
#!/bin/bash
bin=/usr/local/bin
src=/usr/local/src
[ $# -eq 1 ] || { echo "usage: phantomjs_get url"; exit 1; }
${bin}/phantomjs ${src}/phantomjs/content.js $1
EOF

chmod +x ${bin}/phantomjs_get

# 'phantomjs timing.js url' prints a nice timed trace of page loading
cp timing.js ${src}/phantomjs

# 'phantomjs_time url' will do the same
cat >${bin}/phantomjs_time <<\EOF
#!/bin/bash
bin=/usr/local/bin
src=/usr/local/src
[ $# -eq 1 ] || { echo "usage: phantomjs_time url"; exit 1; }
${bin}/phantomjs ${src}/phantomjs/timing.js $1
EOF

chmod +x ${bin}/phantomjs_time


