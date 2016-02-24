module Usecase
  class CreateTweet
    attr_reader :policy, :repo

    def initialize(policy, repo)
      @policy = policy
      @repo = repo
    end

    def execute(params = {})
      policy.check
      repo.create(params)
    end

  end
end