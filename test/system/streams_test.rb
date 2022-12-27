require "application_system_test_case"

describe "Stream management", :system do
  let(:target_channel) { "helix" }
  let(:channel) { create(:twitch_channel, twitch_display_name: target_channel) }
  let(:stream) { create(:stream) }

  it "allows listing streams" do
    visit streams_url(subdomain: channel)
    assert_selector "h1", text: "Streams"
  end

  it "allows creating streams" do
    new_stream_params = build(:stream, twitch_channel: channel)

    visit streams_url(subdomain: channel)
    click_on "New stream"

    fill_in "Starts at", with: new_stream_params.starts_at
    fill_in "Initial duration", with: new_stream_params.initial_duration
    fill_in "Twitch channel", with: new_stream_params.twitch_channel_id
    click_on "Create Stream"

    assert_text "Stream was successfully created"
    click_on "Back"
  end

  it "allows updating streams" do
    visit stream_url(stream, subdomain: channel)
    click_on "Edit this stream", match: :first

    fill_in "Starts at", with: stream.starts_at
    fill_in "Initial duration", with: stream.initial_duration
    fill_in "Twitch channel", with: stream.twitch_channel_id
    click_on "Update Stream"

    assert_text "Stream was successfully updated"
    click_on "Back"
  end

  it "allows destroying streams" do
    visit stream_url(stream, subdomain: channel)
    click_on "Destroy this stream", match: :first

    assert_text "Stream was successfully destroyed"
  end
end
