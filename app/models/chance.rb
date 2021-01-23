class Chance < ApplicationRecord
  belongs_to :participation

  has_many :bets

  enum status: %i[unpaid paid]
  enum bet_type: %i[win place quinella quinella_place tierce trio]
  # 左から順に、[単勝　複勝　馬連　ワイド　三連単　三連複]

  def calc!
    all_point = Bet.where.not(status: :draft).joins(chance: :participation)
                   .where(
                      participation: { contest_id: participation.contest_id },
                      chance: { bet_type: bet_type }
                    ).sum(:point)
    chance_point = bets.where.not(status: :draft).sum(:point)
    if chance_point != 0
      self.rate = (all_point / chance_point) * participation.contest.refund
    else
      self.rate = 0
    end
    save!

    rate
  end
end
