var CandidateWithChart = React.createClass({
  propTypes: {
    name: React.PropTypes.string.isRequired,
    voteUrl: React.PropTypes.string.isRequired,
    votable: React.PropTypes.bool.isRequired,
    voted: React.PropTypes.bool.isRequired,
    voteRate: React.PropTypes.number.isRequired,
    mostVoted: React.PropTypes.bool.isRequired
  },

  render: function() {
    let candidate;
    let additional_class = '';

    if (this.props.mostVoted) {
      additional_class = ' most-voted'
    }

    if (this.props.voted) {
      candidate = (
        <b>
          {this.props.name}
          <i className='voted fa fa-check-circle-o'></i>
        </b>
      )
    } else if (this.props.votable) {
      candidate = (
        <b>
          <a data-toggle='tooltip' data-placement='right' rel='nofollow' data-method='post' href={this.props.voteUrl} data-original-title='vote!'>
            {this.props.name}
          </a>
        </b>
      )
    } else {
      candidate = (
        <b>{this.props.name}</b>
      )
    }

    return (
      <div className='candidate'>
        <div className={'candidate-chart' + additional_class} style={{width : this.props.voteRate + '%'}}>
          <b className='vote-rate'>{this.props.voteRate}%</b>
          { candidate }
        </div>
      </div>
    );
  }
});
