# js-from-scratch

A big help to understand many javascript quirks it to understand how its
interpreter is single-threaded with a main loop processing events, see
[here](https://developer.mozilla.org/en/docs/Web/JavaScript/EventLoop).

See [Install](./Install) for a Makefile that installs a javascript environment
that lets you develop web applications, both front and back end.

This is actually an experiment to see how far I can get with just bash, the venerable
[make](https://www.gnu.org/software/make/manual/make.html) for handling dependencies, and
[npm](https://www.npmjs.com/) to do package management. 

When reading tutorials on how to build web
apps using e.g. [react](https://facebook.github.io/react/index.html), I was baffled by the usage of
complicated and ad-hoc tools with funny names such as bower, grunt (indeed!), gulp etc. Luckily, I
stumbled on [this post](http://blog.keithcirkel.co.uk/why-we-should-stop-using-grunt/) which makes
similar point and advocates the use of shell scripts and npm, as discussed in a 
[follow-up post](http://blog.keithcirkel.co.uk/how-to-use-npm-as-a-build-tool/).

See also [another post](https://blog.jcoglan.com/2014/02/05/building-javascript-projects-with-make/)
on the subject of using *make* as a build tool for web apps and a concrete [example](https://gist.github.com/jaz303/11098123), albeit a bit too wordy, Makefile.

We'll see how far this gets.

[Step 0](./Install) Installing tools
[Step 1](./01-hello-world) The simplest React javascript fragment.

