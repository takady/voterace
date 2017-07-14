import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
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
    axios.get(this.props.url)
      .then(response => {
        this.setState({data: response.data})
      })
      .catch(error => {
        console.error(error);
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
