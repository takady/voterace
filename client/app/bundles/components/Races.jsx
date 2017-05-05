import React from 'react';
import PropTypes from 'prop-types';
import Race from './Race';

export default class Races extends React.Component {
  static propTypes = {
    url: PropTypes.string.isRequired,
  };

  constructor(props) {
    super(props);
    this.state = {data: []};
  }

  componentDidMount() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function(result) {
        this.setState({data: result});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }

  renderRace(race) {
    return <Race key={race.id} data={race} />;
  }

  render() {
    return (
      <div className="row races">
        <div className="col-md-12">
          <ol className="list-unstyled">
            {this.state.data.map(this.renderRace)}
          </ol>
        </div>
      </div>
    );
  }
}
