var ReactDOM = require('react-dom');
var React = require('react');

// React is used here through jsx
// Babel will translate <Log/> to stuff needing React
var Log = require('./Log');
 
ReactDOM.render(
    <div> 
      <h1>Logger</h1> 
      <Log />
    </div>, 
    document.getElementById('app')
);
