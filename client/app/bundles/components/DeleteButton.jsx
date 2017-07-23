import axios from 'axios';
import React from 'react';
import PropTypes from 'prop-types';

export default class DeleteButton extends React.Component {
  static propTypes = {
    id: PropTypes.number.isRequired
  };

  constructor(props) {
    super(props);
    this.state = {data: null};
  }

  deleteRace() {
    axios.delete(`/api/races/${this.props.id}`, {
      withCredentials: true,
      headers: {'X-CSRF-TOKEN': ReactOnRails.authenticityToken()}
    })
      .then(() => {
        window.location.href = '/';
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
    return (
      <p>
        <a
          data-confirm="Are you sure?"
          className="btn btn-danger btn-destroy"
          onClick={() => this.deleteRace()}
        >
          <i className="fa fa-trash-o"></i> Delete this race
        </a>
      </p>
    );
  }
}
