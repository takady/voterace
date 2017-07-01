module Resource
  class Candidate < Base
    delegate :id, :name, :order, :votes_count, :most_voted?, :votable?, :voted_by?, to: :model

    def initialize(model, current_user:, visible:)
      super(model, current_user: current_user)

      @visible = visible
    end

    def to_response
      {
        id: id,
        name: name,
        order: order,
        votes_count: visible? ? votes_count : nil,
        most_voted: visible? ? most_voted? : nil,
        votable: votable? && !voted?,
        voted: voted?
      }
    end

    private

    def visible?
      @visible
    end

    def voted?
      voted_by?(current_user)
    end
  end
end
