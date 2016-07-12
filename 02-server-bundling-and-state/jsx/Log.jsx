var React = require('react');
 
var Line = require('./Line');

module.exports = React.createClass({
  getInitialState: function() {
    return { input: '', log: [] };
  },
 
  submit: function(ev) { /* see render, onSubmit */
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
 
  /* called each time the input field changes */
  updateInput: function(ev) {
    this.setState({
      input: ev.target.value
    });
  },
 
 /* Form>input>onChange = updateInput() ensures that state.input always reflects the input text field.
  * Form>onSubmit specifies that this.submit will be called when the button is pressed 
  */ 
  render: function() {
    return <div>
      <form onSubmit={this.submit}>
        <input onChange={this.updateInput} value={this.state.input} type="text" placeholder="Input" />
        <input type="submit" value="Add" />
      </form>
      <h2>Log</h2>
      <ul>{this.state.log}</ul>
    </div>;
  }
});

