module Integrations
  class Tiltify
    module Webhooks
      def self.verify(request, signing_id: ENV.fetch("TILTIFY_WEBHOOK_SIGNING_ID"))
        headers = request.headers.reject { |key, _| key.include?(".") }.to_h

        signature = headers.fetch("HTTP_X_TILTIFY_SIGNATURE", nil)
        timestamp = headers.fetch("HTTP_X_TILTIFY_TIMESTAMP", nil)

        Rails.logger.debug("Tiltify webhook headers: #{headers.pretty_inspect}")
        Rails.logger.debug("Tiltify webhook signature: #{signature}")
        Rails.logger.debug("Tiltify webhook timestamp: #{timestamp}")

        body = request.body.read
        payload = "#{timestamp}.#{body}"

        Rails.logger.debug("Signing payload #{payload} with signing_id: #{signing_id}")

        signature_calculated = OpenSSL::HMAC.base64digest("SHA256", signing_id, payload)
        Rails.logger.debug("Calculated signature: #{signature_calculated}")

        raise "Invalid Tiltify webhook signature" unless signature_calculated == signature

        JSON.parse(body)
      end
    end
  end
end
