module Resource
  class Base
    attr_reader :model, :current_user

    def initialize(model, current_user:)
      @model = model
      @current_user = current_user
    end

    def to_response
      raise NotImplementedError
    end
  end
end
