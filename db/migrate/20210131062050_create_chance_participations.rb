class CreateChanceParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :chance_participations do |t|
      t.references :chance, null: false, foreign_key: true, index: false
      t.references :participation, null: false, foreign_key: true, index: true
      
      t.timestamps
    end
    add_index :chance_participations, %i[chance_id participation_id], unique: true
    remove_reference :chances, :participation

    change_column :chances, :rate, :integer, default: 1
  end
end
