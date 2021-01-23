class CreateParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :participations do |t|
      t.references :contest, null: false, foreign_key: true, index: false
      t.references :member, null: false, foreign_key: true, index: true
      t.integer :rank

      t.timestamps
    end
    add_index :participations, %i[contest_id member_id], unique: true
  end
end
