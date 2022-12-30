Twitch::Channel.find_or_create_by!(username: "helix") do |c|
  c.twitch_id = 42
  c.display_name = "HeliX"
end
