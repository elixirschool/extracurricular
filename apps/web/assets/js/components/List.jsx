import React from 'react'
import Opportunity from './Opportunity'
import ReactPaginate from 'react-paginate'

export default class List extends React.Component {
   constructor(props){
    super(props)

    this.state = { entries: [] }
    this.$opportunities(props, this.state.page)

    this.handlePageClick = this.handlePageClick.bind(this)
  } 

  componentWillReceiveProps(nextProps) {
    this.$opportunities(nextProps)
  }

  handlePageClick(page) {
    let next = page.selected + 1
    this.$opportunities(this.props, next)
  }

  $opportunities(props, page) {
    fetch(`/opportunities?levels=${props.filters.levels.join(',')}&page=${page}`, {
      headers: {
        'Content-Type': 'application/json'
      }
    })
    .then(res => res.json())
    .then(json => { 
      this.setState(prevState => json)
      window.scrollTo(0, 0)
    })
  }

  render() {
    return (
      <div>
        <main className="card">
          <ul className="list">
            {this.state.entries.map(opportunity => 
              <Opportunity key={opportunity.id} data={opportunity} /> 
            )}
          </ul>
        </main>
        <nav>
          <ReactPaginate activeClassName={"active"} 
                         breakClassName={"break-me"}
                         breakLabel={<a href="">...</a>}
                         containerClassName={"pagination"}
                         disabledClassName={"invisible"}
                         initialPage={this.state.page_number}
                         marginPagesDisplayed={2}
                         nextClassName={"page-item"}
                         nextLabel={">>"}
                         onPageChange={this.handlePageClick}
                         pageClassName={"page-item"}
                         pageCount={this.state.total_pages}
                         pageLinkClassName={"page-link"}
                         pageRangeDisplayed={5}
                         previousClassName={"page-item"}
                         previousLabel={"<<"}
                         subContainerClassName={"pages pagination"} />
        </nav>
      </div>
    );
  }
}
