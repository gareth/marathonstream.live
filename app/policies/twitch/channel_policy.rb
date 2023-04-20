module Twitch
  class ChannelPolicy < ApplicationPolicy
    def show?
      true
    end

    def manage?
      %i[broadcaster admin].include? user.role
    end

    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      def resolve
        scope.all
      end
    end
  end
end
