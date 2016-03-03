module Usecase
  class CreateComment < BaseUsecase
    def execute(tweet_id, comment_entity)
      validator.valid? comment_entity.comment
      policy.check
      repo.update(tweet_id, comment_entity.attributes)
    end

  end
end