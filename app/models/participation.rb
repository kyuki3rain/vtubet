class Participation < ApplicationRecord
  belongs_to :contest
  belongs_to :member
  
  has_many :chances

  after_create :set_chance

  def set_chance
    chances.create!(
      bet_type: :win,
      rate: 1
    )
  end
end
