require "application_system_test_case"

describe "Twitch OAuth Login", :system do
  before do
    OmniAuth.config.add_mock(:twitch, create(:twitch_oauth))
  end

  it "runs" do
    visit "/session"
    click_on "Login (Twitch)"

    visit "/session.json"
    # TODO: Flesh out actual session response
    assert_equal({ "role" => "viewer" }, JSON.parse(page.text))
  end
end
