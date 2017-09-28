import React from 'react';

const translated_difficulty = level => {
  switch (level) {
    case 1:
      return 'Starter';
    case 5:
      return 'Intermediate';
    case 9:
      return 'Advanced';
    default:
      return 'Unknown';
  }
};

export default class Opportunity extends React.Component {
  render() {
    const { level, title, project } = this.props.data;

    return (
      <li className="list__item">
        <div className={`opportunity opportunity--${level}`}>
          <header className="opportunity__header">
            <h2 className="opportunity__title">
              <span className="opportunity__project">
                <a href={project.url}>{project.name}</a>
                <span className="opportunity__title-icon">&#9655;</span>
              </span>
              <a href={project.url}>{title}</a>
            </h2>
          </header>
          <div className="opportunity__tags">
            <span className={`badge badge--${level} u-text-lower`}>
              {translated_difficulty(level)}
            </span>
            {project.tags.map(tag => (
              <span key={`${project.id}-${tag}`} className="badge">
                <svg className="badge__icon">
                  <use xlinkHref="#tag-icon" />
                </svg>
                {tag}
              </span>
            ))}
          </div>
        </div>
      </li>
    );
  }
}
