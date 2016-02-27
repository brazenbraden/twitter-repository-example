class ValidationException < StandardError
  def initialize(error)
    super(error)
  end
end