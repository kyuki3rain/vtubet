class CreateChances < ActiveRecord::Migration[6.1]
  def change
    create_table :chances do |t|
      t.references :participation, null: false, foreign_key: true, index: true
      t.integer :bet_type
      t.integer :rate
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
