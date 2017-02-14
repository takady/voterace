class RaceDetail extends React.Component {
  constructor(props) {
    super(props);
    this.state = {data: null};
  }

  componentDidMount() {
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
  }

  render() {
    if (this.state.data == null) {
      return null;
    }
    return <RaceDetailContent data={this.state.data} deletable={this.state.data.owner} />;
  }
}

RaceDetail.propTypes = {
  id: React.PropTypes.string.isRequired
}

class RaceDetailContent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {data: this.props.data};
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
}

RaceDetailContent.propTypes = {
  data: React.PropTypes.object.isRequired,
  deletable: React.PropTypes.bool.isRequired,
}

class DeleteButton extends React.Component {
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

DeleteButton.propTypes = {
  id: React.PropTypes.number.isRequired
}
