module Validator
  class CommentValidator < BaseValidator

    def valid?(params = {})
      fail if params[:comment].blank?
      fail if params[:comment].length > 180
    end

  end
end