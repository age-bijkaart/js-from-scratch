// Show some timing results for loading a url with phantomjs

var args = require('system').args;
// Apparently, args[0] is timing.hs,  hence, args[1] is the url to load
if (args.length == 2) 
  var url = args[1];
else {
  console.log("usage: phantomjs timing.js url");
  phantom.exit(1);
}

var page = require('webpage').create();

/* Utility function: padleft('12',5,'0') = '00012' */
function padLeft(str, total_size, padchar) { 
  return str.length >= total_size ? str : padLeft(padchar + str, total_size, padchar );
}

/* Return the number of milliseconds since the first call to now() */
function now() {
  if (now.init_t == null)
    now.init_t = Date.now();
  return (Date.now() - now.init_t);
};

/* All console output comes here. If the url argument is missing, page.url is used. */
page.message = function(msg, url) { 
  if (url == null)
    url = page.url;
  console.log(padLeft(now(),6,' ') + ': ' + url +': ' + msg);
}

/* Calls to console 'from within the page' are redirected to this function.
 * See http://phantomjs.org/api/webpage/handler/on-console-message.html */
page.onConsoleMessage = function(msg, lineNum, sourceId) { 
  page.message(msg);
};

/* Callback defined in http://phantomjs.org/api/webpage/handler/on-initialized.html */
page.onInitialized = function() {
    page.message('initialized');
    // Catch 'DOMContenLoaded events, console.log() will redirect to page.onConsoleMessage() etc. 
    page.evaluate(function() {
       document.addEventListener('DOMContentLoaded', function() {
          console.log('DOMContentLoaded');
          }, false); 
    });
};

/* Callback defined in http://phantomjs.org/api/webpage/handler/on-resource-requested.html */
page.onResourceRequested = function(requestData) {
  page.message('requesting download of ' + requestData.url, url);
};

/* Callback defined in http://phantomjs.org/api/webpage/handler/on-resource-received.html
 * Only the cases that satisfy the condition below correspond to the end of the download of the resource.
 */
page.onResourceReceived = function(response) {
  if ((response.stage = 'end') && (! response.hasOwnProperty('bodySize'))) 
    page.message(response.url + ' downloaded');
};

/* Callback defined in http://phantomjs.org/api/webpage/handler/on-load-started.html, called when 'the
 * page starts loading' */
page.onLoadStarted = function(status) { 
  page.message('loading started', url);
};

/* Callback defined in http://phantomjs.org/api/webpage/handler/on-load-finished.html, called when
 * 'the page finishes loading'. */
page.onLoadFinished = function(status) { 
  page.message('finished loading');
};
 
      
page.message('START', url);

/* See http://phantomjs.org/api/webpage/method/open.html, equivalent of loading a page in a browser. */
page.open(url, function (status) { 
  if (status=='success') {
    page.message('DONE');
    phantom.exit(0); 
  }
  else {
    page.message('ERROR', url);
    phantom.exit(2);
  }
});

