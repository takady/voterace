var CandidateWithoutChart = React.createClass({
  propTypes: {
    name: React.PropTypes.string.isRequired,
    voteUrl: React.PropTypes.string.isRequired,
    votable: React.PropTypes.bool.isRequired
  },

  render: function() {
    let candidate;

    if (this.props.votable) {
      candidate = (
        <a className='btn btn-default' data-toggle='tooltip' data-placement='right' rel='nofollow' data-method='post' href={this.props.voteUrl} data-original-title='vote!'>
          {this.props.name}
        </a>
      )
    } else {
      candidate = (
        <b>{this.props.name}</b>
      )
    }

    return (
      <div className='candidate'>
        { candidate }
      </div>
    );
  }
});
