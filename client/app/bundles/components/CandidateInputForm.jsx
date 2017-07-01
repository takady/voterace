import React from 'react';
import PropTypes from 'prop-types';
import classNames from 'classnames';

export default class CandidateInputForm extends React.Component {
  static propTypes = {
    order: PropTypes.number.isRequired,
    value: PropTypes.string.isRequired,
    hasError: PropTypes.bool.isRequired,
    errorMessage: PropTypes.string,
    onChange: PropTypes.func.isRequired,
  };

  constructor(props) {
    super(props);
    this.optionalLabel = this.optionalLabel.bind(this);
  }

  optionalLabel() {
    return [1, 2].includes(this.props.order) ? '' : ' (Optional)';
  }

  render() {
    return (
    <div className={classNames('form-group', {'has-error': this.props.hasError})}>
      <input
        placeholder={'Candidate ' + this.props.order + this.optionalLabel()}
        autoComplete="off"
        className="form-control"
        type="text"
        name={'candidate_' + this.props.order}
        value={this.props.value}
        onChange={(event) => this.props.onChange(event)}
      />
    </div>
  );
  }
}
