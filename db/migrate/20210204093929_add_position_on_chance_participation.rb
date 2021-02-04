class AddPositionOnChanceParticipation < ActiveRecord::Migration[6.1]
  def change
    add_column :chance_participations, :position, :integer, null: false, default: 0
  end
end
