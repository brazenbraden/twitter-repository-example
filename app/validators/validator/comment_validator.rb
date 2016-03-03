module Validator
  class CommentValidator < BaseValidator

    def valid?(comment)
      fail if comment.blank?
      fail if comment.length > 180
    end

  end
end