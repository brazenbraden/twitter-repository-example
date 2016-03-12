module Usecase
  class CreateTweet < BaseUsecase
    def execute(params = {})
      policy.check
      validator.valid?(params[:tweet_entity])
      repo.create(params)
    end
  end
end