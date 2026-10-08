class TiltifyWebhooksController < ApplicationController
  skip_forgery_protection

  def create
    data = Integrations::Tiltify::Webhooks.verify(request)
    Rails.logger.info(data.pretty_inspect)

    head :ok
  end
end
