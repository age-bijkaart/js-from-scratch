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

