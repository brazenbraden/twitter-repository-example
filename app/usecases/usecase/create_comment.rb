module Usecase
  class CreateComment < BaseUsecase
    def execute(params)
      validator.valid? params[:comment_entity]
      policy.check
      repo.create(params)
    end

  end
end