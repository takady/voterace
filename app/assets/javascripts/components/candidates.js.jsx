class Candidates extends React.Component {
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

Candidates.propTypes = {
  data: React.PropTypes.array.isRequired,
  withChart: React.PropTypes.bool.isRequired,
  voteFor: React.PropTypes.func.isRequired
};

class Candidate extends React.Component {
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

Candidate.propTypes = {
  data: React.PropTypes.object.isRequired,
  onClick: React.PropTypes.func.isRequired,
  withChart: React.PropTypes.bool.isRequired,
  voteRate: React.PropTypes.number.isRequired
}
