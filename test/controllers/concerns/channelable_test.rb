require "test_helper"

class ChannelableItemsController < TestController
  include Channelable

  def index
    render json: twitch_channel
  end
end

describe Channelable, :integration do
  setup do
    draw_test_routes do
      resources :channelable_items
      resources :regular_items
    end

    # We make three `Twitch::Channel`s to ensure that the controller isn't just
    # picking the first/last
    create(:twitch_channel)
    @target_channel = create(:twitch_channel)
    create(:twitch_channel)

    subdomain! @target_channel.username
  end

  it "loads channel information from the subdomain" do
    get channelable_items_url

    result = JSON.parse(response.body)

    assert_equal result, @target_channel.as_json
  end
end
