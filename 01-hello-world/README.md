# The simplest React example 

The javascript code to show 'Hello world' using a React component is embedded in index.html.

```
<!DOCTYPE html>
<html>
  <head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react-dom.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.js"></script>
  </head>
  <body>
    <div id="app"></div>
    <script type="text/babel">
     var Chat = React.createClass({
       render: function() {
         return <h1>Hello world!</h1>;
       } 
     });

     ReactDOM.render( <Chat />, document.getElementById('app'));
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
```
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.14.6/react-dom.js"></script>
```
also the babel stuff
```
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.23/browser.js"></script>
```
is downloaded.

Note the type attribute in 

```
<script type="text/babel">
```

which tells the browser to use babel first and then execute the result of the transpilation (a
[transpiler](https://en.wikipedia.org/wiki/Source-to-source_compiler)  
is a source to source compiler).

# To test

```
make
```
will start [http-server](https://www.npmjs.com/package/http-server). Point your browser to the indicated url.

If you installed [Phantomjs](http://phantomjs.org/) along with the [phantomjs_get](https://github.com/age-bijkaart/js-from-scratch/tree/master/Install) script, it is also possible
to do

```
make check && echo "OK"
```

which will start http-server in the background, retrieve the page using *phantomjs_get* and 
save it as 'test.html' and finally compare it to the
expected 'correct-response.html'. 

Here is what *phantomjs_get* retrieves. 

```
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
         return <h1>Hello world!</h1>;
       } 
     });

     ReactDOM.render( <Hello />, document.getElementById('app'));
    </script>
  

</body></html>
```

Note how the Hello instance has been rendered as a
`<h1>` node under the `<div id="app">` node, exactly as prescrived by the javascript line
```
ReactDOM.render( <Hello />, document.getElementById('app'));`.
```

