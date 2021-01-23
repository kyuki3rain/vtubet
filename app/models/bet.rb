class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :chance

  enum status: %i[draft unpaid paid]

  def publish!
    unpaid!
  end
end
