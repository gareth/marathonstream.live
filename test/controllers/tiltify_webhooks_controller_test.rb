require "test_helper"

describe TiltifyWebhooksController do
  describe "#create" do
    test "returns http success for valid data" do
      fixture = http_fixture(tiltify_fixture_path("donation-updated.http"))

      post tiltify_webhook_url, headers: fixture.headers, env: { RAW_POST_DATA: fixture.body.chomp }

      assert_response :success
    end

    test "returns http bad request for invalid data" do
      fixture = http_fixture(tiltify_fixture_path("donation-updated.http"))

      fixture.headers["HTTP_X_TILTIFY_SIGNATURE"] << "invalid"

      assert_raises do
        post tiltify_webhook_url, headers: fixture.headers, env: { RAW_POST_DATA: fixture.body.chomp }
      end
    end
  end
end

HTTPFixture = Struct.new(:headers, :body)

def tiltify_fixture_path(filename)
  Rails.root.join("test", "fixtures", "files", "webhooks", "tiltify", filename)
end

def http_fixture(path)
  # The file contains raw HTTP headers and body for the fixture
  raw = File.read(path)
  headers, body = raw.split("\n\n", 2)
  headers_hash = headers.split("\n").each_with_object({}) do |line, hash|
    key, value = line.split(": ", 2)
    next if key.nil? || value.nil?

    hash[key] = value
  end
  headers_hash.transform_keys! { |key| "HTTP_#{key.upcase.tr('-', '_')}" }
  HTTPFixture.new(headers_hash, body)
end
