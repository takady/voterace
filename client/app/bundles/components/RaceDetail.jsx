import React from 'react';
import PropTypes from 'prop-types';
import RaceDetailContent from './RaceDetailContent';

export default class RaceDetail extends React.Component {
  static propTypes = {
    id: PropTypes.string.isRequired,
  };

  constructor(props) {
    super(props);
    this.state = {data: null};
  }

  componentDidMount() {
    $.ajax({
      url: '/api/races/' + this.props.id + '.json',
      dataType: 'json',
      success: function(result) {
        this.setState({data: result});
      }.bind(this),
      error: function(xhr, status, err) {
        switch (xhr.status) {
          case 401:
            window.location.href = '/signin';
            break;
          case 404:
            window.location.href = '/404.html';
            break;
          case 500:
            window.location.href = '/500.html';
            break;
          default:
            window.location.href = '/500.html';
            console.error('Something went wrong.', status, err.toString());
            break;
        }
      }
    });
  }

  render() {
    if (this.state.data == null) {
      return null;
    }
    return <RaceDetailContent data={this.state.data} deletable={this.state.data.owner} />;
  }
}
