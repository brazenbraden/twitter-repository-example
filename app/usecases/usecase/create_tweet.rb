module Usecase
  class CreateTweet < BaseUsecase

    # def initialize(policy, repo, validator)
    #   @policy = policy
    #   @repo = repo
    #   @validator = validator
    # end

    def execute(params = {})
      policy.check
      validator.valid?(params)
      repo.create(params)
    end

    # private
    # attr_reader :policy, :repo, :validator
  end
end