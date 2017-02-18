import React, { PropTypes } from 'react';
import Candidate from './Candidate';

export default class Candidates extends React.Component {
  static propTypes = {
    data: React.PropTypes.array.isRequired,
    withChart: React.PropTypes.bool.isRequired,
    voteFor: React.PropTypes.func.isRequired
  };

  constructor(props) {
    super(props);
    this.renderCandidate = this.renderCandidate.bind(this);
  }

  totalVotesCount(candidates) {
    const total_votes = candidates.reduce((a, b) => ({votes_count: a.votes_count + b.votes_count}));
    return total_votes.votes_count;
  }

  renderCandidate(candidate) {
    let vote_rate = 0;
    if (this.props.withChart) {
      vote_rate = candidate.votes_count / this.totalVotesCount(this.props.data);
    }
    return (
      <Candidate
        key={candidate.id}
        data={candidate}
        onClick={() => this.props.voteFor(candidate)}
        withChart={this.props.withChart}
        voteRate={vote_rate}
      />
    );
  }

  render() {
    return (
      <div className="candidates">
        {this.props.data.map(this.renderCandidate)}
      </div>
    );
  }
}
