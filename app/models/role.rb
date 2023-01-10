class Role
  include Ruby::Enum

  %i[anonymous viewer moderator broadcaster admin].each do |role|
    define role
  end
end
