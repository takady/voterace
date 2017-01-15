module Resource
  class Candidate < Base
    delegate :id, :name, :order, to: :model

    def initialize(model, current_user:, voted:)
      super(model, current_user: current_user)

      @voted = voted
    end

    def to_response
      {
        id: id,
        name: name,
        order: order
      }.tap {|response|
        response[:votes_count] = model.votes_count if voted?
      }
    end

    private

    def voted?
      @voted
    end
  end
end
