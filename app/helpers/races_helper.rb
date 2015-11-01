module RacesHelper

  def vote_button(race, candidate_code)
    candidate = race.send("candidate_#{candidate_code}")
    btn_class = candidate_code == 1 ? 'btn btn-danger' : 'btn btn-primary'

    button_label = candidate
    button_label << ": #{race.votes.count_of_candidate(candidate_code)}" if race.voted_by?(current_user)

    button_to button_label, races_vote_path(vote: { race_id: race.id, candidate: candidate_code }), class: btn_class
  end
end
