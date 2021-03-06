import React from 'react';
import PropTypes from 'prop-types';

export default class RaceOwner extends React.Component {
  static propTypes = {
    userName: PropTypes.string.isRequired,
    imageUrl: PropTypes.string.isRequired
  };

  render() {
    return (
      <div className='race-owner'>
        <a href={'/' + this.props.userName}><img className='avatar' src={this.props.imageUrl} alt={this.props.userName} /></a>
        <a className='username' href={'/' + this.props.userName}>{this.props.userName}</a>
      </div>
    );
  }
}
