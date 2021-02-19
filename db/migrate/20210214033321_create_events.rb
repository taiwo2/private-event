class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false, default: ''
      t.string :location
      t.datetime :event_date
      t.text :description
      t.integer :creator_id, null: false

      t.timestamps
    end

    add_index :events, [:event_date, :creator_id]
  end
end
