import React, { PropTypes } from 'react';

export default class Candidate extends React.Component {
  static propTypes = {
    data: React.PropTypes.object.isRequired,
    onClick: React.PropTypes.func.isRequired,
    withChart: React.PropTypes.bool.isRequired,
    voteRate: React.PropTypes.number.isRequired
  };

  render() {
    let candidate;

    if (this.props.data.voted) {
      candidate = (
        <b>
          {this.props.data.name}
          <i className='voted fa fa-check-circle-o'></i>
        </b>
      )
    } else if (this.props.data.votable) {
      candidate = (
        <b>
          <a
            href='javascript:void(0)'
            onClick={() => this.props.onClick()}
            data-toggle='tooltip'
            data-placement='right'
            rel='nofollow'
            data-original-title='vote!'
          >
            {this.props.data.name}
          </a>
        </b>
      )
    } else {
      candidate = (
        <b>{this.props.data.name}</b>
      )
    }

    if (this.props.withChart) {
      const vote_rate = Math.round(this.props.voteRate * 100);
      const additional_class = this.props.data.most_voted ? ' most-voted' : '';
      candidate = (
        <div className={'candidate-chart' + additional_class} style={{width : vote_rate + '%'}}>
          <b className='vote-rate'>{vote_rate}%</b>
          {candidate}
        </div>
      );
    }

    return (
      <div className='candidate'>
        {candidate}
      </div>
    );
  }
}
