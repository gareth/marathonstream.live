module Twitch
  autoload :Channel, "twitch/channel"
  autoload :User, "twitch/user"

  def self.use_relative_model_naming?
    true
  end

  def self.table_name_prefix
    "twitch_"
  end
end
