var CandidateWithChart = React.createClass({
  propTypes: {
    name: React.PropTypes.string.isRequired,
    voteUrl: React.PropTypes.string.isRequired,
    voteRate: React.PropTypes.number.isRequired,
    votable: React.PropTypes.bool.isRequired,
    mostVoted: React.PropTypes.bool.isRequired
  },

  render: function() {
    let chart;

    if (this.props.mostVoted) {
      chart = (
        <div className='candidate-chart most-voted' style={{width : this.props.voteRate + '%'}}>
          <b className='vote-rate'>{this.props.voteRate}%</b>
          {this.props.name}
          <i className='voted fa fa-check-circle-o'></i>
        </div>
      )
    } else if (this.props.votable) {
      chart = (
        <div className='candidate-chart' style={{width : this.props.voteRate + '%'}}>
          <b className='vote-rate'>{this.props.voteRate}%</b>
          <b>
            <a data-toggle='tooltip' data-placement='right' rel='nofollow' data-method='post' href={this.props.voteUrl} data-original-title='vote!'>
              {this.props.name}
            </a>
          </b>
        </div>
      )
    } else {
      chart = (
        <div className='candidate-chart' style={{width : this.props.voteRate + '%'}}>
          <b className='vote-rate'>{this.props.voteRate}%</b>
          <b>{this.props.name}</b>
        </div>
      )
    }

    return (
      <div className='candidate'>
        { chart }
      </div>
    );
  }
});
