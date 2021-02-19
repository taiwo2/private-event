class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.integer :attendee_id, null: false
      t.integer :attended_event_id, null: false


      t.timestamps
    end
    add_index :invitations, :attended_id
    add_index :invitations, :attended_event_id

  end
end
