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
is quick and to the point in explaining components, rendering, state and the virtual DOM tree (the 
[real DOM tree](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction)
is a hierarchical structure corresponding to the html of the page, it can be accessed and
modified by javascript code running in the browser).


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
is downloaded as a script. [Es2015](https://babeljs.io/docs/learn-es2015/) is a new version of javascript
that is not yet supported by most browsers.

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
 
