class User
  include ActiveModel::API

  attr_accessor :role

  validates :role, inclusion: { in: %i[viewer moderator broadcaster admin] }

  def initialize(*)
    super
    @role ||= :viewer
  end
end
