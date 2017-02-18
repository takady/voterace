import React, { PropTypes } from 'react';

export default class DeleteButton extends React.Component {
  static propTypes = {
    id: PropTypes.number.isRequired
  };

  constructor(props) {
    super(props);
    this.state = {data: null};
  }

  render() {
    return (
      <p>
        <a
          data-confirm="Are you sure?"
          className="btn btn-danger btn-destroy"
          rel="nofollow"
          data-method="delete"
          href={'/races/' + this.props.id}
        >
          <i className="fa fa-trash-o"></i> Delete this race
        </a>
      </p>
    );
  }
}
