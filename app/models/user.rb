class User < ApplicationRecord
  validates_presence_of :email, :password_digest, :name
  has_secure_password

  enum status: %w(inactive active)
end
