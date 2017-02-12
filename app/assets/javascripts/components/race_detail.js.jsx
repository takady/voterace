var RaceDetail = React.createClass({
  propTypes: {
    id: React.PropTypes.string.isRequired
  },
  getInitialState: function() {
    return {data: null};
  },
  componentDidMount: function() {
    $.ajax({
      url: '/api/races/' + this.props.id + '.json',
      dataType: 'json',
      success: function(result) {
        this.setState({data: result});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error('', status, err.toString());
      }.bind(this)
    });
  },
  render: function() {
    if (this.state.data == null) {
      return null;
    }
    return <RaceDetailContent data={this.state.data} deletable={this.state.data.owner} />;
  }
});

var RaceDetailContent = React.createClass({
  propTypes: {
    data: React.PropTypes.object.isRequired,
    deletable: React.PropTypes.bool.isRequired,
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
});

var DeleteButton = React.createClass({
  propTypes: {
    id: React.PropTypes.number.isRequired
  },
  render: function() {
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
});
