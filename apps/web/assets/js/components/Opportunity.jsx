import React from 'react';

const translated_difficulty = (level) => {
  var term;

  switch (level) {
    case 1: 
      term = "Starter";
      break;
    case 5:
      term = "Intermediate";
      break;
    case 9:
      term = "Advanced";
      break;
  }

  return term;
}

export default class Opportunity extends React.Component {
  render() {
    return (
      <li className="list__item">
        <div className={`opportunity opportunity--${this.props.data.level}`}>
          <header className="opportunity__header">
            <h2 className="opportunity__title">
              <span className="opportunity__project">
                <a href={this.props.data.project.url}>{this.props.data.project.name}</a> 
                <span className="opportunity__title-icon">&#9655;</span>
              </span>
              <a href={this.props.data.url}>{this.props.data.title}</a> 
            </h2>
          </header>
          <div className="opportunity__tags">
            <span className={`badge badge--${this.props.data.level} u-text-lower`}>
              {translated_difficulty(this.props.data.level)}
            </span>
            {this.props.data.project.tags.map(tag =>
              <span key={`${this.props.data.project.id}-${tag}`} className="badge">
                <svg className="badge__icon"><use xlinkHref="#tag-icon"></use></svg>
                {tag}
              </span>
            )}
          </div>
        </div>
      </li>
    );
  }
}
