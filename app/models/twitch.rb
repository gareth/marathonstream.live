module Twitch
  autoload :Channel, "twitch/channel"
  autoload :User, "twitch/user"

  def self.table_name_prefix
    "twitch_"
  end
end
