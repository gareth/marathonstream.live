require "test_helper"
require "integrations/tiltify/webhooks"

describe Integrations::Tiltify::Webhooks do
  describe "#verify" do
    it "raises an error for invalid signature" do
      request = Minitest::Mock.new
      request.expect :headers, {
        "HTTP_X_TILTIFY_SIGNATURE" => "invalid",
        "HTTP_X_TILTIFY_TIMESTAMP" => "1234567890"
      }
      request.expect :body, StringIO.new("{}")

      assert_raises(RuntimeError) do
        Integrations::Tiltify::Webhooks.verify(request, signing_id: "deadbeef")
      end
    end

    it "returns parsed JSON for valid signature" do
      # Values taken from Tiltify webhook documentation
      # See: https://developers.tiltify.com/docs/webhooks/receiving-webhooks/verifying
      body = %({"data":{"amount":{"currency":"USD","value":"82.95"},"campaign_id":"a4fd5207-bd9f-4712-920a-85f8d92cf4e6","completed_at":"2023-04-18T16:48:26.510702Z","created_at":"2023-04-18T03:36:36.510717Z","donor_comment":"Rerum quo necessitatibus voluptas provident ad molestiae ipsam.","donor_name":"Jirachi","fundraising_event_id":null,"id":"dfa25dcc-2026-4320-a5b7-5da076efeb05","legacy_id":0,"poll_id":null,"poll_option_id":null,"reward_id":null,"sustained":false,"target_id":null,"team_event_id":null},"meta":{"attempted_at":"2023-04-18T16:49:00.617031Z","event_type":"public:direct:donation_updated","generated_at":"2023-04-18T16:48:59.510758Z","id":"d8768e26-1092-4f4c-a829-a2698cd19664","subscription_source_id":"00000000-0000-0000-0000-000000000000","subscription_source_type":"test"}}) # rubocop:disable Layout/LineLength
      timestamp = "2023-04-18T16:49:00.617031Z"
      signature = "4OSwlhTt0EcrlSQFlqgE18FOtT+EKX4qTJdJeC8oV/o="
      signing_id = "13c3b68914487acd1c68d85857ee1cfc308f15510f2d8e71273ee0f8a42d9d00"

      request = Minitest::Mock.new
      request.expect :headers, {
        "HTTP_X_TILTIFY_SIGNATURE" => signature,
        "HTTP_X_TILTIFY_TIMESTAMP" => timestamp
      }
      request.expect :body, StringIO.new(body)

      result = Integrations::Tiltify::Webhooks.verify(request, signing_id: signing_id)
      assert_equal(JSON.parse(body), result)
    end
  end
end
