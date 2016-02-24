module Policy
  module User
    class CanCreateTweet
      attr_accessor :user

      def initialize(user)
        @user = user
      end

      def check
        true
      end

    end
  end
end