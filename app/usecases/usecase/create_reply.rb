module Usecase
  class CreateReply < BaseUsecase

    def execute(tweet_id, reply_entity)
      validator.valid?(reply_entity.context)
      policy.check
      repo.update(tweet_id, reply_entity.attributes)
    end

  end
end