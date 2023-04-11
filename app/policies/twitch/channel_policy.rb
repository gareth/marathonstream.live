module Twitch
  class ChannelPolicy < ApplicationPolicy
    def create?
      %i[broadcaster admin].include? user.role
    end

    def show?
      true
    end

    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      def resolve
        scope.all
      end
    end
  end
end
