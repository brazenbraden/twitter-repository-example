module Policy
  module User
    class CanCreateReply < BasePolicy

      def check
        unless user.permissions.blank? || user.permissions[:reply].blank?
          fail unless user.permissions[:reply].include?(:can_create_reply)
        else
          fail
        end
      end

    end
  end
end