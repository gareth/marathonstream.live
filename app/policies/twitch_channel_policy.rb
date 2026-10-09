class TwitchChannelPolicy < ApplicationPolicy
  def show?
    true
  end

  def manage?
    super || user.role == :broadcaster
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
