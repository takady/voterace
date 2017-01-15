module Resource
  class Race < Base
    delegate :id, :user_id, :title, to: :model

    def to_response
      {
        id: id,
        user_id: user_id,
        title: title,
        candidates: candidates
      }
    end

    private

    def candidates
      model.candidates.order(:order).map {|candidate|
        Resource::Candidate.new(candidate, current_user: current_user, voted: voted?).to_response
      }
    end

    def voted?
      return false unless current_user

      current_user.voted_for? model
    end
  end
end
