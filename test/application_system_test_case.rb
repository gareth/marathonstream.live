require "test_helper"

OmniAuth.config.test_mode = true

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1200, 900]

  # Use this class for tests `describe`d with :system
  register_spec_type(self) do |_desc, *addl|
    addl.include? :system
  end
end

# Rails system test failure screenshots are based on the generated method name,
# which for MiniTest tests retain the spaces from the test description. When the
# image filename is output into the terminal, the spaces mean it's not clickable
# to open.
#
# This module overrides the screenshot filename helper to make it clickable
module ClickableScreenshotFilenames
  def image_name
    super.gsub(/\s+/, "_")
  end
end

ActionDispatch::SystemTesting::TestHelpers::ScreenshotHelper.prepend ClickableScreenshotFilenames
