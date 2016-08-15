class User < ApplicationRecord
  attr_accessor :display_name, :admin
  validates :login, presence: true

  def self.from_jwt(data = { })
    id, login = data&.values_at 'id', 'login'
    return unless id && login

    User.first_or_create(id: id, login: login).tap do |user|
      user.display_name = data['dname']
      user.admin = data['admin'] == true # explicit
    end
  end
end
