module Validator
  class TweetValidator < BaseValidator

    def valid?(params = {})
      fail 'Tweet cannot be blank' if params[:tweet].blank?
      fail 'Tweet is too long' if params[:tweet].length > 180
    end

  end
end