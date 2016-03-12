module Usecase
  class CreateReply < BaseUsecase

    def execute(params = {})
      validator.valid?(params[:comment_entity][:reply_entity])
      policy.check
      repo.update(params)
    end

  end
end