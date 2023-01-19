require "test_helper"

class StreamTest < ActiveSupport::TestCase
  it "requires a title" do
    stream = build(:stream, title: nil)

    refute stream.valid?
  end

  describe "#active" do
    it "excludes future events" do
      travel_to("2023-02-05 00:00:00") do
        create(:stream, starts_at: Time.now)
        create(:stream, starts_at: 1.second.from_now)
        create(:stream, starts_at: 1.month.from_now)

        assert_empty Stream.active
      end
    end

    it "excludes past events" do
      travel_to("2023-02-05 00:00:00") do
        create(:stream, starts_at: 1.second.ago, initial_duration: 1)
        create(:stream, starts_at: 1.week.ago, initial_duration: 1.day)

        assert_empty Stream.active
      end
    end

    it "includes active events" do
      travel_to("2023-02-05 00:00:00") do
        create(:stream, starts_at: 1.second.ago, initial_duration: 2)
        create(:stream, starts_at: 1.day.ago, initial_duration: 1.week)

        assert_equal 2, Stream.active.count
      end
    end
  end
end
