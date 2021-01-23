class User < ApplicationRecord
  has_secure_password
  
  has_many :bets
  has_many :contests

  enum authority: %i[normal admin]

  validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
