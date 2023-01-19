require "test_helper"

class StreamTest < ActiveSupport::TestCase
  it "requires a title" do
    stream = build(:stream, title: nil)

    refute stream.valid?
  end
end
