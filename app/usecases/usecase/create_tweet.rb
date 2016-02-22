module Usecase
  class CreateTweet
    attr_accessor :policy, :repo

    def initialize(policy, repo)
      @policy = policy
      @repo = repo
    end

    def execute(attributes = {})
      @repo.new({tweet: attributes[:tweet]})
    end

  end
end