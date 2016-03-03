class BaseUsecase
  def initialize(policy, repo, validator)
    @policy = policy
    @repo = repo
    @validator = validator
  end

  private
  attr_reader :policy, :repo, :validator
end