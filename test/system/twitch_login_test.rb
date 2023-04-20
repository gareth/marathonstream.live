require "application_system_test_case"

describe "Twitch OAuth Login", :system do
  def login_via_navbar
    visit root_url
    click_on "Login (Twitch)"
  end

  describe "a new user" do
    let(:oauth) { create(:twitch_oauth) }

    before do
      OmniAuth.config.add_mock(:twitch, oauth)
    end

    it "logs in as the user" do
      login_via_navbar

      assert_content oauth.fetch("info").fetch("name")
    end
  end

  describe "an existing user" do
    let(:user) { create(:twitch_user) }
    let(:oauth) { create(:twitch_oauth, uid: user.uid) }

    before do
      OmniAuth.config.add_mock(:twitch, oauth)
    end

    it "logs in as the user" do
      login_via_navbar

      assert_content oauth.fetch("info").fetch("name")
    end
  end
end
