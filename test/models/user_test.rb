require "test_helper"

describe User do
  it "has a default role" do
    assert_equal :viewer, User.new.role
  end

  it "can have a role defined" do
    assert_equal :moderator, User.new(role: :moderator).role
  end

  it "can't have an invalid role defined" do
    refute User.new(role: :foo).valid?
  end
end
