module Policy
  module User
    class CanCreateTweet
      attr_accessor :user

      def initialize(user)
        @user = user
      end

      def check

      end

    end
  end
end