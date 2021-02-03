class Participation < ApplicationRecord
  belongs_to :contest
  belongs_to :member
  
  has_many :chance_participations, dependent: :destroy
  has_many :chances, through: :chance_participations

  after_create :set_chance

  def set_chance
    with_lock do
      chances.create!(bet_type: :win)
      chances.create!(bet_type: :place)

      pids = contest.participations.pluck(:id)
      
      pids.each do |p|
        next if p == id

        chance = chances.create!(bet_type: :exacta)
        chance.chance_participations.create!(participation_id: p)
        chance = chances.create!(bet_type: :quinella)
        chance.chance_participations.create!(participation_id: p)
        chance = chances.create!(bet_type: :quinella_place)
        chance.chance_participations.create!(participation_id: p)
        
        pids.each do |q|
          next if q == id
          next if p == q

          chance = chances.create!(bet_type: :tierce)
          chance.chance_participations.create!(participation_id: p)
          chance.chance_participations.create!(participation_id: q)
          chance = chances.create!(bet_type: :trio)
          chance.chance_participations.create!(participation_id: p)
          chance.chance_participations.create!(participation_id: q)
        end
      end
    end
  end
end
