class Contest < ApplicationRecord
  belongs_to :user

  has_many :participations, dependent: :destroy
  has_many :chances, through: :participations
  has_many :members, through: :participations

  enum status: %i[draft published finished]

  def publish!
    published!
  end
end
