class RaceOwner extends React.Component {
  render() {
    return (
      <div className='race-owner'>
        <a href={'/' + this.props.userName}><img className='avatar' src={this.props.imageUrl} alt={this.props.userName} /></a>
        <a className='username' href={'/' + this.props.userName}>{this.props.userName}</a>
      </div>
    );
  }
}

RaceOwner.propTypes = {
  userName: React.PropTypes.string.isRequired,
  imageUrl: React.PropTypes.string.isRequired
}
