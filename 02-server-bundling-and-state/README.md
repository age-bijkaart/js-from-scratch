# Using make to automatically transform `.jsx` files to `.js`

* `make` to transform the source to a single `.js` bundle
* `make test` and point the browser as indicated
* `make clean` to remove all that can be automatically generated

## Using make

In this second-most-simple example app, `.jsx` files are converted to `.js` files on the server, using
`babel` and `make`.

The following `Makefile` fragment ensures that, if needed, `babel` will be installed and the
appropriate presets (`'react'` and `'es2015'`) wil be set in `.babelrc`:
``` makefile
# babel supports (translating) .jsx with the presets mentioned below
$(nbin)/babel:
  npm install --save-dev babel-cli babel-preset-es2015 babel-preset-react 
  echo '{\n  "presets": ["react", "es2015"]\n}' >.babelrc
```

No need to write down the names of the source files: the 2 lines below from the `Makefile` define
variables `$(jsx_files)` and `$(js_files)` containing the source and target (for the `babel`
transformation) file names.
``` makefile
jsx_files := $(shell ls jsx/*.jsx)
js_files := $(jsx_files:jsx/%.jsx=js/%.js)
```

The rule below says that, when a `.jsx` file in the directory `jsx` has been changed, babel needs to
be called on it to (re)create the corresponding `.js` files in the `js` directory.
``` makefile
############# pattern rule to turn jsx into js
js/%.js: jsx/%.jsx 
	babel $< --out-file $@
```

To generate a bundle containing the `js` code and all its dependencies, make will call `browserify`
whenever one or more of the `.js` files has been changed:
``` makefile
build/bundle.js: js $(js_files)
	[ -d build ] || mkdir build 
	browserify --entry js/index.js --outfile $@
```

Note that the above fragments do not depend on the particular project, they can be literally included in any
other react project that wants to translate .jsx to .js on the server side.

## React state

The application illustrates the use of a component state: each `Line` has a state with a single `text`
attribute while the `Log` component state contains both a current `input` string attribute and a `log`
attribute keeping `Line` components for each string that has been typed into the form.

Note how the state is referenced in the `Line` component: `this.props` refers to the state, as shown
below.
``` javascript
var React = require('react');
 
module.exports = React.createClass({
  render: function() {
    return <li>{this.props.text}</li>; 
  }
})
```

The state is specified using appropriately named attributes when the component is created:
``` javascript
var newLine = <Line text={new Date().toLocaleString() +  ": " + this.state.input} />;
```

When the state of a component is mutable, things get slightly more complicated: a `genInitialState`
function should return the initial state of a newly created component:
``` javascript
module.exports = React.createClass({
  getInitialState: function() {
    return { input: '', log: [] };
  },
```

The state should be altered *only* through the `setState` function that takes the new state as its
parameter, as shown in this function of the `Log` component:
``` javascript
  submit: function(ev) { /* see render, Form>>onSubmit */
    ev.preventDefault();
    var newLine = <Line text={new Date().toLocaleString() +  ": " + this.state.input} />;
 
     /* log.unshift(newLine) cannot be used here because state should be treated as immutable, except
      * for calls to setState, see e.g.
      * https://stackoverflow.com/questions/26253351/correct-modification-of-state-arrays-in-reactjs
      * This allows react to implement shouldComponentUpdate() efficiently. Thus we use concat to
      * define the new log in setState
      */
    this.setState({
      input: '', /* clear */
      log: [ newLine ].concat(this.state.log)
    });
  },
```

