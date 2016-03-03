module Policy
  module User
    class CanCreateComment < BasePolicy

      def check
        unless user.permissions.blank? || user.permissions[:comment].blank?
          fail unless user.permissions[:comment].include?(:can_create_comment)
        else
          fail
        end
      end

    end
  end
end