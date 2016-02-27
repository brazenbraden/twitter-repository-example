class BaseValidator
  require_relative '../exceptions/validation_exception'

  def fail(msg = 'Validation Exception thrown')
    raise ValidationException.new(msg)
  end

end