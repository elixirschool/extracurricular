import React from 'react';

export default class Footer extends React.Component {
  render() {
    return (
      <nav className="navbar">
        <a className="navbar__signin" href="/auth/github">
          Sign In <i className="fa fa-github" aria-hidden="true"></i>
        </a>
      </nav>
    );
  }
}
