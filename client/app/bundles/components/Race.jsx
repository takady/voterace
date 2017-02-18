import React, { PropTypes } from 'react';
import RaceOwner from './RaceOwner';
import Candidates from './Candidates';

export default class Race extends React.Component {
  static propTypes = {
    data: PropTypes.object.isRequired,
  };

  constructor(props) {
    super(props);
    this.state = {data: props.data};
    this.voteFor = this.voteFor.bind(this);
  }

  voteFor(candidate) {
    $.ajax({
      url: '/api/candidates/' + candidate.id + '/vote',
      dataType: 'json',
      type: 'POST',
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
    return (
      <li className="race">
        <RaceOwner userName={this.state.data.user_name} imageUrl={this.state.data.user_image_url} />
        <div className="race-detail">
          <h2 className="title"><a href={'/races/' + this.state.data.id}>{this.state.data.title}</a></h2>
          <Candidates
            data={this.state.data.candidates}
            withChart={this.state.data.voted}
            voteFor={this.voteFor}
          />
        </div>
      </li>
    );
  }
}
