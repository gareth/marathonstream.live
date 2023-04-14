require "test_helper"

describe StreamsController do
  include AuthenticationTestHelper

  use_channel

  describe "#index" do
    describe "with no streams" do
      as(:moderator, :broadcaster, :admin) do
        it "renders the page" do
          get streams_url

          assert_response :success
        end
      end

      otherwise do
        it "is restricted" do
          get streams_url

          assert_response :forbidden
        end
      end
    end

    describe "with an active stream" do
      before do
        @stream = create(:stream, twitch_channel: channel)
      end

      as_anyone do
        it "shows the stream" do
          get stream_url(@stream)

          assert_response :success
        end
      end
    end
  end

  describe "#create" do
    let(:params) { build(:stream).attributes }

    as(:admin, :broadcaster) do
      describe "with valid parameters" do
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
    end

    otherwise do
      it "is restricted" do
        post streams_url(stream: params)

        assert_response :forbidden
      end
    end
  end

  describe "with a stream" do
    before do
      @stream = create(:stream, twitch_channel: channel)
    end

    describe "#edit" do
      as(:moderator, :broadcaster, :admin) do
        it "shows the edit form" do
          get edit_stream_url(@stream)

          assert_response :success
        end
      end

      otherwise do
        it "is restricted" do
          get edit_stream_url(@stream)

          assert_response :forbidden
        end
      end
    end

    describe "#update" do
      as(:moderator, :broadcaster, :admin) do
        it "updates the Stream" do
          assert_changes -> { @stream.reload.updated_at } do
            patch stream_url(@stream), params: { stream: { initial_duration: @stream.initial_duration + 1 } }
          end
        end

        it "redirects to the Stream URL" do
          patch stream_url(@stream), params: { stream: { initial_duration: @stream.initial_duration + 1 } }

          assert_redirected_to stream_url(@stream)
        end
      end

      otherwise do
        it "doesn't update the Stream" do
          assert_no_changes -> { @stream.reload.updated_at } do
            patch stream_url(@stream), params: { stream: { initial_duration: @stream.initial_duration + 1 } }
          end
        end

        it "is restricted" do
          patch stream_url(@stream)

          assert_response :forbidden
        end
      end
    end

    describe "#destroy" do
      as(:broadcaster, :admin) do
        it "destroys the stream" do
          assert_difference("Stream.count", -1) do
            delete stream_url(@stream)
          end

          assert_redirected_to streams_url
        end
      end

      otherwise do
        it "doesn't delete the Stream" do
          assert_no_changes("Stream.count") do
            delete stream_url(@stream)
          end
        end

        it "is restricted" do
          delete stream_url(@stream)

          assert_response :forbidden
        end
      end
    end
  end
end
