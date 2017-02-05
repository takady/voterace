module Resource
  class Candidate < Base
    delegate :id, :name, :order, :votes_count, :most_voted?, :votable?, :voted_by?, to: :model

    def initialize(model, current_user:, voted:)
      super(model, current_user: current_user)

      @voted = voted
    end

    def to_response
      {
        id: id,
        name: name,
        order: order,
        votes_count: voted? ? votes_count : nil,
        most_voted: voted? ? most_voted? : nil,
        votable: votable? && !voted_by?(current_user),
        voted: voted_by?(current_user)
      }
    end

    private

    def voted?
      @voted
    end
  end
end
