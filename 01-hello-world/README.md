# The simplest React example 

The javascript code to show 'Hello world' using a React component is embedded in index.html.

``` html
<!DOCTYPE html>
<html>
  <head>
    <title>helloworld</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react-dom.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.js"></script>
  </head>
  <body>
    <div id="app"></div>
    <script type="text/babel">
     var Hello = React.createClass({
       render: function() {
         console.log('rendering');
         return <h1>Hello world!</h1>;
       } 
     });

     ReactDOM.render( <Hello />, document.getElementById('app'));
    </script>
  </body>
</html>
```

If you know nothing about React but a bit about javascript, 
[this](http://www.jackcallister.com/2015/01/05/the-react-quick-start-guide.html) tutorial 
is quick and to the point in explaining components, rendering, state and the virtual DOM tree. 
The [real DOM tree](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction)
is a tree structure corresponding to the html of the page, it can be accessed and
modified by javascript code running in the browser. One of the advantages of using React to do this
is that it minimizes actual changes
since React diffs the virtual and real DOM and only makes changes that are necessary to sync  the real and virtual DOM, making the app look snappier on the screen.

[Es2015](https://babeljs.io/docs/learn-es2015/) is a new version of javascript
that is not yet supported by most browsers.

The translation of the React and Es2015 constructs is done by the browser. That is why, next to the
react scripts
``` html
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react-dom.js"></script>
```
also the babel stuff
``` html
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.js"></script>
```
is downloaded.

Note the type attribute in 

``` html
<script type="text/babel">
```

which tells the browser to use babel first and then execute the result of the transpilation (a
[transpiler](https://en.wikipedia.org/wiki/Source-to-source_compiler)  
is a source to source compiler).

# To test

``` bash
make
```
will start [http-server](https://www.npmjs.com/package/http-server). Point your browser to the indicated url.

If you installed [Phantomjs](http://phantomjs.org/) along with the [phantomjs_get](https://github.com/age-bijkaart/js-from-scratch/tree/master/Install) script, it is also possible
to do

``` bash
make check && echo "OK"
```

which will start `http-server` in the background, retrieve the page using `phantomjs_get` and 
save it as `test.html` and finally compare it to the
expected `correct-response.html`. 

Here is what `phantomjs_get` retrieves. 

``` html
<!DOCTYPE html><html><head>
    <title>helloworld</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react-dom.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.js"></script>
  </head>
  <body>
    <div id="app"><h1 data-reactid=".0">Hello world!</h1></div>
    <script type="text/babel">
     var Hello = React.createClass({
       render: function() {
         console.log('rendering');
         return <h1>Hello world!</h1>;
       } 
     });

     ReactDOM.render( <Hello />, document.getElementById('app'));
    </script>
  

</body></html>
```

Note how the Hello instance has been rendered as a
`<h1>` node under the `<div id="app">` node, exactly as prescribed by the javascript line
``` javascript
ReactDOM.render( <Hello />, document.getElementById('app'));`.
```
The trace output from the line
``` javascript
console.log('rendering');
```
can be seen in the output of
``` bash
make timing
```
which also illustrates that it takes rather a long time to bring up the page, but that the time needed
by react to do the actual rendering is a negligible part of the total. 

Here is the output:
```
     0: http://127.0.0.1:8080: START
     0: http://127.0.0.1:8080: requesting download of http://127.0.0.1:8080/
     1: http://127.0.0.1:8080: loading started
     4: http://127.0.0.1:8080: requesting download of https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react.js
     4: http://127.0.0.1:8080: requesting download of https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react-dom.js
     4: http://127.0.0.1:8080: requesting download of https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.js
     4: http://127.0.0.1:8080/: http://127.0.0.1:8080/ downloaded
   131: http://127.0.0.1:8080/: https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react-dom.js downloaded
   349: http://127.0.0.1:8080/: https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.js downloaded
   362: http://127.0.0.1:8080/: https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react.js downloaded
   363: http://127.0.0.1:8080/: initialized
   462: http://127.0.0.1:8080/: DOMContentLoaded
   492: http://127.0.0.1:8080/: rendering
   508: http://127.0.0.1:8080/: finished loading
   508: http://127.0.0.1:8080/: DONE
   509: http://127.0.0.1:8080/: initialized
   509: http://127.0.0.1:8080/: DOMContentLoaded
   509: about:blank: initialized
   509: about:blank: DOMContentLoaded
```

