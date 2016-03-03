module Usecase
  class CreateTweet < BaseUsecase
    def execute(params = {})
      policy.check
      validator.valid?(params)
      repo.create(params)
    end
  end
end