require "test_helper"

describe "FactoryBot" do
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
end
