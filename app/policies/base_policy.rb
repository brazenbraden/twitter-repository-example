class BasePolicy
  require_relative '../exceptions/policy_exception'

  def initialize(user)
    @user = user
  end

  def fail(msg = 'Validation Exception thrown')
    raise PolicyException.new(msg)
  end

  private
  attr_reader :user
end