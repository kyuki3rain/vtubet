class User < ApplicationRecord
  has_secure_password
  
  has_many :bets
  has_many :contests

  enum authority: %i[normal admin]

  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  after_create :reset_point!

  def reset_point!
    point = 100_000
    save!
  end

  def add_point!(point)
    self.point += point
    save!
  end

  def reduce_point!(point)
    raise if self.point < point

    self.point -= point
    save!
  end

  def available_point
    point - bets.draft.sum(:point)
  end
end
