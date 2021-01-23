class CreateBets < ActiveRecord::Migration[6.1]
  def change
    create_table :chances do |t|
      t.references :participation, null: false, foreign_key: true, index: true
      t.integer :bet_type
      t.integer :rate
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    create_table :bets do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.integer :point, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.references :chance, null: false, foreign_key: true, index: true

      t.timestamps
    end
    add_index :bets, %i[user_id chance_id], unique: true
  end
end
