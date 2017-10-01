import React from 'react';

const updateLevels = (levels, level) => {
  if (levels.includes(level)) {
    // If the selected level is already present, filter it out and return the new array
    return levels.filter(v => v !== level);
  }

  // Otherwise, concat the new level on to the old ones
  return [...levels, level];
}

export default class Filters extends React.Component {
  constructor(props) {
    super(props);
  }
  badgeCSS(level) {
    if (this.props.filters.levels.includes(level)) {
      return `badge--${level}`;
    } else {
      return 'badge--disabled';
    }
  }

  toggleStarter = () => {
    this.toggleLevel(1);
  }

  toggleIntermediate = () => {
    this.toggleLevel(5);
  }

  toggleAdvanced = () => {
    this.toggleLevel(9);
  }

  toggleLevel(level) {
    const filters = this.props.filters;
    // Create a new filters object by merging the levels array into the rest of the filters
    const newFilters = Object.assign(
      {},
      filters,
      { levels: updateLevels(filters.levels, level) }
    );

    this.props.updateFilters(newFilters);
  }

  render() {
    return (
      <div className="filter-list">
        <div className="filter-list__filter">
          <h3>Selected Difficulty:</h3>
          <div className="filter-list__filters">
            <span
              className={`badge ${this.badgeCSS(1)}`}
              onClick={this.toggleStarter}
            >
              starter
            </span>
            <span
              className={`badge ${this.badgeCSS(5)}`}
              onClick={this.toggleIntermediate}
            >
              intermediate
            </span>
            <span
              className={`badge ${this.badgeCSS(9)}`}
              onClick={this.toggleAdvanced}
            >
              advanced
            </span>
          </div>
        </div>
      </div>
    );
  }
}
