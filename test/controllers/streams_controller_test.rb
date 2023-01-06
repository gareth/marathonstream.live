require "test_helper"

describe StreamsController do
  include AuthenticationTestHelper

  use_channel

  describe "#index" do
    describe "with no streams" do
      as_a(:viewer) do
        it "shows an empty page"
      end

      as_a(:moderator) do
        it "shows an empty page"
      end

      as_a(:broadcaster) do
        it "shows the option to create a stream"
      end
    end

    describe "with a stream" do
      before do
        @stream = create(:stream, twitch_channel: channel)
      end

      it "shows the stream" do
        get stream_url(@stream)

        assert_response :success
      end
    end
  end

  describe "#create" do
    as_a(:broadcaster) do
      describe "with valid parameters" do
        let(:params) { build(:stream).attributes }

        it "creates a Stream" do
          assert_difference("Stream.count") do
            post streams_url(stream: params)
          end
        end

        it "redirects to the new Stream" do
          post streams_url(stream: params)

          assert_redirected_to stream_url(Stream.last)
        end
      end

      describe "with invalid parameters" do
        it "fails"
      end
    end
  end

  describe "with a stream" do
    before do
      @stream = create(:stream, twitch_channel: channel)
    end

    describe "#edit" do
      before do
        @stream = create(:stream, twitch_channel: channel)
      end

      as_a(:viewer) do
        it "fails"
      end

      as_a(:moderator, :broadcaster, :admin) do
        it "shows the edit form" do
          get edit_stream_url(@stream)

          assert_response :success
        end
      end
    end

    describe "#update" do
      as_a(:broadcaster) do
        it "updates the stream" do
          patch stream_url(@stream),
                params: { stream: { initial_duration: @stream.initial_duration, starts_at: @stream.starts_at,
                                    twitch_channel_id: @stream.twitch_channel_id } }

          assert_redirected_to stream_url(@stream)
        end
      end
    end

    describe "#destroy" do
      as_a(:broadcaster, :admin) do
        it "destroys the stream" do
          assert_difference("Stream.count", -1) do
            delete stream_url(@stream)
          end

          assert_redirected_to streams_url
        end
      end
    end
  end
end
