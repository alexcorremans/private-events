class ChangeAcceptedInInvitations < ActiveRecord::Migration[5.2]
  def up
    change_column_default :invitations, :accepted, nil
    change_column :invitations, :accepted, :boolean, default: false, using: 'accepted::boolean'
  end

  def down
    change_column_default :invitations, :accepted, nil
    change_column :invitations, :accepted, :string, default: "pending"
  end
end
