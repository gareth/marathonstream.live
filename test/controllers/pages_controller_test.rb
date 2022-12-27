require "test_helper"

describe PagesController do
  it "must get home" do
    get root_url

    assert_response :success
  end
end
