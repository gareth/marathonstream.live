FactoryBot.define do
  factory :twitch_oauth, class: Hash do
    skip_create

    uid { "12345678" }
    display_name { "HeliX" }
    login { display_name.downcase }

    broadcaster_type { "" }

    token { "012345678901234567890123456789" }
    refresh_token { "01234567890123456789012345678901234567890123456789" }
    expires_at { Date.civil(2025, 1, 1) }

    avatar { "https://static-cdn.jtvnw.net/user-default-pictures-uv/cdd517fe-def4-11e9-948e-784f43822e80-profile_image-300x300.png" }

    initialize_with do
      {
        "provider" => "twitch",
        "uid" => uid,
        "info" => {
          "name" => display_name,
          "email" => nil,
          "nickname" => login,
          "description" => "",
          "image" => avatar,
          "urls" => {
            "Twitch" => "http://www.twitch.tv/#{login}"
          }
        },
        "credentials" => {
          "token" => token,
          "refresh_token" => refresh_token,
          "expires_at" => expires_at.to_time.to_i,
          "expires" => true
        },
        "extra" => {
          "raw_info" => {
            "id" => uid,
            "login" => login,
            "display_name" => display_name,
            "type" => "",
            "broadcaster_type" => broadcaster_type,
            "description" => "",
            "profile_image_url" => avatar,
            "offline_image_url" => "",
            "view_count" => 3489,
            "created_at" => "2015-01-01T00:00:00Z"
          }
        }
      }
    end
  end
end
