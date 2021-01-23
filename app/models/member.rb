class Member < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :contests, through: :participations
end
