class StreamPolicy < ApplicationPolicy
  def index?
    user.role != :viewer
  end

  def show?
    true
  end

  def create?
    %i[broadcaster admin].include? user.role
  end

  def update?
    %i[broadcaster admin].include? user.role
  end

  def destroy?
    %i[broadcaster admin].include? user.role
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
