module Validator
  class ReplyValidator < BaseValidator

    def valid?(reply)
      fail if reply.blank? || reply.length > 180
    end

  end
end