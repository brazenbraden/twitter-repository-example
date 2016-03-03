module Policy
  module User
    class CanCreateTweet < BasePolicy
      def check
        unless user.permissions.blank? || user.permissions[:tweet].blank?
          fail unless user.permissions[:tweet].include?(:can_create_tweet)
        else
          fail 'Invalid permissions'
        end
      end
    end
  end
end