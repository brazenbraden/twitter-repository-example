module Policy
  module User
    class CanCreateTweet < BasePolicy
      attr_accessor :user

      def initialize(user)
        @user = user
      end

      def check
        unless user.permissions.blank? || user.permissions[:tweet].blank?
          fail unless user.permissions[:tweet].include?(:can_create_tweet)
        else
          fail 'Invalid permissions'
        end
      end

      private
      attr_reader :user
    end
  end
end