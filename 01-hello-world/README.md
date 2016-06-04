# The simplest React example 

The javascript code to show 'Hello world' using a React component is embedded in index.html.

If you know nothing about React but a bit about javascript, 
[this](http://www.jackcallister.com/2015/01/05/the-react-quick-start-guide.html) tutorial 
is quick and to the point in explaining components, rendering, state and the virtual DOM tree (the DOM
tree is a hierarchical structure corresponding to the html of the page, it can be accessed and
modified by javascript code running in the browser).


The translation of the React and es2015 is done by the browser. That is why the babel stuff is
downloaded as a script as well. Es2015 is a new version of javascript that is not yet supported by
most browsers. Note the type attribute in <script type="text/babel"> which tells the browser to use
babel first and then execute the result of the transpilation (a 'transpiler' is a 'source to source'
compiler).



