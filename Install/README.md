# Scripts and Makefile to install js tools 

Just typing

```
make
```

will install nodejs, npm, mongodb globally, i.e. in /usr/local/bin and friends. You can install
things separately as well, e.g.

```
make mongodb
```

[Phantomjs](http://phantomjs.org/) could be interesting to automate checking that the generated DOM
is according to our expectations. Do

```
make phantomjs
```

to install it. This also installs a convenience script that accesses a url and writes the contents on
stdout, e.g.

```
phantomjs_get "http://127.0.0.1:8080"
```

and another one that produces a timed trace of the loading of a url. E.g.

```
phantomjs_time "http://127.0.0.1:8080"
```

yields

```
     0: http://127.0.0.1:8080: START
     1: http://127.0.0.1:8080: requesting download of http://127.0.0.1:8080/
     1: http://127.0.0.1:8080: loading started
     4: http://127.0.0.1:8080: requesting download of https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react.js
     4: http://127.0.0.1:8080: requesting download of https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react-dom.js
     4: http://127.0.0.1:8080: requesting download of https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.js
     5: http://127.0.0.1:8080/: http://127.0.0.1:8080/ downloaded
   150: http://127.0.0.1:8080/: https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react-dom.js downloaded
   392: http://127.0.0.1:8080/: https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.js downloaded
   579: http://127.0.0.1:8080/: https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react.js downloaded
   579: http://127.0.0.1:8080/: initialized
   675: http://127.0.0.1:8080/: DOMContentLoaded
   705: http://127.0.0.1:8080/: rendering
   721: http://127.0.0.1:8080/: finished loading
   721: http://127.0.0.1:8080/: DONE
   722: http://127.0.0.1:8080/: initialized
   722: http://127.0.0.1:8080/: DOMContentLoaded
   722: about:blank: initialized
   722: about:blank: DOMContentLoaded
```
when as output of `make timing` in the [01-hello-world](https://github.com/age-bijkaart/js-from-scratch/tree/master/01-hello-world).


