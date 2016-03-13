module Validator
  class ReplyValidator < BaseValidator

    def valid?(params = {})
      fail 'Reply cannot be blank' if params[:content].blank?
      fail 'Reply cannot be longer than 180 characters' if params[:content].length > 180
    end

  end
end