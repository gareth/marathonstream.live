module Twitch
  class User < ApplicationRecord
    validates :uid, presence: true
    validates :login, presence: true

    def to_s
      format("#<%<klass>s login=%<login>s scope=%<scope>p>", klass: self.class, login:, scope: token_scopes)
    end
  end
end
