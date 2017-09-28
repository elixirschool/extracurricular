import React from 'react';
import Header from './Header';
import Footer from './Footer';
import Filters from './Filters';
import List from './List';

export default class Home extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      filters: {
        levels: [1, 5, 9],
      },
    };

    this.handleFilterChange = this.handleFilterChange.bind(this);
  }

  handleFilterChange(filters) {
    this.setState(prevState => ({
      filters: filters,
    }));
  }

  render() {
    return (
      <div>
        <div>
          <Header />
          <Filters
            filters={this.state.filters}
            updateFilters={this.handleFilterChange}
          />
          <List filters={this.state.filters} />
          <Footer />
        </div>
      </div>
    );
  }
}
