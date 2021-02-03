class CreateContests < ActiveRecord::Migration[6.1]
  def change
    create_table :contests do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.integer :refund
      t.integer :status
      t.string :title

      t.timestamps
    end
  end
end
