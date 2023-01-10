require "test_helper"

describe UserSession do
  it "has a default role" do
    assert_equal Role.viewer, UserSession.new.role
  end

  it "can have a role defined" do
    assert_equal Role.moderator, UserSession.new(role: :moderator).role
    assert_equal Role.admin, UserSession.new(role: Role.admin).role
  end

  it "can't have an invalid role defined" do
    refute UserSession.new(role: :foo).valid?
  end
end
