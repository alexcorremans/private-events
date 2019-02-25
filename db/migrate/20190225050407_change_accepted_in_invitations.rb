class ChangeAcceptedInInvitations < ActiveRecord::Migration[5.2]
  def up
    change_column :invitations, :accepted, :boolean, default: false
  end

  def down
    change_column :invitations, :accepted, :string, default: "pending"
  end
end
