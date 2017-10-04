import React from 'react';
import qs from 'query-string';
import Header from './Header';
import Footer from './Footer';
import Filters from './Filters';
import List from './List';
import Navbar from './Navbar';

export default class Home extends React.Component {
  constructor(props) {
    super(props);

    let levels = []; 
    const query = qs.parse(location.search);

    if(query.levels) {
      levels = query.levels.split(",").map(l => parseInt(l, 10));
    }

    this.state = {
      filters: {
        levels,
      },
    };
  }

  handleFilterChange = filters => {
    this.setState(prevState => ({
      filters: filters,
    }));
  };

  render() {
    return (
      <div>
        <Navbar />
        <Header />
        <Filters
          filters={this.state.filters}
          updateFilters={this.handleFilterChange}
          updateURL={this.props.history.push}
        />
        <List filters={this.state.filters} />
        <Footer />
      </div>
    );
  }
}
