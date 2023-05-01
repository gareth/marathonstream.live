module Twitch
  class User < ApplicationRecord
    validates :uid, presence: true
    validates :login, presence: true

    has_one :channel, class_name: "Twitch::Channel", foreign_key: :twitch_id, primary_key: :uid, required: false

    def to_s
      format("#<%<klass>s login=%<login>s scope=%<scope>p>", klass: self.class, login:, scope: token_scopes)
    end
  end
end
