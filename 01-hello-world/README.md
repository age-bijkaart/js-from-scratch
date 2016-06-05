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

It is also possible to do
```
make check
```

which will retrieve the page using firefox and save it as 'test.html' and then compare it to the
expected 'expected.html'. Unfortunately, [wget](https://www.gnu.org/software/wget/) is not
usable to retrieve the page since [wget](https://www.gnu.org/software/wget/) does not interpret
javascript.

Also unfortunately, neither firefox nor chromium provide the ability to retrieve a page and save it,
all from the command line. Fortunately, there is 
[save-page-as](https://github.com/abiyani/automate-save-page-as)
which *small bash script simulates a sequence of key presses which opens a given url in the browser,
save the page (Ctrl+S), and close the browser tab/window (Ctrl+F4)* (from
[save-page-as](https://github.com/abiyani/automate-save-page-as)).

[Save-page-as](https://github.com/abiyani/automate-save-page-as)) depends on
[xdotool](http://www.semicomplete.com/projects/xdotool/) which is available as a ubuntu package:

```
sudo apt-get xdotool
```
and to get the 
[save-page-as](https://github.com/abiyani/automate-save-page-as))
script:
```
wget https://github.com/abiyani/automate-save-page-as/raw/master/save_page_as
chmod +x save_page_as
```

