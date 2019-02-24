class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.string :accepted, default: "pending"
      t.references :event, foreign_key: true
      t.belongs_to :invitee, index: true
      t.belongs_to :inviter, index: true

      t.timestamps
    end
  end
end
