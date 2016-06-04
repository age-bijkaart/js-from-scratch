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

This is actually an experiment to see how far I can get with just bash, the venerable
[make](https://www.gnu.org/software/make/manual/make.html) for handling dependencies, and
[npm](https://www.npmjs.com/) to do package management. When reading tutorials on how to build web
apps using e.g. [react](https://facebook.github.io/react/index.html), I was baffled by the usage of
complicated and ad-hoc tools with funny names such as bower, grunt (indeed!), gulp etc. Luckily, I
stumbled on [this post](http://blog.keithcirkel.co.uk/why-we-should-stop-using-grunt/) which makes
similar point and advocates the use of shell scripts and npm, as discussed in a 
[follow-up post](http://blog.keithcirkel.co.uk/how-to-use-npm-as-a-build-tool/).

See also [another post](https://blog.jcoglan.com/2014/02/05/building-javascript-projects-with-make/)
on the subject of using *make* as a build tool for web apps and a concrete [example](https://gist.github.com/jaz303/11098123), albeit a bit too wordy, Makefile.

We'll see how far I get. Up to now, I discovered that piping the output of *Babel*
(the command line version which translates JSX to js) directly (using the efficient unix pipe **|**)
into *Browserify* (which transpiles further to something contemporary browsers can handle) leads to an
**EPIPE** exception, i.e. it does not work. Perhaps because I provided the wrong options, we'll see.

[Step 1](./01-hello-world) The simplest javascript fragment.
