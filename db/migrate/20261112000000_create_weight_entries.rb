class CreateWeightEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :weight_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.date :recorded_on, null: false
      t.decimal :weight, precision: 8, scale: 2, null: false

      t.timestamps
    end

    add_index :weight_entries, [:user_id, :recorded_on]
  end
end
