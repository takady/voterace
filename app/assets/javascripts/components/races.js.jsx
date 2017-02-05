var Races = React.createClass({
  propTypes: {
    url: React.PropTypes.string.isRequired
  },
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
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
  },
  render: function() {
    var raceNode = this.state.data.map((race) => {
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
});

var Race = React.createClass({
  propTypes: {
    data: React.PropTypes.object.isRequired
  },
  getInitialState: function() {
    return {data: this.props.data};
  },
  voteFor: function(candidate) {
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
  },
  render: function() {
    return (
      <li className="race">
        <RaceOwner userName={this.state.data.user_name} imageUrl={this.state.data.user_image_url} />
        <div className="race-detail">
          <h2 className="title"><a href="/races/1">{this.state.data.title}</a></h2>
          <Candidates
            data={this.state.data.candidates}
            withChart={this.state.data.voted}
            voteFor={this.voteFor}
          />
        </div>
      </li>
    );
  }
});
