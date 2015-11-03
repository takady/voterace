module RacesHelper

  def vote_button(race, candidate_code)
    button_label = race.send("candidate_#{candidate_code}")
    button_class = "btn btn-default candidate candidate_#{candidate_code}"

    if voted_candidate = current_user.voted_candidate(race)
      button_label << ": #{race.votes.count_of_candidate(candidate_code)}"
      button_class << ' voted' if candidate_code == voted_candidate
    end

    button_to button_label, races_vote_path(vote: { race_id: race.id, candidate: candidate_code }), class: button_class
  end
end
