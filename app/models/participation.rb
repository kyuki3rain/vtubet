class Participation < ApplicationRecord
  belongs_to :contest
  belongs_to :member
  
  has_many :chance_participations, dependent: :destroy
  has_many :chances, through: :chance_participations

  after_create :set_chance

  def set_chance
    chance = Chance.new(bet_type: :win)
    chance.chance_participations.build(participation_id: id)
    chance.save!

    chance = Chance.new(bet_type: :place)
    chance.chance_participations.build(participation_id: id)
    chance.save!

    participation_ids = contest.participations.pluck(:id)
    
    double_positions = [0, 1].permutation(2).to_a
    triple_positions = [0, 1, 2].permutation(3).to_a

    participation_ids.each do |p|
      next if p == id
      
      double_positions.each do |double_position|
        chance = Chance.new(bet_type: :exacta)
        chance.chance_participations.build(participation_id: id, position: double_position[0])
        chance.chance_participations.build(participation_id: p, position: double_position[1])
        chance.save!
      end
      
      chance = Chance.new(bet_type: :quinella)
      chance.chance_participations.build(participation_id: id)
      chance.chance_participations.build(participation_id: p)
      chance.save!
      
      chance = Chance.new(bet_type: :quinella_place)
      chance.chance_participations.build(participation_id: id)
      chance.chance_participations.build(participation_id: p)
      chance.save!

      participation_ids.each do |q|
        next if q == id
        next if p == q

        triple_positions.each do |triple_position|
          chance = Chance.new(bet_type: :tierce)
          chance.chance_participations.build(participation_id: id, position: triple_position[0])
          chance.chance_participations.build(participation_id: p, position: triple_position[1])
          chance.chance_participations.build(participation_id: q, position: triple_position[2])
          chance.save!
        end

        chance = Chance.new(bet_type: :trio)
        chance.chance_participations.build(participation_id: id)
        chance.chance_participations.build(participation_id: p)
        chance.chance_participations.build(participation_id: q)
        chance.save!
      end
    end
  end
end
