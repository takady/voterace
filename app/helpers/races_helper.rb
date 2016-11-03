module RacesHelper
  def candidate_label(candidate)
    optional = ' (Optional)' unless candidate.required_order?

    "Candidate #{candidate.order}#{optional}"
  end
end
