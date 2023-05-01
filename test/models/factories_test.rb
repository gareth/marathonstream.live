require "test_helper"

describe "FactoryBot", :model do
  # We could just call `FactoryBot.lint(traits: true)` once, but I like having
  # specific test failures when relevant
  FactoryBot.factories.each do |factory|
    it "has a valid #{factory.name.inspect} factory" do
      conn = ActiveRecord::Base.connection
      conn.transaction do
        FactoryBot.lint([factory], traits: true)
        raise ActiveRecord::Rollback
      end
    end
  end

  describe "UserSession factory" do
    it "creates an associated Twitch::User when necessary" do
      assert create(:user_session, :admin).identity,        "Expected identity created with admin session"
      refute create(:user_session, :anonymous).identity,    "Expected no identity created with anonymous session"
      assert create(:user_session, :broadcaster).identity,  "Expected identity created with broadcaster session"
      assert create(:user_session, :moderator).identity,    "Expected identity created with moderator session"

      # TODO: it probably should
      refute create(:user_session, :viewer).identity,       "Expected no identity created with viewer session"
    end
  end
end
