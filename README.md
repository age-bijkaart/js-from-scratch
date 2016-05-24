# js-from-scratch
Bash, Makefile to install js tools &amp; automate workflow.

A big help to understand many javascript quirks it to quickly see how its
interpreter is single-threaded with a main loop processing events, see
[here](https://developer.mozilla.org/en/docs/Web/JavaScript/EventLoop).

To install a javscript environment that lets you develop web applications, both front and back end, do
the following (all testes on Ubuntu 16.04).

```
cd Install
make
```

This will install nodejs, npm, mongodb globally, i.e. in /usr/local/bin and friends. You can install
things separately as well, e.g.

```
cd Install
make mongodb
```


