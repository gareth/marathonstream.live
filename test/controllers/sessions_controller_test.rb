require "test_helper"

describe SessionsController do
  include AuthenticationTestHelper

  describe "when authenticated" do
    as(:viewer) do
      describe "#show" do
        it "returns profile information as JSON" do
          get session_url(format: :json)

          assert_equal "application/json", mime_type(response)
        end
      end
    end
  end

  def mime_type(response)
    header = response.headers["Content-Type"]
    content_type = header.match ActionDispatch::Response::CONTENT_TYPE_PARSER
    content_type[:mime_type]
  end
end
