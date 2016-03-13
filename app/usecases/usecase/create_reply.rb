module Usecase
  class CreateReply < BaseUsecase

    def execute(params = {})
      validator.valid?(params[:reply_entity])
      policy.check
      repo.create(params)
    end

  end
end