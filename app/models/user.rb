class User < ApplicationRecord
  has_secure_password
  validates :login, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? },
            confirmation: true
end
