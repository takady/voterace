import React from 'react';
import PropTypes from 'prop-types';

export default class RaceCreateForm extends React.Component {
  static propTypes = {
    authenticity_token: PropTypes.string.isRequired,
    avatar_image_url: PropTypes.string.isRequired,
  };

  constructor(props) {
    super(props);
    this.state = {title: '', candidate_1: '', candidate_2: '', candidate_3: '', candidate_4: ''};
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

    $.ajax({
      url: '/api/races',
      dataType: 'json',
      type: 'POST',
      data: {
        title: this.state.title,
        candidates: [
          this.state.candidate_1,
          this.state.candidate_2,
          this.state.candidate_3,
          this.state.candidate_4,
        ],
        authenticity_token: this.props.authenticity_token,
      },
      success: function() {
        window.location.href = '/';
      }.bind(this),
      error: function(xhr, status, err) {
        switch (xhr.status) {
        case 400:
          console.error('Invalid.', status, xhr.responseJSON);
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
          console.error('Something went wrong.', status, err.toString());
          break;
        }
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
            <div className="form-group">
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
              <div className="form-group">
                <input placeholder="Candidate 1" autoComplete="off" className="form-control" type="text" name="candidate_1" value={this.state.candidate_1} onChange={this.handleInputChange} />
                <input placeholder="Candidate 2" autoComplete="off" className="form-control" type="text" name="candidate_2" value={this.state.candidate_2} onChange={this.handleInputChange} />
                <input placeholder="Candidate 3 (Optional)" autoComplete="off" className="form-control" type="text" name="candidate_3" value={this.state.candidate_3} onChange={this.handleInputChange} />
                <input placeholder="Candidate 4 (Optional)" autoComplete="off" className="form-control" type="text" name="candidate_4" value={this.state.candidate_4} onChange={this.handleInputChange} />
              </div>
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
