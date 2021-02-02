class Chance < ApplicationRecord
  has_many :bets
  has_many :chance_participations, dependent: :destroy
  has_many :participations, through: :chance_participations

  enum status: %i[unpaid paid]
  enum bet_type: %i[win place exacta quinella quinella_place tierce trio]
  # 左から順に、[単勝 複勝 馬単 馬連 ワイド 三連単 三連複]

  def calc!
    contest = participations.first.contest
    all_point = Bet.where.not(status: :draft).joins(chance: :participations)
                   .where(
                      participations: { contest_id: contest.id },
                      chance: { bet_type: bet_type }
                    ).sum(:point)
    chance_point = bets.where.not(status: :draft).sum(:point)
    if chance_point != 0
      self.rate = (all_point / chance_point) * contest.refund
    else
      self.rate = 0
    end

    save!
  end
end
