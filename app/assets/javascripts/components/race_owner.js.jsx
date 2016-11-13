var RaceOwner = React.createClass({
  propTypes: {
    userName: React.PropTypes.string.isRequired,
    userPageUrl: React.PropTypes.string.isRequired,
    imageUrl: React.PropTypes.string.isRequired
  },

  render: function() {
    return (
      <div className='race-owner'>
        <a href={this.props.userPageUrl}><img className='avatar' src={this.props.imageUrl} alt={this.props.userName} /></a>
        <a className='username' href={this.props.userPageUrl}>{this.props.userName}</a>
      </div>
    );
  }
});
