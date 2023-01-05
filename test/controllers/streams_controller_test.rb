require "test_helper"

describe StreamsController do
  let(:channel) { create(:twitch_channel) }

  describe "with no streams" do
    describe "#index" do
      it "allows creation of a stream"
    end
  end

  describe "with a stream" do
    before do
      @stream = create(:stream, twitch_channel: channel)
    end

    it "should show stream" do
      get stream_url(@stream, subdomain: channel)
      assert_response :success
    end

    it "should get edit" do
      get edit_stream_url(@stream, subdomain: channel)
      assert_response :success
    end

    it "should update stream" do
      patch stream_url(@stream, subdomain: channel),
            params: { stream: { initial_duration: @stream.initial_duration, starts_at: @stream.starts_at,
                                twitch_channel_id: @stream.twitch_channel_id } }
      assert_redirected_to stream_url(@stream, subdomain: channel)
    end

    it "should destroy stream" do
      assert_difference("Stream.count", -1) do
        delete stream_url(@stream, subdomain: channel)
      end

      assert_redirected_to streams_url(subdomain: channel)
    end

    describe "#index" do
      it "shows the stream"
    end
  end
end
