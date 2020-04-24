class AddRolesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :superadmin_role, :boolean, default: false, null: false
    add_column :users, :organizer_role, :boolean, default: false, null: false
    add_column :users, :user_role, :boolean, default: true, null: false
  end
end
