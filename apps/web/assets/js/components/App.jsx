import React from 'react';
import Home from './Home';
import { BrowserRouter as Router, Route } from 'react-router-dom';

export default class App extends React.Component {
  render() {
    return (
      <Router>
        <Route to="/" exact={true} component={Home} />
      </Router>
    );
  }
}
