module Resource
  class Race < Base
    delegate :id, :user, :title, :expired_at, :voted_by?, to: :model

    def to_response
      {
        id: id,
        user_id: user.id,
        user_name: user.username,
        user_image_url: user.image_url,
        user_fullname: user.fullname,
        title: title,
        expired_at: expired_at,
        voted: voted?,
        owner: owner?,
        candidates: candidates
      }
    end

    private

    def candidates
      model.candidates.sort_by(&:order).map {|candidate|
        Resource::Candidate.new(candidate, current_user: current_user, visible: voted?).to_response
      }
    end

    def voted?
      return false unless current_user
      voted_by?(current_user)
    end

    def owner?
      return false unless current_user
      user.id == current_user.id
    end
  end
end
