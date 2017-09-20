import React from 'react'

const toggleLevels = function(levels, level) {
  if (levels.includes(level)) {
    var index = levels.indexOf(level)
    levels.splice(index, 1)
  } else {
    levels.push(level)
  }

  return levels
}

export default class Filters extends React.Component {
  constructor(props) {
    super(props)

    this.toggleAdvanced = this.toggleAdvanced.bind(this)
    this.toggleIntermediate = this.toggleIntermediate.bind(this)
    this.toggleStarter = this.toggleStarter.bind(this)
  }

  badgeCSS(level) {
    if (this.props.filters.levels.includes(level)) {
      return `badge--${level}`
    } else {
      return 'badge--disabled'
    }
  }

  toggleStarter() {
    this.toggleLevel(1)
  }

  toggleIntermediate() {
    this.toggleLevel(5)
  }

  toggleAdvanced() {
    this.toggleLevel(9)
  }

  toggleLevel(level) {
    var levels = this.props.filters.levels;

    if (levels.includes(level)) {
      var index = levels.indexOf(level)
      levels.splice(index, 1)
    } else {
      levels.push(level)
    }

    this.props.filters.levels = levels;
    this.props.updateFilters(this.props.filters);
  }

  render() {
    return (
      <div className="filter-list">
        <div className="filter-list__filter">
          <h3>Selected Difficulty:</h3>
          <div className="filter-list__filters">
            <span className={`badge ${this.badgeCSS(1)}`} onClick={this.toggleStarter}>starter</span>
            <span className={`badge ${this.badgeCSS(5)}`} onClick={this.toggleIntermediate}>intermediate</span>
            <span className={`badge ${this.badgeCSS(9)}`} onClick={this.toggleAdvanced}>advanced</span>
          </div>
        </div>
      </div>
    );
  }
}
