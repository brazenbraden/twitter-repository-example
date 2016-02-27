class PolicyException < StandardError
  def initialize(error)
    super(error)
  end
end