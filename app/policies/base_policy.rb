class BasePolicy
  require_relative '../exceptions/policy_exception'

  def fail(msg = 'Validation Exception thrown')
    raise PolicyException.new(msg)
  end
end