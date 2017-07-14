import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import ReactOnRails from 'react-on-rails';
import Candidates from './Candidates';
import DeleteButton from './DeleteButton';

export default class RaceDetailContent extends React.Component {
  static propTypes = {
    data: PropTypes.object.isRequired,
    deletable: PropTypes.bool.isRequired,
  };

  constructor(props) {
    super(props);
    this.state = {data: this.props.data};
    this.voteFor = this.voteFor.bind(this);
  }

  voteFor(candidate) {
    axios.post(`/api/candidates/${candidate.id}/vote`, null, {
      withCredentials: true,
      headers: {'X-CSRF-TOKEN': ReactOnRails.authenticityToken()}
    })
      .then(response => {
        this.setState({data: response.data});
      })
      .catch(error => {
        switch (error.response.status) {
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
          console.error(error);
          break;
        }
      });
  }

  render() {
    let delete_button = null;
    if (this.props.deletable) {
      delete_button = <DeleteButton id={this.props.data.id} />;
    }
    return (
    <div className="row">
      <div className="race-permalink col-md-12">
        <div className="race-owner">
          <a href={'/' + this.state.data.user_name}>
            <img className="avatar" src={this.state.data.user_image_url} alt={this.state.data.user_name} />
            <strong className="fullname">{this.state.data.user_fullname}</strong>
          </a>
          <span className="username">{'@' + this.state.data.user_name}</span>
        </div>
        <h1>{this.state.data.title}</h1>
        <Candidates
          data={this.state.data.candidates}
          withChart={this.state.data.voted}
          voteFor={this.voteFor}
        />
        <p>
          <b><i className="fa fa-clock-o"></i> expire at </b>{this.state.data.expired_at}
        </p>
        {delete_button}
      </div>
    </div>
    );
  }
}
