import React from 'react';
import PropTypes from 'prop-types';
import ReactOnRails from 'react-on-rails';
import CandidateInputForm from "./CandidateInputForm";
import classNames from 'classnames';
import axios from 'axios';

export default class RaceQuickStartForm extends React.Component {
  static propTypes = {
    authenticity_token: PropTypes.string.isRequired,
    avatar_image_url: PropTypes.string.isRequired,
  };

  constructor(props) {
    super(props);
    this.state = {
      title: '',
      candidate_1: '',
      candidate_2: '',
      candidate_3: '',
      candidate_4: '',
      title_has_error: false,
      candidate_1_has_error: false,
      candidate_2_has_error: false,
      candidate_3_has_error: false,
      candidate_4_has_error: false,
    };
    this.handleInputChange = this.handleInputChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleInputChange(event) {
    const target = event.target;
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.name;

    this.setState({[name]: value});
  }

  handleSubmit(event) {
    event.preventDefault();

    let validationError = false;

    if (this.state.title == '') {
      this.setState({title_has_error: true});
      validationError = true;
    } else {
      this.setState({title_has_error: false});
    }

    if (this.state.candidate_1 == '') {
      this.setState({candidate_1_has_error: true});
      validationError = true;
    } else {
      this.setState({candidate_1_has_error: false});
    }

    if (this.state.candidate_2 == '') {
      this.setState({candidate_2_has_error: true});
      validationError = true;
    } else {
      this.setState({candidate_2_has_error: false});
    }

    if (validationError) {
      return;
    }

    axios.post('/api/races', {
      title: this.state.title,
      candidates: [
        this.state.candidate_1,
        this.state.candidate_2,
        this.state.candidate_3,
        this.state.candidate_4,
      ],
      authenticity_token: this.props.authenticity_token,
    }, {
      withCredentials: true,
      headers: {'X-CSRF-TOKEN': ReactOnRails.authenticityToken()}
    })
      .then(() => {
        window.location.href = '/';
      })
      .catch(error => {
        switch (error.response.status) {
        case 400:
          window.location.href = '/';
          break;
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
      <div className="row start-race-box">
        <div className="col-md-1 hidden-xs">
          <img className="avatar" src={this.props.avatar_image_url} alt="" />
        </div>
        <div className="col-md-11">
          <form className="new_race" id="new_race" acceptCharset="UTF-8" onSubmit={this.handleSubmit}>
            <div className={classNames('form-group', {'has-error': this.state.title_has_error})}>
              <input placeholder="New Race Title"
                     autoComplete="off"
                     className="form-control race-title collapsed"
                     data-toggle="collapse"
                     data-target="#form-hidden"
                     aria-expanded="false"
                     type="text"
                     name="title"
                     value={this.state.title}
                     onChange={this.handleInputChange}
              />
            </div>
            <div className="collapse" id="form-hidden" aria-expanded="false">
              <CandidateInputForm
                order={1}
                value={this.state.candidate_1}
                hasError={this.state.candidate_1_has_error}
                onChange={this.handleInputChange}
              />
              <CandidateInputForm
                order={2}
                value={this.state.candidate_2}
                hasError={this.state.candidate_2_has_error}
                onChange={this.handleInputChange}
              />
              <CandidateInputForm
                order={3}
                value={this.state.candidate_3}
                hasError={this.state.candidate_3_has_error}
                onChange={this.handleInputChange}
              />
              <CandidateInputForm
                order={4}
                value={this.state.candidate_4}
                hasError={this.state.candidate_4_has_error}
                onChange={this.handleInputChange}
              />
              <div className="form-group text-right">
                <input type="submit" value="Start race" className="btn btn-primary" />
              </div>
            </div>
          </form>
        </div>
      </div>
    );
  }
}
