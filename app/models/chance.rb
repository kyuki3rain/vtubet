class Chance < ApplicationRecord
  has_many :bets
  has_many :chance_participations, dependent: :destroy
  has_many :participations, through: :chance_participations

  enum status: %i[unpaid paid]
  enum bet_type: %i[win place exacta quinella quinella_place tierce trio]
  # 左から順に、[単勝 複勝 馬単 馬連 ワイド 三連単 三連複]

  validate :participations_count
  # validate :diff_position

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

  def participations_count
    if win? || place?
      errors.add(:bet_type, ": #{bet_type}の対象は1名である必要があります。") unless chance_participations.length == 1
    elsif exacta? || quinella? || quinella_place?
      errors.add(:bet_type, ": #{bet_type}の対象は2名である必要があります。") unless chance_participations.length == 2
      if exacta? && chance_participations.map(&:position).sort != [*0..1]
        errors.add(:bet_type, ": #{bet_type}は順番が指定されている必要があります。")
      end
    elsif tierce? || trio?
      errors.add(:bet_type, ": #{bet_type}の対象は3名である必要があります。") unless chance_participations.length == 3
      if tierce? && chance_participations.map(&:position).sort != [*0..2]
        errors.add(:bet_type, ": #{bet_type}は順番が指定されている必要があります。")
      end
    end
  end
end
