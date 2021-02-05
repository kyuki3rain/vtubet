class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :chance

  enum status: %i[draft unpaid paid]

  validate :has_enough_points?

  def publish!
    user.reduce_point!(point)
    unpaid!
    chance.calc!
  end
  
  def pay!
    user.add_point!(point * chance.rate)
    unpaid!
  end

  def has_enough_points?
    user.available_point >= point
  end
end
