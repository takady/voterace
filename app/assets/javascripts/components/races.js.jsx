class Races extends React.Component {
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

  render() {
    const raceNode = this.state.data.map((race) => {
      return (
        <Race key={race.id} data={race} />
      );
    });
    return (
      <div className="row races">
        <div className="col-md-12">
          <ol className="list-unstyled">
            {raceNode}
          </ol>
        </div>
      </div>
    );
  }
}

Races.propTypes = {
  url: React.PropTypes.string.isRequired
};

class Race extends React.Component {
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
        console.error('candidate', status, err.toString());
      }.bind(this)
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

Race.propTypes = {
  data: React.PropTypes.object.isRequired
};
