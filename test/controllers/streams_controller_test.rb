require "test_helper"

class StreamsControllerTest < ActionDispatch::IntegrationTest
  let(:channel) { create(:twitch_channel) }
  setup do
    @stream = create(:stream, twitch_channel: channel)
  end

  test "should get index" do
    get streams_url(subdomain: channel)
    assert_response :success
  end

  test "should get new" do
    get new_stream_url(subdomain: channel)
    assert_response :success
  end

  test "should create stream" do
    assert_difference("Stream.count") do
      post streams_url(subdomain: channel),
           params: { stream: { initial_duration: @stream.initial_duration, starts_at: @stream.starts_at,
                               twitch_channel_id: @stream.twitch_channel_id } }
    end

    assert_redirected_to stream_url(Stream.last, subdomain: channel)
  end

  test "should show stream" do
    get stream_url(@stream, subdomain: channel)
    assert_response :success
  end

  test "should get edit" do
    get edit_stream_url(@stream, subdomain: channel)
    assert_response :success
  end

  test "should update stream" do
    patch stream_url(@stream, subdomain: channel),
          params: { stream: { initial_duration: @stream.initial_duration, starts_at: @stream.starts_at,
                              twitch_channel_id: @stream.twitch_channel_id } }
    assert_redirected_to stream_url(@stream, subdomain: channel)
  end

  test "should destroy stream" do
    assert_difference("Stream.count", -1) do
      delete stream_url(@stream, subdomain: channel)
    end

    assert_redirected_to streams_url(subdomain: channel)
  end
end
