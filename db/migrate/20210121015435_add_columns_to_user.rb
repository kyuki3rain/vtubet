class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.integer :authority, null: false, default: 0
      t.integer :point, null: false, default: 0
    end
  end
end
