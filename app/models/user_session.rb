class UserSession
  include ActiveModel::API

  attr_accessor :role, :identity

  validates :role, inclusion: { in: Role.values }

  def initialize(*)
    super
    @role ||= Role.viewer
  end
end
